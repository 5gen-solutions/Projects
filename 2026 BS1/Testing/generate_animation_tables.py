#!/usr/bin/env python3
"""
Generate Control Expert animation-table helper files from sim_* variables.

For each PLC (BSR130, BSR132):
  - Collect typed sim_* declarations from XST <variables name= typeName=>
  - Also collect sim_* referenced in ST even if only referenced (skip POU/type names)
  - Group by equipment (IO-list Drive longest-prefix match, ST comment maps for DFBs,
    module/DX fall-backs, globals)
  - Write per-equipment CSV (Name,TypeName,Comment) + TXT (one name per line for paste)
  - Write _All_sim_variables.csv, _index.csv, README.txt

Outputs written to:
  /workspace/testing/Outputs/<PLC>/AnimationTables/
  /workspace/Projects-repo/2026 BS1/Testing/Outputs/<PLC>/AnimationTables/
"""

from __future__ import annotations

import csv
import re
import shutil
from collections import defaultdict
from pathlib import Path

try:
    import openpyxl
except ImportError:
    openpyxl = None

ROOT = Path("/workspace/testing")
INPUTS = ROOT / "Inputs"
OUTPUTS = ROOT / "Outputs"
REPO_OUTPUTS = Path("/workspace/Projects-repo/2026 BS1/Testing/Outputs")
SITES = ("BSR130", "BSR132")

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
# Module card DFBs: comment contains module name
MODULE_DFB_RE = re.compile(
    r"\(\*\s*[A-Z0-9]+\s*-\s*([A-Za-z0-9_]*(?:DX\d{2}|PLM\d+)[A-Za-z0-9_]*)\s*\*\)\s*"
    r"((?:sim_|SIM_)[A-Za-z0-9_]+)",
    re.I,
)
CRA_MAP_RE = re.compile(
    r"\(\*\s*=+\s*([A-Za-z0-9_]+)\s*-\s*DROP[^*]*\*\)\s*(SIM_CRA31210_\d+)",
    re.I,
)
# EHC / Brake: look for equipment tags near instance
EHC_MAP_RE = re.compile(
    r"sim_X80EHC0800_(\d+)\s*\([^)]*?iFlt\s*:=\s*sim_([A-Za-z0-9_]+)_ModFlt",
    re.S | re.I,
)
BRAKE_MAP_RE = re.compile(
    r"\(\*\s*([A-Za-z0-9_]+)[^*]*[Bb]rake[^*]*\*\)\s*(SIM_Brake_\d+)",
)
# Generic: any (* Equip *) immediately before a SIM_/sim_ instance call
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
                # Split weird multi-drive cells
                if re.search(r"[^A-Za-z0-9_]", raw):
                    for part in re.split(r"[^A-Za-z0-9_]+", raw):
                        if part and len(part) >= 3:
                            drives.add(part)
                else:
                    drives.add(raw)
    wb.close()
    return sorted(drives, key=len, reverse=True)


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
        # Declarations (XST)
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

        # ST references
        for m in SIM_REF_RE.finditer(text):
            name = m.group(1)
            if name in SKIP_REF_NAMES or name.lower() in {s.lower() for s in SKIP_REF_NAMES}:
                # skip bare type / POU names
                if name not in vars_map:
                    continue
            entry = vars_map.setdefault(
                name,
                {"typeName": "", "comment": "", "sources": set(), "declared": False},
            )
            entry["sources"].add(path.name)

    # Drop undeclared refs that look like type/POU names
    drop = []
    for name, info in vars_map.items():
        if info["declared"]:
            continue
        if name in SKIP_REF_NAMES or name.lower() in {s.lower() for s in SKIP_REF_NAMES}:
            drop.append(name)
            continue
        # Undeclared without digits at end and matching known DFB type pattern → skip
        if re.fullmatch(r"[Ss]im_[A-Za-z][A-Za-z0-9]*", name) and not re.search(r"_\d+$", name):
            # likely a type or POU
            drop.append(name)
    for name in drop:
        vars_map.pop(name, None)

    return vars_map, "\n".join(combined_parts)


def build_dfb_equipment_maps(combined: str, drives: list[str]) -> dict[str, str]:
    """Map DFB instance name -> equipment id using ST comments / wiring."""
    mapping: dict[str, str] = {}

    def resolve_equip(tag: str) -> str:
        tag = tag.strip()
        # longest drive prefix
        for d in drives:
            if tag == d or tag.startswith(d):
                return d
        # strip device tokens
        return derive_equipment(tag)

    for equip, inst in TESYST_MAP_RE.findall(combined):
        mapping[inst] = resolve_equip(equip)
    for equip, inst in CBSTS_MAP_RE.findall(combined):
        mapping[inst] = resolve_equip(equip)
    for equip, inst in AHI_MAP_RE.findall(combined):
        mapping[inst] = resolve_equip(equip)
    for mod, inst in MODULE_DFB_RE.findall(combined):
        # Prefer DX drop as equipment group for IO cards
        mapping.setdefault(inst, module_group(mod))
    for mod, inst in CRA_MAP_RE.findall(combined):
        mapping[inst] = module_group(mod)
    for _idx, mod in EHC_MAP_RE.findall(combined):
        inst = f"sim_X80EHC0800_{_idx}"
        # also try SIM_ casing variants later
        mapping[inst] = module_group(mod)
    for equip, inst in BRAKE_MAP_RE.findall(combined):
        mapping[inst] = resolve_equip(equip)

    # Generic comment maps (don't override more specific)
    for equip, inst in GENERIC_INST_MAP_RE.findall(combined):
        if inst in mapping:
            continue
        # skip section headings / product codes / non-equipment tokens
        if re.match(r"^(BM[A-Z]|Simulation|Master|Enable|Shared)", equip, re.I):
            continue
        if not re.search(r"\d", equip):
            continue
        mapping[inst] = resolve_equip(equip)

    # iModFlt := sim_<MODULE>_ModFlt near instance — authoritative for X80 cards
    modflt_re = re.compile(
        r"((?:sim_|SIM_|Sim_)[A-Za-z0-9_]+)\s*\([^;]{0,400}?iModFlt\s*:=\s*sim_([A-Za-z0-9_]+)_ModFlt",
        re.S | re.I,
    )
    for inst, mod in modflt_re.findall(combined):
        mapping[inst] = module_group(mod)

    # Drop bogus equipment ids
    cleaned = {}
    for inst, equip in mapping.items():
        if equip.lower() in {"simulation", "bmxddi3202k", "bmxddo1602k", "bmeahi0812",
                             "bmxart0814", "bmxehc0800"}:
            continue
        cleaned[inst] = equip
    return cleaned


def module_group(mod: str) -> str:
    """Group IO module vars under DX drop when possible, else _IO_Modules."""
    # e.g. BSR130DX01DIO1PLM1 → BSR130DX01
    m = re.match(r"^([A-Za-z0-9]+DX\d{2})", mod)
    if m:
        return m.group(1)
    m = re.match(r"^([A-Za-z0-9]+(?:PLM\d+)?)", mod)
    if m and "PLM" in mod:
        # BPL130PLM0 → BPL130
        base = re.sub(r"PLM\d+.*$", "", mod)
        return base or "_IO_Modules"
    return "_IO_Modules"


def derive_equipment(base: str) -> str:
    """Derive equipment id by stripping trailing device tokens."""
    name = base
    # Module-like
    if re.search(r"DX\d{2}DIO|PLM\d+", name, re.I):
        return module_group(name)

    # Repeatedly strip trailing tokens / suffixes
    changed = True
    while changed and len(name) > 4:
        changed = False
        # strip _suffix first
        m = re.search(r"_(I|O|PV|Spd|Gain|SetTrp|Rst|Mode|Flt|ComFlt|LnkFlt|ModFlt|"
                       r"Grp\d(?:DDI|DDO|flt)?|Ch\d{2}PV)$", name, re.I)
        if m:
            name = name[: m.start()]
            changed = True
            continue
        m = DEVICE_TOKEN_RE.search(name)
        if m and m.start() > 3:
            name = name[: m.start()]
            changed = True
            continue
        # strip trailing letter+digits device codes like PP07, FN01, HT01 if long enough remains
        m = re.search(r"([A-Z]{1,3}\d{2})$", name, re.I)
        if m and len(name) - len(m.group(1)) >= 6:
            # only if leftover still looks like equipment (has digits)
            left = name[: m.start()]
            if re.search(r"\d", left):
                name = left
                changed = True
                continue
        break

    name = name.rstrip("_")
    return name if name else "_Ungrouped"


def is_global(name: str) -> bool:
    if name in GLOBAL_EXACT:
        return True
    low = name.lower()
    if low in {g.lower() for g in GLOBAL_EXACT}:
        return True
    # short control tags
    if low in {"sim_init", "sim_sethealthy", "sim_equipblocks", "sim_ehc_scntm",
               "sim_tesyst_mstip", "sim_ftxx_rand"}:
        return True
    return False


def is_dfb_instance(type_name: str, name: str) -> bool:
    if not type_name:
        # heuristic: SIM_TeSysT_0 style
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
) -> tuple[str, str]:
    """
    Return (table_name, notes_hint).
    """
    type_name = info.get("typeName") or ""
    base = strip_sim_prefix(name)

    if is_global(name):
        return "_Globals", "global/control"

    # Explicit DFB→equipment map from ST
    if name in dfb_map:
        return sanitize_filename(dfb_map[name]), "ST-mapped DFB/equip"
    # try case variants
    for k, v in dfb_map.items():
        if k.lower() == name.lower():
            return sanitize_filename(v), "ST-mapped DFB/equip"

    # Longest Drive prefix match
    for d in drives:
        if base == d or base.startswith(d):
            # Avoid matching when next chars continue an identifier oddly —
            # require end or non-lowercase continuation (drives are alphanumeric)
            rest = base[len(d) :]
            if rest == "" or rest[0].isalnum() or rest[0] == "_":
                return sanitize_filename(d), "Drive prefix"

    # Module / rack patterns without drive
    if re.search(r"DX\d{2}|PLM\d+|DDI|DDO|AHI|ART|EHC|CRA|BMEP|noc0301|rex640|FlexiSoft",
                 name, re.I):
        if is_dfb_instance(type_name, name) or re.search(
            r"ModFlt|Grp\d|Ch\d{2}PV|_Flt|_Mode|_LnkFlt|_ComFlt", name, re.I
        ):
            grp = module_group(base)
            if grp == "_IO_Modules" and is_dfb_instance(type_name, name):
                # unnamed card DFBs
                return "_DFBs", "DFB instance"
            return sanitize_filename(grp), "IO module/DX"

    if is_dfb_instance(type_name, name):
        # AHI_Scale / CBSts without map → _DFBs
        return "_DFBs", "DFB instance"

    # Derive from token stripping
    derived = derive_equipment(base)
    if derived and derived not in {"_Ungrouped", "_IO_Modules"}:
        # If leftover ends with a dangling letter (e.g. BAF130P), try drive match on it
        if re.search(r"\d[A-Za-z]$", derived):
            for d in drives:
                if derived.startswith(d) or d.startswith(derived.rstrip("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")):
                    # prefer full drive if base starts with drive
                    if base.startswith(d):
                        return sanitize_filename(d), "derived→Drive"
            # strip dangling letter
            derived2 = re.sub(r"[A-Za-z]$", "", derived)
            if derived2:
                for d in drives:
                    if derived2 == d or base.startswith(d):
                        return sanitize_filename(d), "derived→Drive"
                derived = derived2
        return sanitize_filename(derived), "derived"
    if derived == "_IO_Modules":
        return "_IO_Modules", "IO module"

    return "_Ungrouped", "unmatched"


def write_site(site: str) -> dict:
    drives = load_drives(site)
    vars_map, combined = parse_xst_files(site)
    dfb_map = build_dfb_equipment_maps(combined, drives)

    tables: dict[str, list[dict]] = defaultdict(list)
    notes_by_table: dict[str, set[str]] = defaultdict(set)

    for name in sorted(vars_map.keys(), key=lambda s: s.lower()):
        info = vars_map[name]
        table, hint = assign_table(name, info, drives, dfb_map)
        tables[table].append(
            {
                "Name": name,
                "TypeName": info.get("typeName") or "",
                "Comment": info.get("comment") or hint,
            }
        )
        notes_by_table[table].add(hint)

    # Sort rows within tables
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

    # Write per-table files into first dest, then copy tree
    primary = dest_dirs[0]

    all_rows = []
    index_rows = []

    for table in sorted(tables.keys(), key=lambda s: (s.startswith("_"), s.lower())):
        rows = tables[table]
        csv_path = primary / f"{table}.csv"
        txt_path = primary / f"{table}.txt"
        with csv_path.open("w", newline="", encoding="utf-8") as f:
            w = csv.DictWriter(f, fieldnames=["Name", "TypeName", "Comment"])
            w.writeheader()
            w.writerows(rows)
        with txt_path.open("w", encoding="utf-8") as f:
            for r in rows:
                f.write(r["Name"] + "\n")
        notes = "; ".join(sorted(notes_by_table[table]))
        index_rows.append(
            {"TableName": table, "VariableCount": len(rows), "Notes": notes}
        )
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
        w = csv.DictWriter(f, fieldnames=["TableName", "VariableCount", "Notes"])
        w.writeheader()
        w.writerows(index_rows)

    with (primary / "_All_sim_variables.csv").open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["TableName", "Name", "TypeName", "Comment"])
        w.writeheader()
        w.writerows(all_rows)

    readme = f"""Control Expert Animation Table helpers — {site}
================================================

Generated by /workspace/testing/generate_animation_tables.py from sim_* variables
in Outputs/{site}/*.XST (and ST refs) plus Drive names from Inputs/{site}_IO_List.xlsx.

How to use in Control Expert
----------------------------
1. Open Data Editor → Animation tables.
2. Create a new animation table named after the equipment (see _index.csv).
3. Paste variable names from the matching <EquipmentID>.txt (one name per line).
   CE has no official CSV import for animation tables; paste is the fastest bulk load.
4. Optionally Initialize Animation Table on DFB instances (SIM_TeSysT_*, sim_X80*, etc.).

Files
-----
- _index.csv              TableName, VariableCount, Notes
- _All_sim_variables.csv  Flat list of all sim_* with table assignment
- <EquipmentID>.csv       Name,TypeName,Comment (tracking)
- <EquipmentID>.txt       One variable name per line (paste into CE)
- _Globals.*              sim_init, sim_SetHealthy, Sim_EquipBlocks, etc.
- _IO_Modules.* / DX*     Rack/module card vars without a clear Drive
- _DFBs.*                 DFB instances not mapped to a specific drive

Grouping
--------
1. Longest IO-list Drive prefix match on tag after stripping sim_/Sim_.
2. ST comment maps for TeSysT / CBSts / AHI_Scale / CRA / X80 cards.
3. DX drop / PLM module grouping for ModFlt/Grp/ChPV and card DFBs.
4. Device-token stripping fall-back; leftovers in _Ungrouped / _DFBs.

Totals for this run: {len(all_rows)} variables across {len(tables)} tables.
"""
    (primary / "README.txt").write_text(readme, encoding="utf-8")

    # Mirror to repo outputs
    for dest in dest_dirs[1:]:
        if dest.exists():
            shutil.rmtree(dest)
        shutil.copytree(primary, dest)

    equip_tables = [t for t in tables if not t.startswith("_")]
    special_tables = [t for t in tables if t.startswith("_")]
    return {
        "site": site,
        "drives": len(drives),
        "variables": len(all_rows),
        "tables": len(tables),
        "equipment_tables": len(equip_tables),
        "special_tables": len(special_tables),
        "table_names": sorted(tables.keys()),
        "primary": str(primary),
        "repo": str(dest_dirs[1]),
    }


def main() -> None:
    summaries = []
    for site in SITES:
        print(f"Generating AnimationTables for {site}...")
        summary = write_site(site)
        summaries.append(summary)
        print(
            f"  {summary['variables']} vars → {summary['tables']} tables "
            f"({summary['equipment_tables']} equipment + {summary['special_tables']} special)"
        )
        print(f"  → {summary['primary']}")
        print(f"  → {summary['repo']}")
    print("Done.")
    # machine-readable summary for parent
    import json
    print(json.dumps(summaries, indent=2))


if __name__ == "__main__":
    main()
