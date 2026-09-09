#!/usr/bin/env python3
"""
Generate Control Expert Animation Tables as .xtb (TABExchangeFile) from sim_* vars.

MAJOR-equipment grouping (coarser): ~10–25 tables per PLC, not one per Drive.

For each PLC (BSR130, BSR131, BSR132):
  - Collect typed sim_* declarations from XST <variables name= typeName=>
  - Also collect sim_* referenced in ST even if only referenced (skip POU/type names)
  - Group by MAJOR equipment / area (fold PP/FN/HP/GA/LU/CH/MT/… under parent;
    keep BCV131A/B/C when those are distinct conveyors; fold DX/panel/PLC under BSR*)
  - Write one <MajorID>.xtb TABExchangeFile per major table
  - Write _index.csv (TableName, VarCount) and README.txt

PouOwner / contentHeader name = BPL130 / BPL131 / BPL132 (from XST contentHeader).

Outputs written to:
  /workspace/testing/Outputs/<PLC>/AnimationTables/
  /workspace/Projects-repo/2026 BS1/Testing/Outputs/<PLC>/AnimationTables/
"""

from __future__ import annotations

import csv
import re
import shutil
from collections import defaultdict
from datetime import datetime
from pathlib import Path
from xml.sax.saxutils import escape

try:
    import openpyxl
except ImportError:
    openpyxl = None

ROOT = Path("/workspace/testing")
INPUTS = ROOT / "Inputs"
OUTPUTS = ROOT / "Outputs"
REPO_TESTING = Path("/workspace/Projects-repo/2026 BS1/Testing")
REPO_OUTPUTS = REPO_TESTING / "Outputs"
REPO_INPUTS = REPO_TESTING / "Inputs"
SITES = ("BSR130", "BSR131", "BSR132")

# Elementary / array types useful in animation tables
ELEMENTARY_TYPES = {
    "EBOOL", "BOOL", "INT", "DINT", "UINT", "UDINT", "WORD", "DWORD",
    "REAL", "TIME", "DATE", "STRING",
}

# Known global / control sim tags (exact, case-insensitive match after strip)
GLOBAL_EXACT = {
    "sim_init", "sim_SetHealthy", "Sim_EquipBlocks", "sim_EHC_ScnTm",
    "sim_TeSysT_MstIP", "Sim_FTxx_rand", "sim_CBStatus",
}

# Type names that appear as ST refs but are not instance variables
SKIP_REF_NAMES = {
    "sim_AHI_Scale", "sim_CBSts", "sim_X80AHI0812", "sim_X80ART0814",
    "sim_X80EHC0800", "sim_noc0301", "sim_rex640", "sim_Equipment",
    "sim_Initialise", "sim_PLC_IOmap", "sim_PLC_module", "SIM_TeSysT",
    "SIM_Brake", "SIM_CRA31210", "SIM_X80DDI3202K", "SIM_X80DDO1602K",
    "SIM_BMEP586x4xRIO", "SIM_FlexiSoft", "sim_CBStatus",
}

# Trailing device / signal tokens stripped when deriving equipment id
DEVICE_TOKEN_RE = re.compile(
    r"("
    r"CB\d{2}|CAX\d{2}|SY\d{2}|VDC\d{2}|VAC\d{2}|TRP\d{2}|"
    r"XS\d{2}|ZS\d{2}|FS\d{2}|LS\d{2}|FIT\d{2}|FQ\d{2}|SS\d{2}|ZQ\d{2}|"
    r"PWS\d{2}|IS\d{2}|HS\d{2}|PS\d{2}|TS\d{2}|VS\d{2}|WS\d{2}|ES\d{2}|"
    r"LT\d{2}|PT\d{2}|TT\d{2}|FT\d{2}|ZT\d{2}|WT\d{2}|IT\d{2}|XT\d{2}|"
    r"SV\d{2}|SR\d{2}|EM\d{2}|PN\d{2}|UI\d{2}|RTD\d{2}|PR\d|"
    r"SpdGain|SP|Mode|Flt|ComFlt|LnkFlt|ModFlt|"
    r"Grp\d(?:DDI|DDO|flt)?|Ch\d{2}PV|_SetTrp|_Rst|"
    r"_I|_O|_PV|_Spd|_Gain"
    r")$",
    re.IGNORECASE,
)

# After a letter-conveyor major (…131A), rest must start with a 2+ letter device code
DEVICE_PREFIX_RE = re.compile(
    r"^(PP|FN|HP|GA|LU|CH|HT|BK|BP|GB|MA|MT|VS|SM|DX|WN|CP|DY|RV|DA|CC|DB|"
    r"AC|BC|UP|PN|FIP|NEP|FV|LS|UI|RTD|EM|INC|FDR|SHMI|HOP|PLM|IT|RT|"
    r"AFN|BFN|CFN|AVS|BVS|CVS|AGB|BGB|CGB|APP|BPP|CPP)",
    re.I,
)

VAR_DECL_RE = re.compile(
    r'<variables\s+name="([^"]+)"\s+typeName="([^"]+)"([^>]*)>(.*?)</variables>',
    re.S | re.I,
)
COMMENT_RE = re.compile(r"<comment>(.*?)</comment>", re.S | re.I)
SIM_REF_RE = re.compile(r"\b([Ss]im_[A-Za-z0-9_]+)\b")

# ST comment → DFB instance maps
TESYST_MAP_RE = re.compile(
    r"\(\*\s*([A-Za-z0-9_]+)\s+TeSysT[^*]*\*\)\s*(SIM_TeSysT_\d+)", re.I
)
CBSTS_MAP_RE = re.compile(
    r"\(\*\s*([A-Za-z0-9_]+)\s*\*\)\s*(sim_CBSts_\d+)", re.I
)
AHI_MAP_RE = re.compile(
    r"\(\*\s*([A-Za-z0-9_]+)\s*[—\-–][^*]{0,160}\*\)\s*(sim_AHI_Scale_\d+)"
)
MODULE_DFB_RE = re.compile(
    r"\(\*\s*[A-Z0-9]+\s*-\s*([A-Za-z0-9_]*(?:DX\d{2}|PLM\d+)[A-Za-z0-9_]*)\s*\*\)\s*"
    r"((?:sim_|SIM_)[A-Za-z0-9_]+)",
    re.I,
)
CRA_MAP_RE = re.compile(
    r"\(\*\s*=+\s*([A-Za-z0-9_]+)\s*-\s*DROP[^*]*\*\)\s*(SIM_CRA31210_\d+)",
    re.I,
)
EHC_MAP_RE = re.compile(
    r"sim_X80EHC0800_(\d+)\s*\([^)]*?iFlt\s*:=\s*sim_([A-Za-z0-9_]+)_ModFlt",
    re.S | re.I,
)
BRAKE_MAP_RE = re.compile(
    r"\(\*\s*([A-Za-z0-9_]+)[^*]*[Bb]rake[^*]*\*\)\s*(SIM_Brake_\d+)",
)
GENERIC_INST_MAP_RE = re.compile(
    r"\(\*\s*([A-Za-z0-9_]{4,})\b[^*]{0,80}\*\)\s*"
    r"((?:SIM_|sim_|Sim_)[A-Za-z0-9_]*_\d+)\s*\(",
)


def sanitize_filename(name: str) -> str:
    """Keep readable EquipmentID; strip spaces/special chars."""
    name = name.strip().replace(" ", "_").replace("/", "_").replace("&", "_")
    name = re.sub(r"[^A-Za-z0-9_\-]+", "_", name)
    name = re.sub(r"_+", "_", name).strip("_")
    return name or "_Unknown"


def strip_sim_prefix(name: str) -> str:
    if name.lower().startswith("sim_"):
        return name[4:]
    return name


def load_drives(site: str) -> list[str]:
    """Collect Drive names from Sub + Field IO Assignment; longest first."""
    xlsx = INPUTS / f"{site}_IO_List.xlsx"
    drives: set[str] = set()
    if openpyxl is None or not xlsx.exists():
        return []
    wb = openpyxl.load_workbook(xlsx, read_only=True, data_only=True)
    for sheet in wb.sheetnames:
        ws = wb[sheet]
        headers = None
        for row in ws.iter_rows(values_only=True):
            if headers is None:
                headers = [str(h).strip() if h is not None else "" for h in row]
                continue
            if "Drive" not in headers:
                continue
            di = headers.index("Drive")
            if di < len(row) and row[di]:
                raw = str(row[di]).strip()
                if not raw:
                    continue
                if re.search(r"[^A-Za-z0-9_]", raw):
                    for part in re.split(r"[^A-Za-z0-9_]+", raw):
                        if part and len(part) >= 3:
                            drives.add(part)
                else:
                    drives.add(raw)
    wb.close()
    return sorted(drives, key=len, reverse=True)


def drive_to_major(drive: str, site: str, letter_conveyors: set[str]) -> str | None:
    """
    Collapse a Drive / equipment tag to a MAJOR area id.
    letter_conveyors: exact majors like BCV131A that exist as distinct conveyors.
    """
    d = drive.strip()
    if not d:
        return None
    # Junk fragments
    if re.fullmatch(r"(Spare\d+|EM\d+|PP\d+)", d, re.I):
        return None
    # BRB13x / BRB13X common area (not BRB131/132)
    if re.fullmatch(r"BRB13[Xx]", d):
        return "BRB13x"
    # PLC panel / BPL modules → site BSR
    if re.match(r"^BPL\d+", d, re.I):
        return site
    # Letter-conveyor exact (BCV131A) — only if curated
    up = d.upper()
    for lc in sorted(letter_conveyors, key=len, reverse=True):
        if up == lc or up.startswith(lc):
            rest = up[len(lc) :]
            if rest == "":
                return lc
            # reject …131BK (brake) falsely matching …131B
            if re.match(r"^[A-Z]\d", rest):
                continue
            if DEVICE_PREFIX_RE.match(rest) or re.match(r"^[A-Z]{2,}", rest):
                return lc
    # BMC incomers / feeders: BMC1321, BMC1301, BMC1302, BMC802
    m = re.match(r"^(BMC\d{3,4})", d, re.I)
    if m:
        return m.group(1).upper()
    # Longer plant codes: BPP1108, BSTD1108, BTK2104, BPQE2106, BSB1301, BTY1501, SUB902
    m = re.match(r"^(BPP|BSTD|BTK|BPQE|BSB|BTY|SUB)(\d{3,4})", d, re.I)
    if m:
        return (m.group(1) + m.group(2)).upper()
    # BRB131 / BRB132
    m = re.match(r"^(BRB131|BRB132)", d, re.I)
    if m:
        return m.group(1).upper()
    # Product / DFB leftovers BEFORE generic plant-code match
    # REX → HV incomer major when present, else site PLC
    if re.match(r"^(REX|REX640)", d, re.I):
        return "BMC1321" if site == "BSR132" else "BMC1301"
    if re.match(r"^(BMEP|NOC|FLEXISOFT|CRA312|X80|CV\d)", d, re.I):
        return site
    # Standard major: 2–4 letters + 3 digits (BAF130, BCV131, BSR130, …)
    m = re.match(r"^([A-Z]{2,4}\d{3})", d, re.I)
    if m:
        code = m.group(1).upper()
        # Fold all BSR130* / BSR132* (DX, UP, BC, DB, PN, …) into site PLC table
        if code in {"BSR130", "BSR131", "BSR132"}:
            return code
        # Non-plant product codes that slipped through
        if re.match(r"^(BMEP|NOC|REX|CV\d)", code, re.I):
            if code.startswith("REX"):
                return "BMC1321" if site == "BSR132" else "BMC1301"
            return site
        return code
    # Truncated / odd: BAF13LU01 → BAF131 if site has BAF131
    m = re.match(r"^([A-Z]{2,4}\d{2})", d, re.I)
    if m:
        stub = m.group(1).upper()
        if stub == "BAF13":
            return "BAF131" if site == "BSR132" else "BAF130"
    return d.upper() if len(d) >= 5 else None


def discover_letter_conveyors(drives: list[str]) -> set[str]:
    """Exact drives like BCV131A / BCV131B / BCV131C that are distinct majors."""
    found: set[str] = set()
    for d in drives:
        if re.fullmatch(r"[A-Z]{2,4}\d{3}[ABC]", d, re.I):
            found.add(d.upper())
    return found


def build_majors(drives: list[str], site: str) -> list[str]:
    """Curated MAJOR list (longest first) derived from unique plant codes in drives."""
    letter = discover_letter_conveyors(drives)
    majors: set[str] = set(letter)
    for d in drives:
        maj = drive_to_major(d, site, letter)
        if maj:
            majors.add(maj)
    # Always include site PLC bucket
    majors.add(site)
    # Normalize BRB13x
    if any(m.upper() == "BRB13X" for m in majors):
        majors.discard("BRB13X")
        majors.add("BRB13x")
    return sorted(majors, key=len, reverse=True)


def match_major(base: str, majors: list[str], site: str, letter_conveyors: set[str]) -> str | None:
    """Longest major-prefix match with letter-conveyor guard."""
    bu = base.upper() if not base.startswith("_") else base
    # try drive_to_major first (handles BMC / BPP / BPL / BRB13x / truncations)
    derived = drive_to_major(base, site, letter_conveyors)
    if derived and derived in {m if m != "BRB13x" else "BRB13x" for m in majors}:
        # Prefer derived when it is in majors; still allow longer letter match below
        pass
    for m in majors:
        mu = m.upper() if m != "BRB13x" else "BRB13X"
        bu_cmp = bu
        if m == "BRB13x" and bu.upper().startswith("BRB13X") and not bu.upper().startswith(
            ("BRB131", "BRB132")
        ):
            return "BRB13x"
        if bu_cmp == mu or bu_cmp.startswith(mu):
            rest = bu_cmp[len(mu) :]
            if rest == "":
                return m
            # Letter-conveyor majors: require device-like rest, not single letter+digit (BK)
            if m in letter_conveyors or (
                len(m) >= 7 and m[-1] in "ABC" and m[-2].isdigit()
            ):
                if re.match(r"^[A-Z]\d", rest):
                    continue
                if not (DEVICE_PREFIX_RE.match(rest) or re.match(r"^[A-Z]{2,}", rest)):
                    continue
            return m
    if derived:
        return derived
    return None


def parse_xst_files(site: str) -> tuple[dict[str, dict], str]:
    """
    Return (vars dict name -> {typeName, comment, sources}, combined_text).
    """
    out_dir = OUTPUTS / site
    vars_map: dict[str, dict] = {}
    combined_parts: list[str] = []

    paths = sorted(out_dir.glob("*.XST")) + sorted(out_dir.glob("*.ST"))
    for path in paths:
        text = path.read_text(encoding="utf-8", errors="replace")
        combined_parts.append(text)
        for m in VAR_DECL_RE.finditer(text):
            name, type_name, _attrs, body = m.group(1), m.group(2), m.group(3), m.group(4)
            if not name.lower().startswith("sim_"):
                continue
            cm = COMMENT_RE.search(body or "")
            comment = re.sub(r"\s+", " ", cm.group(1)).strip() if cm else ""
            entry = vars_map.setdefault(
                name,
                {"typeName": type_name, "comment": comment, "sources": set(), "declared": False},
            )
            entry["declared"] = True
            entry["typeName"] = type_name or entry.get("typeName") or ""
            if comment and not entry["comment"]:
                entry["comment"] = comment
            entry["sources"].add(path.name)

        for m in SIM_REF_RE.finditer(text):
            name = m.group(1)
            if name in SKIP_REF_NAMES or name.lower() in {s.lower() for s in SKIP_REF_NAMES}:
                if name not in vars_map:
                    continue
            entry = vars_map.setdefault(
                name,
                {"typeName": "", "comment": "", "sources": set(), "declared": False},
            )
            entry["sources"].add(path.name)

    drop = []
    for name, info in vars_map.items():
        if info["declared"]:
            continue
        if name in SKIP_REF_NAMES or name.lower() in {s.lower() for s in SKIP_REF_NAMES}:
            drop.append(name)
            continue
        if re.fullmatch(r"[Ss]im_[A-Za-z][A-Za-z0-9]*", name) and not re.search(r"_\d+$", name):
            drop.append(name)
    for name in drop:
        vars_map.pop(name, None)

    return vars_map, "\n".join(combined_parts)


def build_dfb_equipment_maps(
    combined: str,
    drives: list[str],
    majors: list[str],
    site: str,
    letter_conveyors: set[str],
) -> dict[str, str]:
    """Map DFB instance name -> MAJOR equipment id using ST comments / wiring."""
    mapping: dict[str, str] = {}

    def resolve_equip(tag: str) -> str:
        tag = tag.strip()
        for d in drives:
            if tag == d or tag.startswith(d):
                maj = match_major(d, majors, site, letter_conveyors)
                return maj or drive_to_major(d, site, letter_conveyors) or d
        maj = match_major(tag, majors, site, letter_conveyors)
        if maj:
            return maj
        return to_major_fallback(tag, site, letter_conveyors)

    for equip, inst in TESYST_MAP_RE.findall(combined):
        mapping[inst] = resolve_equip(equip)
    for equip, inst in CBSTS_MAP_RE.findall(combined):
        mapping[inst] = resolve_equip(equip)
    for equip, inst in AHI_MAP_RE.findall(combined):
        mapping[inst] = resolve_equip(equip)
    for mod, inst in MODULE_DFB_RE.findall(combined):
        mapping.setdefault(inst, module_group(mod, site))
    for mod, inst in CRA_MAP_RE.findall(combined):
        mapping[inst] = module_group(mod, site)
    for _idx, mod in EHC_MAP_RE.findall(combined):
        inst = f"sim_X80EHC0800_{_idx}"
        mapping[inst] = module_group(mod, site)
    for equip, inst in BRAKE_MAP_RE.findall(combined):
        mapping[inst] = resolve_equip(equip)

    for equip, inst in GENERIC_INST_MAP_RE.findall(combined):
        if inst in mapping:
            continue
        if re.match(r"^(BM[A-Z]|Simulation|Master|Enable|Shared)", equip, re.I):
            continue
        if not re.search(r"\d", equip):
            continue
        mapping[inst] = resolve_equip(equip)

    modflt_re = re.compile(
        r"((?:sim_|SIM_|Sim_)[A-Za-z0-9_]+)\s*\([^;]{0,400}?iModFlt\s*:=\s*sim_([A-Za-z0-9_]+)_ModFlt",
        re.S | re.I,
    )
    for inst, mod in modflt_re.findall(combined):
        mapping[inst] = module_group(mod, site)

    cleaned = {}
    for inst, equip in mapping.items():
        if equip.lower() in {
            "simulation", "bmxddi3202k", "bmxddo1602k", "bmeahi0812",
            "bmxart0814", "bmxehc0800",
        }:
            continue
        cleaned[inst] = equip
    return cleaned


def module_group(mod: str, site: str) -> str:
    """
    Fold IO module / DX / PLM vars into major area.
    BSR130DX01 → BSR130; BBD130DX03 → BBD130; BCV131DX06 → BCV131; else site or _IO_Modules.
    """
    # Prefer parent plant code before DX
    m = re.match(r"^([A-Za-z0-9]+?)DX\d{2}", mod, re.I)
    if m:
        parent = m.group(1)
        # Odd / non-plant DX parents (CV702) → site PLC
        if re.match(r"^(CV\d|BMEP|NOC)", parent, re.I):
            return site
        maj = drive_to_major(parent, site, set())
        if maj:
            return maj
        if re.match(r"^BSR\d{3}$", parent, re.I):
            return parent.upper()
        return parent.upper()
    if "PLM" in mod.upper():
        base = re.sub(r"PLM\d+.*$", "", mod, flags=re.I)
        if re.match(r"^BPL\d+", base, re.I) or re.match(r"^BSR\d{3}", base, re.I):
            return site
        maj = drive_to_major(base, site, set()) if base else None
        return maj or site
    return site  # fold unnamed module leftovers into PLC table


def to_major_fallback(base: str, site: str, letter_conveyors: set[str]) -> str:
    maj = drive_to_major(base, site, letter_conveyors)
    if maj:
        return maj
    # strip device tokens then retry
    name = derive_equipment_raw(base)
    maj = drive_to_major(name, site, letter_conveyors)
    if maj:
        return maj
    m = re.match(r"^([A-Z]{2,4}\d{3})", name, re.I)
    if m:
        code = m.group(1).upper()
        # Non-plant product / odd codes → site PLC bucket
        if re.match(r"^(BMEP|NOC|REX|CV\d)", code, re.I):
            return site
        return code
    if re.match(r"^(FLEXISOFT|REX640|NOC030)", name, re.I):
        return site
    return "_Ungrouped"


def derive_equipment_raw(base: str) -> str:
    """Derive intermediate equipment id by stripping trailing device tokens (pre-major)."""
    name = base
    if re.search(r"DX\d{2}DIO|PLM\d+", name, re.I):
        return name
    changed = True
    while changed and len(name) > 4:
        changed = False
        m = re.search(
            r"_(I|O|PV|Spd|Gain|SetTrp|Rst|Mode|Flt|ComFlt|LnkFlt|ModFlt|"
            r"Grp\d(?:DDI|DDO|flt)?|Ch\d{2}PV)$",
            name,
            re.I,
        )
        if m:
            name = name[: m.start()]
            changed = True
            continue
        m = DEVICE_TOKEN_RE.search(name)
        if m and m.start() > 3:
            name = name[: m.start()]
            changed = True
            continue
        m = re.search(r"([A-Z]{1,3}\d{2})$", name, re.I)
        if m and len(name) - len(m.group(1)) >= 6:
            left = name[: m.start()]
            if re.search(r"\d", left):
                name = left
                changed = True
                continue
        break
    return name.rstrip("_") or "_Ungrouped"


def is_global(name: str) -> bool:
    if name in GLOBAL_EXACT:
        return True
    low = name.lower()
    if low in {g.lower() for g in GLOBAL_EXACT}:
        return True
    if low in {
        "sim_init", "sim_sethealthy", "sim_equipblocks", "sim_ehc_scntm",
        "sim_tesyst_mstip", "sim_ftxx_rand",
    }:
        return True
    return False


def is_dfb_instance(type_name: str, name: str) -> bool:
    if not type_name:
        return bool(re.search(r"_\d+$", name)) and not any(
            name.lower().endswith(s) for s in ("_i", "_o", "_pv")
        )
    if type_name.upper() in ELEMENTARY_TYPES:
        return False
    if type_name.upper().startswith("ARRAY"):
        return False
    return True


def assign_table(
    name: str,
    info: dict,
    drives: list[str],
    dfb_map: dict[str, str],
    majors: list[str],
    site: str,
    letter_conveyors: set[str],
) -> tuple[str, str]:
    """Return (major_table_name, notes_hint)."""
    type_name = info.get("typeName") or ""
    base = strip_sim_prefix(name)

    if is_global(name):
        return "_Globals", "global/control"

    # Explicit DFB→equipment map from ST (already major-resolved)
    if name in dfb_map:
        return sanitize_filename(dfb_map[name]), "ST-mapped DFB/equip"
    for k, v in dfb_map.items():
        if k.lower() == name.lower():
            return sanitize_filename(v), "ST-mapped DFB/equip"

    # Longest Drive prefix → fold to major
    for d in drives:
        if base == d or base.startswith(d):
            rest = base[len(d) :]
            if rest == "" or rest[0].isalnum() or rest[0] == "_":
                maj = match_major(d, majors, site, letter_conveyors)
                if maj:
                    return sanitize_filename(maj), "Drive→major"
                maj = drive_to_major(d, site, letter_conveyors)
                if maj:
                    return sanitize_filename(maj), "Drive→major"

    # Direct major prefix on tag
    maj = match_major(base, majors, site, letter_conveyors)
    if maj:
        return sanitize_filename(maj), "major prefix"

    # Module / rack patterns
    if re.search(
        r"DX\d{2}|PLM\d+|DDI|DDO|AHI|ART|EHC|CRA|BMEP|noc0301|rex640|FlexiSoft",
        name,
        re.I,
    ):
        if is_dfb_instance(type_name, name) or re.search(
            r"ModFlt|Grp\d|Ch\d{2}PV|_Flt|_Mode|_LnkFlt|_ComFlt", name, re.I
        ):
            grp = module_group(base, site)
            return sanitize_filename(grp), "IO module→major"

    if is_dfb_instance(type_name, name):
        # Unmapped DFB instances → fold into site PLC table (keeps table count low)
        # unless name itself encodes equipment
        maj = match_major(base, majors, site, letter_conveyors)
        if maj:
            return sanitize_filename(maj), "DFB→major"
        fb = to_major_fallback(base, site, letter_conveyors)
        if fb and fb not in {"_Ungrouped", None}:
            # Product-code majors that aren't real plant areas → site
            if re.match(r"^(BMEP|NOC|REX|FLEXISOFT|CRA312|X80|CV\d+)", fb, re.I):
                return site, "DFB→PLC"
            return sanitize_filename(fb), "DFB→major"
        return site, "DFB→PLC"

    fb = to_major_fallback(base, site, letter_conveyors)
    if fb and fb != "_Ungrouped":
        return sanitize_filename(fb), "derived→major"

    return "_Ungrouped", "unmatched"



PRODUCT = "Control Expert V16.2 - 250430"
DTD_VERSION = "41"
CONTENT_VERSION_DEFAULT = "0.0.202"


def site_to_pou(site: str) -> str:
    """BSR130 → BPL130, etc."""
    m = re.match(r"^BSR(\d{3})$", site, re.I)
    if m:
        return f"BPL{m.group(1)}"
    return site


def parse_content_header(site: str) -> tuple[str, str, str]:
    """
    Return (name, version, dateTime) from an XST contentHeader.
    Prefer sim_Equipment.XST when present, else first *.XST.
    """
    out_dir = OUTPUTS / site
    candidates = []
    eq = out_dir / "sim_Equipment.XST"
    if eq.exists():
        candidates.append(eq)
    candidates.extend(sorted(p for p in out_dir.glob("*.XST") if p != eq))
    hdr_re = re.compile(
        r'<contentHeader\s+name="([^"]+)"\s+version="([^"]+)"\s+dateTime="([^"]+)"',
        re.I,
    )
    for p in candidates:
        m = hdr_re.search(p.read_text(encoding="utf-8", errors="replace")[:2000])
        if m:
            return m.group(1), m.group(2), m.group(3)
    pou = site_to_pou(site)
    return pou, CONTENT_VERSION_DEFAULT, ce_datetime_now()


def ce_datetime_now() -> str:
    """Control Expert date_and_time#Y-M-D-H:MM:SS (no zero-pad on M/D)."""
    now = datetime.now()
    return (
        f"date_and_time#{now.year}-{now.month}-{now.day}-"
        f"{now.hour}:{now.minute:02d}:{now.second:02d}"
    )


def write_xtb(
    path: Path,
    table_name: str,
    var_names: list[str],
    pou_owner: str,
    content_version: str,
    content_dt: str,
    file_dt: str | None = None,
) -> None:
    """Write a TABExchangeFile .xtb matching the sample Inputs/Table.xtb structure."""
    file_dt = file_dt or ce_datetime_now()
    lines = [
        '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
        "<TABExchangeFile>",
        (
            f'\t<fileHeader company="Schneider Automation" product="{PRODUCT}" '
            f'dateTime="{file_dt}" content="Animation Table source file" '
            f'DTDVersion="{DTD_VERSION}"></fileHeader>'
        ),
        (
            f'\t<contentHeader name="{escape(pou_owner)}" version="{escape(content_version)}" '
            f'dateTime="{content_dt}"></contentHeader>'
        ),
        (
            f'\t<animationTable name="{escape(table_name)}" location="" version="1.0" '
            f'dateTime="{file_dt}" ExtStringAnim="0" ExtStringAnimLen="100" '
            f'PouOwner="{escape(pou_owner)}">'
        ),
    ]
    for name in var_names:
        lines.append(
            f'\t\t<elementDescription displayBase="4" name="{escape(name)}"></elementDescription>'
        )
    lines.append("\t</animationTable>")
    lines.append("</TABExchangeFile>")
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def write_site(site: str) -> dict:
    drives = load_drives(site)
    letter_conveyors = discover_letter_conveyors(drives)
    majors = build_majors(drives, site)
    vars_map, combined = parse_xst_files(site)
    dfb_map = build_dfb_equipment_maps(combined, drives, majors, site, letter_conveyors)
    pou_owner, content_version, content_dt = parse_content_header(site)
    file_dt = ce_datetime_now()

    tables: dict[str, list[dict]] = defaultdict(list)
    notes_by_table: dict[str, set[str]] = defaultdict(set)

    for name in sorted(vars_map.keys(), key=lambda s: s.lower()):
        info = vars_map[name]
        table, hint = assign_table(
            name, info, drives, dfb_map, majors, site, letter_conveyors
        )
        tables[table].append(
            {
                "Name": name,
                "TypeName": info.get("typeName") or "",
                "Comment": info.get("comment") or hint,
            }
        )
        notes_by_table[table].add(hint)

    for t in tables:
        tables[t].sort(key=lambda r: r["Name"].lower())

    dest_dirs = [
        OUTPUTS / site / "AnimationTables",
        REPO_OUTPUTS / site / "AnimationTables",
    ]
    for d in dest_dirs:
        if d.exists():
            shutil.rmtree(d)
        d.mkdir(parents=True, exist_ok=True)

    primary = dest_dirs[0]

    all_rows = []
    index_rows = []

    for table in sorted(tables.keys(), key=lambda s: (s.startswith("_"), s.lower())):
        rows = tables[table]
        var_names = [r["Name"] for r in rows]
        write_xtb(
            primary / f"{table}.xtb",
            table_name=table,
            var_names=var_names,
            pou_owner=pou_owner,
            content_version=content_version,
            content_dt=content_dt,
            file_dt=file_dt,
        )
        index_rows.append({"TableName": table, "VarCount": len(rows)})
        for r in rows:
            all_rows.append(
                {
                    "TableName": table,
                    "Name": r["Name"],
                    "TypeName": r["TypeName"],
                    "Comment": r["Comment"],
                }
            )

    with (primary / "_index.csv").open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["TableName", "VarCount"])
        w.writeheader()
        w.writerows(index_rows)

    major_list = ", ".join(
        t for t in sorted(tables.keys(), key=lambda s: (s.startswith("_"), s.lower()))
    )
    readme = f"""Control Expert Animation Tables (.xtb) — {site}
================================================

Generated by generate_animation_tables.py from sim_* variables in
Outputs/{site}/*.XST (and ST refs) plus Drive names from Inputs/{site}_IO_List.xlsx.

Format: TABExchangeFile (Control Expert Animation Table source file), matching
Inputs/Table.xtb. Each <MajorID>.xtb is importable via Control Expert File → Open /
animation table exchange.

  contentHeader name / PouOwner = {pou_owner}
  product = {PRODUCT}
  DTDVersion = {DTD_VERSION}

Grouping is MAJOR equipment / area only (coarser than Drive): PP/FN/HP/GA/LU/CH/MT/…
fold under the parent plant code (e.g. BAF130). Letter conveyors BCV131A/B/C are kept
as separate majors when present. PLC/DX/panel/common fold under {site}.

How to use in Control Expert
----------------------------
1. Open the project for {pou_owner}.
2. File → Open (or Animation tables import) each <MajorID>.xtb, or drag into Data Editor.
3. Tables are named after major equipment (see _index.csv).
4. Optionally Initialize Animation Table on DFB instances (SIM_TeSysT_*, sim_X80*, etc.).

Files
-----
- <MajorID>.xtb   TABExchangeFile animation table (one per major)
- _index.csv      TableName, VarCount
- README.txt      This file
- _Globals.xtb    sim_init, sim_SetHealthy, Sim_EquipBlocks, etc. (when present)

Major tables this run
---------------------
{major_list}

Grouping rules
--------------
1. Strip sim_/Sim_/SIM_; match curated MAJOR list (longest plant code from IO drives).
2. Heuristic ^([A-Z]{{2,4}}\\d{{3}}) plus BMC#### / BPP#### / letter-conveyor BCV###[ABC].
3. ST comment maps for TeSysT / CBSts / AHI_Scale / CRA / X80 cards → same major fold.
4. DX/PLM/BPL module vars → parent major or {site}; leftovers → {site} / _Ungrouped.

Totals for this run: {len(all_rows)} variables across {len(tables)} tables.
PouOwner={pou_owner} version={content_version}
"""
    (primary / "README.txt").write_text(readme, encoding="utf-8")

    for dest in dest_dirs[1:]:
        if dest.exists():
            shutil.rmtree(dest)
        shutil.copytree(primary, dest)

    equip_tables = [t for t in tables if not t.startswith("_")]
    special_tables = [t for t in tables if t.startswith("_")]
    counts = {t: len(tables[t]) for t in sorted(tables.keys())}
    return {
        "site": site,
        "pou_owner": pou_owner,
        "drives": len(drives),
        "majors_curated": majors,
        "variables": len(all_rows),
        "tables": len(tables),
        "equipment_tables": len(equip_tables),
        "special_tables": len(special_tables),
        "counts": counts,
        "table_names": sorted(tables.keys()),
        "primary": str(primary),
        "repo": str(dest_dirs[1]),
    }



def main() -> None:
    summaries = []
    for site in SITES:
        print(f"Generating MAJOR AnimationTables (.xtb) for {site}...")
        summary = write_site(site)
        summaries.append(summary)
        print(
            f"  {summary['variables']} vars → {summary['tables']} tables "
            f"({summary['equipment_tables']} major + {summary['special_tables']} special) "
            f"PouOwner={summary.get('pou_owner')}"
        )
        for t, c in summary["counts"].items():
            print(f"    {t}: {c}")
        print(f"  → {summary['primary']}")
        print(f"  → {summary['repo']}")

    # Sync sample Table.xtb + this script into Projects-repo Testing tree
    REPO_INPUTS.mkdir(parents=True, exist_ok=True)
    sample_src = INPUTS / "Table.xtb"
    if sample_src.exists():
        shutil.copy2(sample_src, REPO_INPUTS / "Table.xtb")
        print(f"Copied sample → {REPO_INPUTS / 'Table.xtb'}")
    script_src = Path(__file__).resolve()
    shutil.copy2(script_src, REPO_TESTING / "generate_animation_tables.py")
    print(f"Copied script → {REPO_TESTING / 'generate_animation_tables.py'}")

    print("Done.")
    import json
    slim = []
    for s in summaries:
        slim.append({k: v for k, v in s.items() if k != "majors_curated"})
    print(json.dumps(slim, indent=2))


if __name__ == "__main__":
    main()
