#!/usr/bin/env python3
"""
Generate Schneider Control Expert simulation XST files from IO List workbooks.
Mirrors conventions observed in BSR131 reference outputs.
"""
from __future__ import annotations

import argparse
import re
import uuid
from collections import defaultdict
from dataclasses import dataclass, field
from datetime import datetime
from pathlib import Path
from typing import Any, Optional

import openpyxl

ROOT = Path("/workspace/testing")
INPUTS = ROOT / "Inputs"
OUTPUTS = ROOT / "Outputs"

PRODUCT = "Control Expert V16.2 - 250430"
CONTENT_DT = "date_and_time#2026-7-1-10:24:18"
VERSION = "0.0.202"

IO_CARD_KEYS = ("DDI3202", "DDO1602", "AHI0812", "AHO0412", "EHC0800", "ART0814")
SIM_IO_TYPES = {"DI", "DO", "AI", "AO", "HSCI", "RTDI"}


def new_guid() -> str:
    return str(uuid.uuid4()).upper()


def xml_esc(s: str) -> str:
    return (
        s.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
    )


def now_dt() -> str:
    n = datetime.utcnow()
    return f"date_and_time#{n.year}-{n.month}-{n.day}-{n.hour}:{n.minute}:{n.second}"


def tag_base(it: Any, dev: Any, drive: Any) -> Optional[str]:
    """Derive simulation tag base from Instrument Tag + Device (+ Drive exceptions)."""
    it = str(it).strip() if it else ""
    dev = str(dev).strip() if dev else ""
    drive = str(drive).strip() if drive else ""
    if not it or not dev:
        return None
    itu, devu = it.upper(), dev.upper()
    if itu.endswith(devu):
        return it
    # Pulse FQ on FIT meter → Drive+Device
    if drive and re.search(r"FIT\d*$", itu) and re.match(r"FQ\d+", devu):
        return drive + dev
    # Switch status on *SW## instrument → Drive+Device
    if drive and re.search(r"SW\d+$", itu) and re.match(r"(XS|ZS)\d+", devu):
        return drive + dev
    # Speed sensor SS## with ZQ pulse → Drive+Device
    if drive and re.search(r"SS\d+$", itu) and re.match(r"ZQ\d+", devu):
        return drive + dev
    # Device extends / overlaps a trailing token of Instrument Tag.
    # e.g. Inst=...ZS01 + Device=ZS01A → ...ZS01A (not ...ZS01ZS01A)
    # e.g. Inst=...ZS02 + Device=ZS01B → ...ZS01B (same type family, avoid ZS##ZS##)
    m = re.search(r"([A-Za-z]+\d+[A-Za-z]*)$", it)
    if m:
        suffix = m.group(1)
        su = suffix.upper()
        if devu.startswith(su):
            return it[: -len(suffix)] + dev
        # Longest proper prefix of Device that Inst already ends with
        for n in range(len(devu) - 1, 1, -1):  # require overlap length >= 2
            pref = devu[:n]
            if itu.endswith(pref) and su.endswith(pref):
                return it[: -n] + dev
        # Same device-type family (alpha code matches, both have digits):
        # replace trailing Inst token with Device rather than concatenating.
        am = re.match(r"([A-Za-z]+)(\d)", su)
        bm = re.match(r"([A-Za-z]+)(\d)", devu)
        if am and bm and am.group(1) == bm.group(1):
            return it[: -len(suffix)] + dev
    return it + dev


def sim_tag(base: str, suffix: str = "_I") -> str:
    return f"sim_{base}{suffix}"


def state_to_val(state: Any, device: Any, desc2: Any = None) -> int:
    """Map IO-list State to Initialise DI value for a healthy plant.

    State names the condition asserted when the DI is TRUE.
    Healthy/normal/closed/ok-style bits -> 1; alarm/fault/trip/abnormal -> 0.
    Case-insensitive. Pushbuttons (STT/STP) always 0.
    Empty State: use Desc2 / device heuristics (not blind 1).
    Unrecognised non-empty states default to 0 (treat as alarm-ish).
    """
    s = (str(state).strip() if state is not None else "")
    d = (str(device).strip().upper() if device else "")
    if d.startswith("STT") or d.startswith("STP"):
        return 0

    su = s.casefold()

    # Bit TRUE means healthy / normal / closed / ready plant condition
    healthy = {
        "healthy",
        "closed",
        "ok",
        "normal",
        "ready",
        "running",
        "charged",  # CB spring charged
        "remote",  # normal remote control selected
    }
    # Bit TRUE means alarm / fault / trip / abnormal / actuated
    unhealthy = {
        "alarm",
        "active",
        "discharged",
        "activated",
        "open",
        "selected",  # local/manual selected
        "fault",
        "low",
        "tripped",
        "trip",
        "pulse",
        "enabled",
        "high",
        "high-high",
        "blocked",
        "worn",
        "cycled",
        "lifted",
        "parked",
        "engaged",
        "in position",
        "in operating position",
        "locked in position",
        "local",
    }
    if su in healthy:
        return 1
    if su in unhealthy:
        return 0

    # Empty / placeholder State — healthy defaults from Desc2 + device type
    if not su or su in {"\\", "-", "n/a", "na", "none"}:
        desc = (str(desc2).strip() if desc2 is not None else "")
        du = desc.casefold()
        if du:
            # Desc2 often states the healthy meaning when State is blank
            if any(
                k in du
                for k in (
                    "bypass",
                    "bypassed",
                    "detect",
                    "detected",
                    "alarm",
                    "fault",
                    "trip",
                    "spare",
                    "test",
                )
            ):
                return 0
            if any(
                k in du
                for k in ("healthy", "normal", "closed", "ok", "ready")
            ):
                return 1
        # Device-type healthy defaults (match BSR131 sectioning)
        if re.match(r"^(IS|CB|VDC|SYS|THR|LS)\d", d):
            return 1
        if re.match(r"^(FS|STT|STP)\d", d):
            return 0
        # Unknown empty: prefer clear/off rather than asserting healthy blindly
        return 0

    # Unrecognised non-empty State: prefer 0 (alarm-ish) over forcing healthy
    return 0


def classify_card(ntype: str) -> Optional[str]:
    u = ntype.upper()
    if "DDI3202" in u:
        return "DDI"
    if "DDO1602" in u:
        return "DDO"
    if "AHI0812" in u:
        return "AHI"
    if "AHO0412" in u:
        return "AHO"
    if "EHC0800" in u:
        return "EHC"
    if "ART0814" in u:
        return "ART"
    return None


def ddt_name(drop: int, rack: int, slot: int) -> str:
    return f"D{int(drop):02d}R{int(rack):02d}S{int(slot):02d}"


def owner_path(drop: int, rack: int, slot: int) -> str:
    return f"\\2.{int(drop)}\\{int(rack)}.{int(slot)}"


def module_name(item: str, box: str, node: str, slot: int) -> str:
    return f"{item}{box}{node}PLM{int(slot)}"


@dataclass
class Channel:
    ch: int
    iot: str
    it: Any
    dev: Any
    drive: Any
    state: Any
    desc2: Any
    sheet: str

    @property
    def base(self) -> Optional[str]:
        return tag_base(self.it, self.dev, self.drive)

    @property
    def di_tag(self) -> Optional[str]:
        b = self.base
        return sim_tag(b, "_I") if b else None


@dataclass
class Module:
    ntype: str
    kind: str
    item: str
    box: str
    node: str
    drop: int
    rack: int
    slot: int
    sheet: str
    channels: dict[int, Channel] = field(default_factory=dict)

    @property
    def name(self) -> str:
        return module_name(self.item, self.box, self.node, self.slot)

    @property
    def ddt(self) -> str:
        return ddt_name(self.drop, self.rack, self.slot)

    @property
    def owner(self) -> str:
        return owner_path(self.drop, self.rack, self.slot)

    @property
    def drop_label(self) -> str:
        return f"{self.item}{self.box}{self.node}"


@dataclass
class SiteData:
    site: str  # BSR130
    bpl: str  # BPL130
    cpu: dict
    nocs: list
    cras: list
    modules: list[Module]
    all_di: list[Channel]


def load_site(site: str) -> SiteData:
    path = INPUTS / f"{site}_IO_List.xlsx"
    wb = openpyxl.load_workbook(path, data_only=True)

    cpu = None
    nocs = []
    cras = []
    modules: dict[tuple, Module] = {}
    all_di: list[Channel] = []

    for sheet in wb.sheetnames:
        ws = wb[sheet]
        headers = [ws.cell(1, c).value for c in range(1, ws.max_column + 1)]
        cols: dict[str, int] = {}
        for i, h in enumerate(headers):
            if h and h not in cols:
                cols[h] = i + 1

        def g(r, h, default=None):
            c = cols.get(h)
            return ws.cell(r, c).value if c else default

        current_mod_key = None
        for r in range(2, ws.max_row + 1):
            item = g(r, "Item")
            box = g(r, "Box")
            node = g(r, "Node")
            drop, rack, slot, ch = g(r, "Drop"), g(r, "Rack"), g(r, "Slot"), g(r, "Ch")
            ntype, iot = g(r, "Node Type"), g(r, "IO Type")
            it, dev, state, drive = g(r, "Instrument Tag"), g(r, "Device"), g(r, "State"), g(r, "Drive")
            desc2 = g(r, "Desc2")

            if ntype and "BMEP58" in str(ntype):
                cpu = {
                    "item": item,
                    "box": box,
                    "node": node,
                    "ntype": str(ntype).strip(),
                    "desc2": desc2,
                    "slot": slot,
                }
            if ntype and "NOC0301" in str(ntype):
                nocs.append(
                    {
                        "item": item,
                        "box": box,
                        "slot": int(slot),
                        "desc2": desc2,
                        "iot": iot,
                    }
                )
            if ntype and "CRA31210" in str(ntype):
                cras.append(
                    {
                        "item": str(item),
                        "box": str(box),
                        "node": str(node),
                        "drop": int(drop),
                        "rack": int(rack or 0),
                        "slot": int(slot or 0),
                        "desc2": desc2,
                    }
                )

            kind = classify_card(str(ntype)) if ntype else None
            if kind and drop is not None and slot is not None:
                key = (int(drop), int(rack or 0), int(slot), str(item), str(box), str(node))
                if key not in modules:
                    modules[key] = Module(
                        ntype=str(ntype).strip(),
                        kind=kind,
                        item=str(item),
                        box=str(box),
                        node=str(node),
                        drop=int(drop),
                        rack=int(rack or 0),
                        slot=int(slot),
                        sheet=sheet,
                    )
                current_mod_key = key
            elif slot is not None and drop is not None and current_mod_key:
                # continuation rows for same slot may omit Node Type
                ck = current_mod_key
                if (
                    int(drop) == modules[ck].drop
                    and int(slot) == modules[ck].slot
                    and (rack is None or int(rack or 0) == modules[ck].rack)
                ):
                    pass
                else:
                    # try find module by drop/rack/slot
                    found = None
                    for k, m in modules.items():
                        if m.drop == int(drop) and m.rack == int(rack or 0) and m.slot == int(slot):
                            found = k
                            break
                    current_mod_key = found

            iot_s = str(iot).strip() if iot else None
            if (
                iot_s in SIM_IO_TYPES
                and drop is not None
                and slot is not None
                and ch is not None
            ):
                # attach to module
                key = None
                for k, m in modules.items():
                    if m.drop == int(drop) and m.rack == int(rack or 0) and m.slot == int(slot):
                        key = k
                        break
                chan = Channel(
                    ch=int(ch),
                    iot=iot_s,
                    it=it,
                    dev=dev,
                    drive=drive,
                    state=state,
                    desc2=desc2,
                    sheet=sheet,
                )
                if key:
                    modules[key].channels[int(ch)] = chan
                if iot_s == "DI" and chan.base:
                    all_di.append(chan)

    wb.close()

    bpl = "BPL" + site[-3:]
    if cpu and cpu.get("desc2") and str(cpu["desc2"]).startswith("BPL"):
        bpl = str(cpu["desc2"]).strip()

    mods = sorted(modules.values(), key=lambda m: (m.drop, m.rack, m.slot))
    cras = sorted(cras, key=lambda c: c["drop"])
    nocs = sorted(nocs, key=lambda n: n["slot"])

    return SiteData(
        site=site,
        bpl=bpl,
        cpu=cpu or {},
        nocs=nocs,
        cras=cras,
        modules=mods,
        all_di=all_di,
    )


# --------------- XML / ST emitters ---------------

def wrap_xst(bpl: str, prog_name: str, section_order: int, st_source: str, data_block: str) -> str:
    # ST source: escape only & that aren't already part of entities; we produce raw ST then escape <>&
    # Prefer escaping the whole ST for XML text content. Use &gt; for => like reference.
    st = st_source.replace("&", "&amp;").replace("=>", "=&gt;")
    return (
        '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n'
        "<STExchangeFile>\n"
        f'\t<fileHeader company="Schneider Automation" product="{PRODUCT}" '
        f'dateTime="{now_dt()}" content="Structured source file" DTDVersion="41"></fileHeader>\n'
        f'\t<contentHeader name="{bpl}" version="{VERSION}" dateTime="{CONTENT_DT}"></contentHeader>\n'
        "\t<program>\n"
        f'\t\t<identProgram name="{prog_name}" type="section" task="MAST" '
        f'SectionOrder="{section_order}"></identProgram>\n'
        f"\t\t<STSource>{st}</STSource>\n"
        "\t</program>\n"
        "\t<dataBlock>\n"
        f"{data_block}"
        "\t</dataBlock>\n"
        "</STExchangeFile>\n"
    )


def var_ebool(name: str, comment: str | None = None) -> str:
    if comment:
        return (
            f'\t\t<variables name="{name}" typeName="EBOOL">\n'
            f"\t\t\t<comment>{xml_esc(comment)}</comment>\n"
            f"\t\t</variables>\n"
        )
    return f'\t\t<variables name="{name}" typeName="EBOOL"></variables>\n'


def var_typed(
    name: str,
    type_name: str,
    comment: str | None = None,
    init: str | None = None,
) -> str:
    """Declare a typed variable; optional init becomes <value> for CE download default."""
    if comment is None and init is None:
        return f'\t\t<variables name="{name}" typeName="{type_name}"></variables>\n'
    parts = [f'\t\t<variables name="{name}" typeName="{type_name}">']
    if comment:
        parts.append(f"\t\t\t<comment>{xml_esc(comment)}</comment>")
    if init is not None:
        parts.append(f"\t\t\t<value>{xml_esc(str(init))}</value>")
    parts.append("\t\t</variables>\n")
    return "\n".join(parts)


def is_ehc_ss_channel(chan: Channel) -> bool:
    """True for underspeed / SS pulse channels on an EHC card."""
    if not chan or not chan.base:
        return False
    devu = str(chan.dev or "").strip().upper()
    desc = str(chan.desc2 or "").casefold()
    if re.match(r"SS\d+", devu):
        return True
    if "underspeed" in desc:
        return True
    return False


def make_ddi_ddt(name: str, owner: str) -> str:
    lines = [
        f'\t\t<variables name="{name}" typeName="T_U_DIS_STD_IN_32">',
        f'\t\t\t<attribute name="ManagedKey" value="{new_guid()}"></attribute>',
        f'\t\t\t<attribute name="Owner" value="{owner}"></attribute>',
        '\t\t\t<instanceElementDesc name="DIS_CH_IN">',
    ]
    for i in range(32):
        lines += [
            f'\t\t\t\t<instanceElementDesc name="[{i}]">',
            '\t\t\t\t\t<instanceElementDesc name="VALUE">',
            '\t\t\t\t\t\t<attribute name="TimeStampCapability" value="0"></attribute>',
            '\t\t\t\t\t\t<attribute name="TimeStampSource" value="2"></attribute>',
            '\t\t\t\t\t\t<attribute name="TimeStampID" value="32767"></attribute>',
            "\t\t\t\t\t</instanceElementDesc>",
            "\t\t\t\t</instanceElementDesc>",
        ]
    lines += ["\t\t\t</instanceElementDesc>", "\t\t</variables>\n"]
    return "\n".join(lines)


def make_ddo_ddt(name: str, owner: str) -> str:
    lines = [
        f'\t\t<variables name="{name}" typeName="T_U_DIS_STD_OUT_16">',
        f'\t\t\t<attribute name="ManagedKey" value="{new_guid()}"></attribute>',
        f'\t\t\t<attribute name="Owner" value="{owner}"></attribute>',
        '\t\t\t<instanceElementDesc name="DIS_CH_OUT">',
    ]
    for i in range(16):
        lines += [
            f'\t\t\t\t<instanceElementDesc name="[{i}]">',
            '\t\t\t\t\t<instanceElementDesc name="VALUE">',
            '\t\t\t\t\t\t<attribute name="TimeStampCapability" value="0"></attribute>',
            '\t\t\t\t\t\t<attribute name="TimeStampSource" value="2"></attribute>',
            '\t\t\t\t\t\t<attribute name="TimeStampID" value="32767"></attribute>',
            "\t\t\t\t\t</instanceElementDesc>",
            "\t\t\t\t</instanceElementDesc>",
        ]
    lines += ["\t\t\t</instanceElementDesc>", "\t\t</variables>\n"]
    return "\n".join(lines)


def make_ahi_ddt(name: str, owner: str) -> str:
    lines = [
        f'\t\t<variables name="{name}" typeName="T_U_ANA_STD_IN_8">',
        f'\t\t\t<attribute name="ManagedKey" value="{new_guid()}"></attribute>',
        f'\t\t\t<attribute name="Owner" value="{owner}"></attribute>',
        '\t\t\t<instanceElementDesc name="ANA_CH_IN">',
    ]
    for i in range(8):
        lines += [
            f'\t\t\t\t<instanceElementDesc name="[{i}]">',
            '\t\t\t\t\t<instanceElementDesc name="FCT_TYPE">',
            "\t\t\t\t\t\t<value>1</value>",
            "\t\t\t\t\t</instanceElementDesc>",
            "\t\t\t\t</instanceElementDesc>",
        ]
    lines += ["\t\t\t</instanceElementDesc>", "\t\t</variables>\n"]
    return "\n".join(lines)


def make_ehc_ddt(name: str, owner: str) -> str:
    return (
        f'\t\t<variables name="{name}" typeName="T_M_CPT_STD_IN_8">\n'
        f'\t\t\t<attribute name="ManagedKey" value="{new_guid()}"></attribute>\n'
        f'\t\t\t<attribute name="Owner" value="{owner}"></attribute>\n'
        f"\t\t</variables>\n"
    )


def make_art_ddt(name: str, owner: str) -> str:
    """DDT for BMXART0814 RTD module (sim_X80ART0814 oStsDDT = T_U_ANA_TEMP_IN_8)."""
    lines = [
        f'\t\t<variables name="{name}" typeName="T_U_ANA_TEMP_IN_8">',
        f'\t\t\t<attribute name="ManagedKey" value="{new_guid()}"></attribute>',
        f'\t\t\t<attribute name="Owner" value="{owner}"></attribute>',
        '\t\t\t<instanceElementDesc name="ANA_CH_IN">',
    ]
    for i in range(8):
        lines += [
            f'\t\t\t\t<instanceElementDesc name="[{i}]">',
            '\t\t\t\t\t<instanceElementDesc name="FCT_TYPE">',
            "\t\t\t\t\t\t<value>1</value>",
            "\t\t\t\t\t</instanceElementDesc>",
            "\t\t\t\t</instanceElementDesc>",
        ]
    lines += ["\t\t\t</instanceElementDesc>", "\t\t</variables>\n"]
    return "\n".join(lines)


def make_cra_ddt(name: str, owner: str) -> str:
    return (
        f'\t\t<variables name="{name}" typeName="T_M_CRA_EXT_IN">\n'
        f'\t\t\t<attribute name="ManagedKey" value="{new_guid()}"></attribute>\n'
        f'\t\t\t<attribute name="Owner" value="{owner}"></attribute>\n'
        f'\t\t\t<instanceElementDesc name="SOE_UNCERTAIN">\n'
        f'\t\t\t\t<attribute name="TimeStampCapability" value="1"></attribute>\n'
        f'\t\t\t\t<attribute name="TimeStampSource" value="2"></attribute>\n'
        f'\t\t\t\t<attribute name="TimeStampID" value="0"></attribute>\n'
        f"\t\t\t</instanceElementDesc>\n"
        f"\t\t</variables>\n"
    )


def bit_to_word_block(var_name: str, bits: list[str]) -> str:
    """bits: 16 entries of 'sim_..._I' or 'FALSE'."""
    assert len(bits) == 16
    lines = [f"{var_name} := BIT_TO_WORD("]
    for i, b in enumerate(bits):
        pad = " " if i < 10 else ""
        comma = "," if i < 15 else ");"
        lines.append(f"\t\tBIT{i}{pad} := {b}{comma}")
    return "\n".join(lines)


def emit_ddi_st(mod: Module, dfb_idx: int) -> tuple[str, list[str], set[str]]:
    """Return ST fragment, dataBlock var lines needed, and DI tags referenced."""
    tags: set[str] = set()
    grp1, grp2 = [], []
    for ch in range(16):
        chan = mod.channels.get(ch)
        if chan and chan.iot == "DI" and chan.di_tag:
            grp1.append(chan.di_tag)
            tags.add(chan.di_tag)
        else:
            grp1.append("FALSE")
    for ch in range(16, 32):
        chan = mod.channels.get(ch)
        if chan and chan.iot == "DI" and chan.di_tag:
            grp2.append(chan.di_tag)
            tags.add(chan.di_tag)
        else:
            grp2.append("FALSE")

    g1 = f"sim_{mod.name}_Grp1DDI"
    g2 = f"sim_{mod.name}_Grp2DDI"
    modflt = f"sim_{mod.name}_ModFlt"
    g1flt = f"sim_{mod.name}_Grp1flt"
    g2flt = f"sim_{mod.name}_Grp2flt"
    dfb = f"sim_X80DDI3202K_{dfb_idx}"

    st = []
    st.append(f"(* {mod.ntype} - {mod.name} *)")
    st.append(bit_to_word_block(g1, grp1))
    st.append(bit_to_word_block(g2, grp2))
    st.append("\t(* Simulation 32 Channel DDI*)")
    st.append(
        f"{dfb} (\n"
        f"\t   iModFlt  \t:= {modflt},\n"
        f"           iGrp1Flt \t:= {g1flt},\n"
        f"\t   iGrp2Flt \t:= {g2flt},\n"
        f"           iGrp1WordHty := {g1},\n"
        f"           iGrp2WordHty := {g2},\n"
        f"           oInDatDDT    => {mod.ddt});"
    )
    st.append("")

    db = [
        var_typed(g1, "WORD"),
        var_typed(g2, "WORD"),
        var_ebool(modflt),
        var_ebool(g1flt),
        var_ebool(g2flt),
        var_typed(dfb, "SIM_X80DDI3202K"),
        make_ddi_ddt(mod.ddt, mod.owner),
    ]
    for t in sorted(tags):
        db.append(var_ebool(t))
    return "\n".join(st), db, tags


def emit_ddo_st(mod: Module, dfb_idx: int) -> tuple[str, list[str]]:
    modflt = f"sim_{mod.name}_ModFlt"
    dfb = f"SIM_X80DDO1602K_{dfb_idx}"
    st = (
        f"(* {mod.ntype} - {mod.name} *)\n"
        f"{dfb} (\n"
        f"\t   iModFlt  \t:= {modflt},\n"
        f"           oStsDat    => {mod.ddt});\n"
    )
    db = [
        var_ebool(modflt),
        var_typed(dfb, "SIM_X80DDO1602K"),
        make_ddo_ddt(mod.ddt, mod.owner),
    ]
    return st, db


def emit_ahi_st(mod: Module, dfb_idx: int) -> tuple[str, list[str]]:
    modflt = f"sim_{mod.name}_ModFlt"
    dfb = f"SIM_X80_AHI0812_{dfb_idx}"
    pin_lines = [f"\t   iModFlt := {modflt},"]
    db = [var_ebool(modflt), var_typed(dfb, "sim_X80AHI0812"), make_ahi_ddt(mod.ddt, mod.owner)]
    for ch in range(8):
        chan = mod.channels.get(ch)
        used = bool(chan and chan.iot == "AI" and chan.base)
        if used:
            flt = f"Sim_{mod.name}_Ch{ch:02d}Flt"
            pv = f"Sim_{mod.name}_Ch{ch:02d}PV"
            pin_lines.append(f"                   iCh{ch}Flt := {flt},")
            pin_lines.append(f"                   iCh{ch}PV := {pv},")
            db.append(var_typed(flt, "INT"))
            db.append(var_typed(pv, "REAL"))
        else:
            pin_lines.append(f"                   iCh{ch}Flt := 0,")
            pin_lines.append(f"                   iCh{ch}PV := 0.0,")
    pin_lines.append(f"\t 	  oStsDDT    => {mod.ddt});")
    st = f"(* {mod.ntype} - {mod.name} *)\n{dfb} (\n" + "\n".join(pin_lines) + "\n"
    return st, db


def emit_ehc_st(mod: Module, dfb_idx: int) -> tuple[str, list[str], set[str]]:
    """Instantiate sim_X80EHC0800 DFB in Option B (speed-sim) mode.

    For each SS/underspeed device on the card, declare writable SP + conversion
    gains/offsets. The DFB has a single iSpdSP/iFrqSP pair — wire it from the
    first SS device; additional SS SP vars remain available for operators.
    """
    modflt = f"sim_{mod.name}_ModFlt"
    dfb = f"sim_X80EHC0800_{dfb_idx}"
    tags: set[str] = set()
    comment_lines: list[str] = []
    ss_bases: list[str] = []
    first_tagged_base: Optional[str] = None

    for ch in range(8):
        chan = mod.channels.get(ch)
        if chan and chan.base:
            t = sim_tag(chan.base, "_I")
            comment_lines.append(f"(* Ch{ch}: {t} / {chan.desc2 or ''} *)")
            if first_tagged_base is None:
                first_tagged_base = chan.base
            if is_ehc_ss_channel(chan) and chan.base not in ss_bases:
                ss_bases.append(chan.base)

    # No SS found: name SP from first tagged channel base (e.g. ZQ-only card)
    if not ss_bases and first_tagged_base:
        ss_bases = [first_tagged_base]

    st: list[str] = []
    st.append(f"(* {mod.ntype} - {mod.name} *)")
    st.extend(comment_lines)

    db: list[str] = [
        var_ebool(modflt, f"{mod.name} EHC Module Fault"),
        var_typed(dfb, "sim_X80EHC0800"),
        make_ehc_ddt(mod.ddt, mod.owner),
        var_typed(
            "sim_EHC_ScnTm",
            "INT",
            comment="EHC shared PLC scan time (ms)",
            init="50",
        ),
    ]

    if ss_bases:
        drive = ss_bases[0]
        extras = ss_bases[1:]
        if extras:
            st.append(
                f"(* Option B speed-sim: DFB iSpdSP/iFrqSP driven by first SS "
                f"{drive}; additional SS SP vars ({', '.join(extras)}) "
                f"available for operators but not wired to this DFB instance *)"
            )
        elif first_tagged_base and drive == first_tagged_base and not any(
            is_ehc_ss_channel(mod.channels.get(ch))
            for ch in range(8)
            if mod.channels.get(ch)
        ):
            st.append(
                f"(* Option B speed-sim: no SS on card — SP named from first "
                f"tagged channel {drive} *)"
            )
        else:
            st.append(f"(* Option B speed-sim: DFB driven by {drive} SP *)")

        for b in ss_bases:
            db.append(
                var_typed(
                    f"sim_{b}_SP",
                    "REAL",
                    comment=f"{b} speed-sim engineering setpoint",
                    init="0.0",
                )
            )
            db.append(
                var_typed(
                    f"sim_{b}_SpdGain",
                    "REAL",
                    comment=f"{b} speed SP gain",
                    init="1.0",
                )
            )
            db.append(
                var_typed(
                    f"sim_{b}_SpdOff",
                    "REAL",
                    comment=f"{b} speed SP offset",
                    init="0.0",
                )
            )
            db.append(
                var_typed(
                    f"sim_{b}_FrqGain",
                    "REAL",
                    comment=f"{b} frequency SP gain (Hz per eng unit)",
                    init="1.0",
                )
            )
            db.append(
                var_typed(
                    f"sim_{b}_FrqOff",
                    "REAL",
                    comment=f"{b} frequency SP offset",
                    init="0.0",
                )
            )

        sp = f"sim_{drive}_SP"
        spd_g = f"sim_{drive}_SpdGain"
        spd_o = f"sim_{drive}_SpdOff"
        frq_g = f"sim_{drive}_FrqGain"
        frq_o = f"sim_{drive}_FrqOff"
        st.append(
            f"{dfb} (\n"
            f"\t   iEnable := TRUE,\n"
            f"\t   iFlt := {modflt},\n"
            f"\t   iCh0Flt := FALSE,\n"
            f"\t   iCh1Flt := FALSE,\n"
            f"\t   iCh0CntFlt := FALSE,\n"
            f"\t   iCh1CntFlt := FALSE,\n"
            f"\t   iCustomMode := 0,\n"
            f"\t   iRun := TRUE,\n"
            f"\t   iSpdSP := {sp} * {spd_g} + {spd_o},\n"
            f"\t   iFrqSP := {sp} * {frq_g} + {frq_o},\n"
            f"\t   iScnTm := sim_EHC_ScnTm,\n"
            f"\t   iEng := TRUE,\n"
            f"\t   iPlsCntRst := FALSE,\n"
            f"\t   oDatDDT => {mod.ddt});\n"
        )
    else:
        st.append("(* Option B speed-sim: no tagged channels — zero setpoints *)")
        st.append(
            f"{dfb} (\n"
            f"\t   iEnable := TRUE,\n"
            f"\t   iFlt := {modflt},\n"
            f"\t   iCh0Flt := FALSE,\n"
            f"\t   iCh1Flt := FALSE,\n"
            f"\t   iCh0CntFlt := FALSE,\n"
            f"\t   iCh1CntFlt := FALSE,\n"
            f"\t   iCustomMode := 0,\n"
            f"\t   iRun := TRUE,\n"
            f"\t   iSpdSP := 0.0,\n"
            f"\t   iFrqSP := 0.0,\n"
            f"\t   iScnTm := sim_EHC_ScnTm,\n"
            f"\t   iEng := TRUE,\n"
            f"\t   iPlsCntRst := FALSE,\n"
            f"\t   oDatDDT => {mod.ddt});\n"
        )

    return "\n".join(st), db, tags


def emit_art_st(mod: Module, dfb_idx: int) -> tuple[str, list[str]]:
    """Instantiate sim_X80ART0814 DFB (BMXART0814 RTD) from provided XDB template.

    Interface mirrors AHI (iModFlt + per-channel Flt/PV) but oStsDDT is
    T_U_ANA_TEMP_IN_8. Note XDB pin typo: channel 6 fault is named iCH6Flt.
    """
    modflt = f"sim_{mod.name}_ModFlt"
    dfb = f"sim_X80ART0814_{dfb_idx}"
    # Exact DFB pin names from sim_X80ART0814 XDB (iCH6Flt has capital H)
    flt_pins = [f"iCh{ch}Flt" for ch in range(8)]
    flt_pins[6] = "iCH6Flt"
    pin_lines = [f"\t   iModFlt := {modflt},"]
    db = [
        var_ebool(modflt, f"{mod.name} ART Module Fault"),
        var_typed(dfb, "sim_X80ART0814"),
        make_art_ddt(mod.ddt, mod.owner),
    ]
    for ch in range(8):
        chan = mod.channels.get(ch)
        used = bool(chan and chan.iot == "RTDI" and chan.base)
        flt_pin = flt_pins[ch]
        if used:
            flt = f"Sim_{mod.name}_Ch{ch:02d}Flt"
            pv = f"Sim_{mod.name}_Ch{ch:02d}PV"
            pin_lines.append(f"                   {flt_pin} := {flt},")
            pin_lines.append(f"                   iCh{ch}PV := {pv},")
            db.append(var_typed(flt, "INT"))
            db.append(var_typed(pv, "REAL"))
        else:
            pin_lines.append(f"                   {flt_pin} := 0,")
            pin_lines.append(f"                   iCh{ch}PV := 0.0,")
    pin_lines.append(f"\t \t  oStsDDT    => {mod.ddt});")
    st = f"(* {mod.ntype} - {mod.name} *)\n{dfb} (\n" + "\n".join(pin_lines) + "\n"
    return st, db


def generate_iomap(site: SiteData) -> str:
    st: list[str] = []
    st.append(
        "(* ************* Description ***********************************************\n"
        "This Section Contains DX Drop Simulation \n"
        "**************************************************************************** *)\n"
        "\n"
        "\n"
        "(* ============ START OF SIMULATION ======================================== *)\n"
        "IF sim_SetHealthy THEN\n"
    )
    db_vars: list[str] = [var_ebool("sim_SetHealthy")]
    seen_db: set[str] = {"sim_SetHealthy"}
    di_tags: set[str] = set()

    ddi_i = ddo_i = ahi_i = ehc_i = art_i = 0
    skipped = []

    # Group modules by drop
    by_drop: dict[int, list[Module]] = defaultdict(list)
    for m in site.modules:
        by_drop[m.drop].append(m)

    for drop in sorted(by_drop):
        mods = by_drop[drop]
        label = mods[0].drop_label
        st.append(
            "(* -------------------------------------------------------------------------\n"
            f"\t\t{label} DROP {drop}\n"
            "---------------------------------------------------------------------------- *)\n"
        )
        for mod in mods:
            if mod.kind == "DDI":
                frag, db, tags = emit_ddi_st(mod, ddi_i)
                ddi_i += 1
                st.append(frag)
                di_tags |= tags
                for line in db:
                    # dedupe by variable name
                    nm = re.search(r'name="([^"]+)"', line)
                    if nm and nm.group(1) not in seen_db:
                        seen_db.add(nm.group(1))
                        db_vars.append(line)
            elif mod.kind == "DDO":
                frag, db = emit_ddo_st(mod, ddo_i)
                ddo_i += 1
                st.append(frag)
                for line in db:
                    nm = re.search(r'name="([^"]+)"', line)
                    if nm and nm.group(1) not in seen_db:
                        seen_db.add(nm.group(1))
                        db_vars.append(line)
            elif mod.kind == "AHI":
                frag, db = emit_ahi_st(mod, ahi_i)
                ahi_i += 1
                st.append(frag)
                for line in db:
                    nm = re.search(r'name="([^"]+)"', line)
                    if nm and nm.group(1) not in seen_db:
                        seen_db.add(nm.group(1))
                        db_vars.append(line)
            elif mod.kind == "EHC":
                frag, db, tags = emit_ehc_st(mod, ehc_i)
                ehc_i += 1
                st.append(frag)
                di_tags |= tags
                for line in db:
                    nm = re.search(r'name="([^"]+)"', line)
                    if nm and nm.group(1) not in seen_db:
                        seen_db.add(nm.group(1))
                        db_vars.append(line)
            elif mod.kind == "ART":
                frag, db = emit_art_st(mod, art_i)
                art_i += 1
                st.append(frag)
                for line in db:
                    nm = re.search(r'name="([^"]+)"', line)
                    if nm and nm.group(1) not in seen_db:
                        seen_db.add(nm.group(1))
                        db_vars.append(line)
            elif mod.kind == "AHO":
                # AHO0412 intentionally skipped — no simulation DFB template provided
                skipped.append(f"{mod.kind} {mod.name} (no sim DFB template)")
                st.append(f"(* SKIPPED {mod.ntype} - {mod.name}: no simulation DFB template *)\n")
            else:
                skipped.append(f"unknown {mod.ntype} {mod.name}")

    st.append("(*========== END if sim_SetHealthy ==========*)")
    st.append("END_IF;")
    st.append("(* ========== END OF SIMULATION ========== *)")
    st.append("")

    return wrap_xst(site.bpl, "sim_PLC_IOmap", 5, "\n".join(st), "".join(db_vars)), {
        "ddi": ddi_i,
        "ddo": ddo_i,
        "ahi": ahi_i,
        "ehc": ehc_i,
        "art": art_i,
        "di_tags": len(di_tags),
        "skipped": skipped,
    }


def generate_module(site: SiteData) -> tuple[str, dict]:
    bpl = site.bpl
    st: list[str] = []
    st.append("(* Head Rack Modules Simulation\nCRA Modules Simulation *)\n")
    st.append("IF sim_SetHealthy THEN\n")
    st.append("\n\t(* =========== HEAD RACK =========== *)")
    st.append("\t(* Set PLC Links Healthy *)")
    st.append(f"\tsim_{bpl}PLM0_Mode := 1;(* set ethernet 1 to active (service port) *)")
    st.append(
        f"\tSIM_BMEP586x4xRIO_0 (iMode := Sim_{bpl}PLM0_Mode,\n"
        f"\t                     iFlt := Sim_{bpl}PLM0_Flt,\n"
        f"\t                     iLnkNotAct := Sim_{bpl}PLM0_LnkFlt,\n"
        f"\t                     oInDatDDT => BMEP58_ECPU_EXT);"
    )

    db: list[str] = [
        var_ebool("sim_SetHealthy"),
        var_typed(f"Sim_{bpl}PLM0_Mode", "INT", "PLC Ethernet Module Configuration of Ethernet Link (1=ETH1, 2=ETH2, 3=ET3, default = ETH1)"),
        var_ebool(f"Sim_{bpl}PLM0_Flt", "PLC Ethernet Module Sim Module Not Running Fault"),
        var_ebool(f"Sim_{bpl}PLM0_LnkFlt", "PLC Ethernet Module Sim Set Ethernet Link Not Active"),
        var_typed("SIM_BMEP586x4xRIO_0", "SIM_BMEP586x4xRIO"),
        var_typed(
            "BMEP58_ECPU_EXT",
            "T_BMEP58_ECPU_EXT2",
        ),
    ]
    # Fix BMEP DDT with owner-like attributes if present in template
    db[-1] = (
        f'\t\t<variables name="BMEP58_ECPU_EXT" typeName="T_BMEP58_ECPU_EXT2">\n'
        f'\t\t\t<attribute name="ManagedKey" value="{new_guid()}"></attribute>\n'
        f"\t\t</variables>\n"
    )

    # NOC modules – map slots to PLC_3 / HMI_4 / IO_5 like BSR131
    noc_targets = {3: ("PLC_3", 0), 4: ("HMI_4", 1), 5: ("IO_5", 2)}
    st.append("\t(* ===== NOC Sim ===== *)")
    for noc in site.nocs:
        slot = noc["slot"]
        if slot not in noc_targets:
            continue
        ddt, idx = noc_targets[slot]
        mode = f"Sim_{bpl}PLM{slot}_Mode"
        flt = f"Sim_{bpl}PLM{slot}_Flt"
        com = f"Sim_{bpl}PLM{slot}_ComFlt"
        lnk = f"Sim_{bpl}PLM{slot}_LnkFlt"
        inst = f"sim_noc0301_{idx}"
        if slot == 5:
            # IO NOC forced healthy like reference
            st.append(f"\t{mode} := 1;(* set ethernet 1 to active (service port) *)")
            st.append(
                f"\t{inst} (iMode := {mode},\n"
                f"\t               iFlt := {flt},\n"
                f"\t\t       iComFlt \t:= {com},\n"
                f"\t               iLnkNotAct := {lnk},\n"
                f"\t               oInDatDDT => {ddt});"
            )
        else:
            st.append(f"\tIF {mode} = 1 THEN(* set ethernet 1 to active (service port) *)")
            st.append(
                f"\t{inst} (iMode \t:= {mode},\n"
                f"               \t\tiFlt \t:= {flt},\n"
                f"               \t\tiComFlt := {com},\n"
                f"               \t\tiLnkNotAct := {lnk},\n"
                f"               \t\toInDatDDT => {ddt});\t\t"
            )
            st.append("\tEND_IF;")
        db += [
            var_typed(mode, "INT",
                      "NPI Hub PLC Ethernet Module Configuration of Ethernet Link (1=ETH1, 2=ETH2, 3=ET3, default = ETH1)"),
            var_ebool(flt, "NPI Hub PLC Ethernet Module Sim Module Not Running Fault"),
            var_ebool(com, "NPI Hub PLC Ethernet Module Sim Communications Failure"),
            var_ebool(lnk, "NPI Hub PLC Ethernet Module Sim Set Ethernet Link Not Active"),
            var_typed(inst, "sim_noc0301"),
            (
                f'\t\t<variables name="{ddt}" typeName="T_BMENOC0301_4">\n'
                f'\t\t\t<attribute name="ManagedKey" value="{new_guid()}"></attribute>\n'
                f"\t\t</variables>\n"
            ),
        ]

    # CRA per drop
    for cra in site.cras:
        drop = cra["drop"]
        label = f"{cra['item']}{cra['box']}{cra['node']}PLM0"
        ddt = ddt_name(drop, cra["rack"], 0)
        inst = f"SIM_CRA31210_{drop}"
        st.append(f"\n\t(* =========== {label} - DROP {drop} =========== *)")
        flt = f"Sim_{label}_Flt"
        com = f"Sim_{label}_ComFlt"
        lnk = f"Sim_{label}_LnkFlt"
        st.append(
            f"\t{inst} (iMode := 1,\t(* set ethernet 1 to active (service port) *)\n"
            f"                     iFlt \t:= {flt},\n"
            f"                     iComFlt \t:= {com},\n"
            f"                     iLnkNotAct := {lnk},\n"
            f"                     oInDatDDT \t=> {ddt}); "
        )
        db += [
            var_typed(inst, "SIM_CRA31210"),
            var_ebool(flt, f"{cra['item']}{cra['box']} CRA Comms Module 0 Sim Module Not Running Fault"),
            var_ebool(com, f"{cra['item']}{cra['box']} CRA Comms Module 0 Sim Communications Failure"),
            var_ebool(lnk, f"{cra['item']}{cra['box']} CRA Comms Module 0 Sim Set Ethernet Link Not Active"),
            make_cra_ddt(ddt, owner_path(drop, cra["rack"], 0)),
        ]

    st.append("end_if;")
    st.append("")

    # dedupe db by name (case-insensitive — CE treats Sim_X / sim_X as one var)
    seen = set()
    db_out = []
    for line in db:
        nm = re.search(r'name="([^"]+)"', line)
        if not nm:
            continue
        key = nm.group(1).lower()
        if key in seen:
            continue
        seen.add(key)
        db_out.append(line)

    return wrap_xst(site.bpl, "sim_PLC_module", 4, "\n".join(st), "".join(db_out)), {
        "cras": len(site.cras),
        "nocs": len(site.nocs),
    }


def generate_initialise(site: SiteData) -> tuple[str, dict]:
    """Build Initialise from DI channels with sectioned comments."""
    # Collect unique DI tags with metadata
    by_tag: dict[str, Channel] = {}
    for ch in site.all_di:
        t = ch.di_tag
        if t and t not in by_tag:
            by_tag[t] = ch

    isolators = []
    cb_init = []  # battery / UPS DB / DX VDC & CB
    incomers = []
    feeders_setok = []
    misc_sub = []
    safety = []
    pushbuttons = []
    thermistors = []
    flow_sw = []
    level_sw = []
    valves = []
    other = []

    site_num = site.site  # BSR130
    for tag, ch in by_tag.items():
        dev = str(ch.dev or "").upper()
        it = str(ch.it or "")
        desc = str(ch.desc2 or "")
        val = state_to_val(ch.state, ch.dev, ch.desc2)

        # Main circuit breaker trips → SetOK
        if re.match(r"TRP\d+", dev) and "Main Circuit Breaker" in desc:
            base = ch.base
            feeders_setok.append((sim_tag(base, "_SetOK"), 1, ch))
            continue

        if re.match(r"IS\d+", dev):
            isolators.append((tag, val, ch))
        elif re.match(r"SYS\d+", dev):
            safety.append((tag, val, ch))
        elif re.match(r"STT\d+|STP\d+", dev):
            pushbuttons.append((tag, 0, ch))
        elif re.match(r"THR\d+", dev):
            thermistors.append((tag, val, ch))
        elif re.match(r"FS\d+", dev) or (ch.base and re.search(r"FS\d+$", ch.base.upper()) and dev.startswith("FS")):
            flow_sw.append((tag, val, ch))
        elif re.match(r"LS\d+", dev) or (ch.base and re.search(r"LS\d+$", ch.base.upper())):
            level_sw.append((tag, val, ch))
        elif "FV" in it.upper() or (ch.drive and "FV" in str(ch.drive).upper()):
            valves.append((tag, val, ch))
        elif "INC" in it.upper():
            incomers.append((tag, val, ch))
        elif re.match(r"(CB|VDC)\d+", dev) and (
            "BC" in it or "UP" in it or "DX" in it or "DB" in it and "UP" in it
        ):
            cb_init.append((tag, val, ch))
        elif re.match(r"FQ\d+", dev):
            continue  # pulses not initialised
        elif ch.sheet.startswith("Sub"):
            # remaining sub
            if re.match(r"(CB|VDC)\d+", dev) and ("DX" in it or it.startswith(site_num)):
                cb_init.append((tag, val, ch))
            else:
                misc_sub.append((tag, val, ch))
        else:
            other.append((tag, val, ch))

    # Also add DX drop power VDCs/CBs from field sheet that look like panel healthy
    for tag, ch in by_tag.items():
        dev = str(ch.dev or "").upper()
        it = str(ch.it or "")
        if re.match(r"(CB|VDC)\d+", dev) and re.search(r"DX\d+", it):
            if (tag, state_to_val(ch.state, ch.dev, ch.desc2), ch) not in cb_init and not any(
                t == tag for t, _, _ in cb_init
            ):
                # group under remote DX sections later via misc if not already
                if not any(t == tag for t, _, _ in cb_init):
                    cb_init.append((tag, state_to_val(ch.state, ch.dev, ch.desc2), ch))

    def emit_assigns(items: list[tuple], blank_every: int | None = None) -> list[str]:
        lines = []
        for i, (tag, val, _) in enumerate(items):
            lines.append(f"{tag} :={val};" if False else f"{tag} :={val};")
            # prefer space style like reference: :=1 or :=0 without space sometimes; use :=1
            lines[-1] = f"{tag} :={val};"
        return lines

    # Deduplicate lists preserving order
    def dedupe(seq):
        seen = set()
        out = []
        for t, v, c in seq:
            if t in seen:
                continue
            seen.add(t)
            out.append((t, v, c))
        return out

    isolators = dedupe(isolators)
    cb_init = dedupe(cb_init)
    incomers = dedupe(incomers)
    feeders_setok = dedupe(feeders_setok)
    misc_sub = dedupe(misc_sub)
    safety = dedupe(safety)
    pushbuttons = dedupe(pushbuttons)
    thermistors = dedupe(thermistors)
    flow_sw = dedupe(flow_sw)
    level_sw = dedupe(level_sw)
    valves = dedupe(valves)
    other = dedupe(other)

    # Remove tags already in earlier sections from later ones
    claimed = set()
    for seq in (
        isolators,
        cb_init,
        incomers,
        feeders_setok,
        safety,
        pushbuttons,
        thermistors,
        flow_sw,
        level_sw,
        valves,
    ):
        for t, _, _ in seq:
            claimed.add(t)
    misc_sub = [(t, v, c) for t, v, c in misc_sub if t not in claimed]
    other = [(t, v, c) for t, v, c in other if t not in claimed]
    for t, _, _ in misc_sub + other:
        claimed.add(t)

    st: list[str] = []
    st.append("IF sim_init THEN")
    st.append("\tsim_init := 0; (* reset initialisation bit *)")
    st.append("")
    st.append("")
    st.append("(* ===========================================")
    st.append("\tIsolators Set Healthy")
    st.append("============================================== *)")
    st.append("")
    for t, v, _ in isolators:
        st.append(f"{t}\t\t:={v};")
    st.append("")
    st.append("(* ===========================================")
    st.append("\tCircuit Breaker Initialisation")
    st.append("============================================== *)")
    st.append("")
    # group CB by instrument prefix
    for t, v, _ in cb_init:
        st.append(f"{t} :={v};")
    st.append("")
    st.append("")
    st.append("(* ---- Incomers ----------------------- *)")
    for t, v, _ in incomers:
        st.append(f"{t} :={v};")
    st.append("")
    st.append("(* ---- Feeders ----------------------- *)")
    for t, v, _ in feeders_setok:
        st.append(f"{t} :={v};")
    st.append("")
    st.append("(* ===========================================")
    st.append("\tMisc Sub Equipment")
    st.append("============================================== *)")
    st.append("")
    for t, v, _ in misc_sub:
        st.append(f"{t} :={v};")
    st.append("")
    st.append("")
    st.append("(* ===========================================")
    st.append("\tSAFETY Initialisation")
    st.append("============================================== *)")
    st.append("(* ---- Safety Relays ----------------------- *)")
    st.append("")
    for t, v, _ in safety:
        st.append(f"{t} :={v};")
    st.append("")
    st.append("")
    st.append("(* ===========================================")
    st.append("\tPush Button Set 0")
    st.append("============================================== *)")
    st.append("")
    for t, v, _ in pushbuttons:
        st.append(f"{t} :={v};")
    st.append("")
    st.append("(* ===========================================")
    st.append("\tMisc Field Equipment")
    st.append("============================================== *)")
    st.append("(* ---- Thermistors ----------------------- *)")
    for t, v, _ in thermistors:
        st.append(f"{t} :={v};")
    st.append("")
    st.append("(* ---- Flow Switches ----------------------- *)")
    for t, v, _ in flow_sw:
        st.append(f"{t} :={v};")
    st.append("")
    st.append("(* ---- Level Switches ----------------------- *)")
    for t, v, _ in level_sw:
        st.append(f"{t} :={v};")
    st.append("")
    st.append("(* ---- Valves  ----------------------- *)")
    for t, v, _ in valves:
        st.append(f"{t} :={v};")
    st.append("")
    if other:
        st.append("(* ---- Other DI ----------------------- *)")
        for t, v, _ in other:
            st.append(f"{t} :={v};")
        st.append("")

    # IED / PR-rack sim DI (TeSysT, REX640, …) — excluded from X80 IOmap
    ied_items = []
    try:
        from generate_sim_equipment import collect_ied_init_tags

        ied = collect_ied_init_tags(site.site)
        claimed_init = {t for t, _, _ in (
            isolators + cb_init + incomers + feeders_setok + misc_sub + safety
            + pushbuttons + thermistors + flow_sw + level_sw + valves + other
        )}
        for cat, items in ied.items():
            for tag, val, cmt in items:
                if tag not in claimed_init:
                    ied_items.append((tag, val, cat))
                    claimed_init.add(tag)
    except Exception:
        ied_items = []

    if ied_items:
        st.append("")
        st.append("(* ===========================================")
        st.append("\tIED / PR-rack Simulation Inputs")
        st.append("============================================== *)")
        st.append("")
        by_cat = {}
        for tag, val, cat in ied_items:
            by_cat.setdefault(cat, []).append((tag, val))
        for cat, pairs in by_cat.items():
            st.append(f"(* ---- {cat} ----------------------- *)")
            for tag, val in pairs:
                st.append(f"{tag} :={val};")
            st.append("")

    st.append("")
    st.append("END_IF;")
    st.append("")

    # dataBlock: all assigned tags + sim_init
    ied_for_db = [(t, v, None) for t, v, _cat in ied_items]
    all_items = (
        isolators
        + cb_init
        + incomers
        + feeders_setok
        + misc_sub
        + safety
        + pushbuttons
        + thermistors
        + flow_sw
        + level_sw
        + valves
        + other
        + ied_for_db
    )
    db = [var_ebool("sim_init")]
    seen = {"sim_init"}
    for t, _, _ in all_items:
        if t not in seen:
            seen.add(t)
            db.append(var_ebool(t))

    stats = {
        "init_tags": len(seen) - 1,
        "setok": len(feeders_setok),
        "isolators": len(isolators),
        "pushbuttons": len(pushbuttons),
        "ied_tags": len(ied_items),
    }
    return wrap_xst(site.bpl, "sim_Initialise", 7, "\n".join(st), "".join(db)), stats


def generate_site(site_name: str) -> dict:
    site = load_site(site_name)
    out_dir = OUTPUTS / site_name
    out_dir.mkdir(parents=True, exist_ok=True)

    iomap_xml, iomap_stats = generate_iomap(site)
    module_xml, module_stats = generate_module(site)
    init_xml, init_stats = generate_initialise(site)

    files = {
        "sim_PLC_IOmap.XST": iomap_xml,
        "sim_PLC_module.XST": module_xml,
        "sim_Initialise.XST": init_xml,
    }
    sizes = {}
    for name, content in files.items():
        p = out_dir / name
        p.write_text(content, encoding="utf-8")
        sizes[name] = p.stat().st_size

    return {
        "site": site_name,
        "bpl": site.bpl,
        "modules": len(site.modules),
        "module_kinds": {
            k: sum(1 for m in site.modules if m.kind == k)
            for k in ("DDI", "DDO", "AHI", "AHO", "EHC", "ART")
        },
        "cras": len(site.cras),
        "nocs": len(site.nocs),
        "sizes": sizes,
        "iomap": iomap_stats,
        "module": module_stats,
        "init": init_stats,
        "paths": [str(out_dir / n) for n in files],
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("sites", nargs="*", default=["BSR130", "BSR132"])
    args = ap.parse_args()
    for s in args.sites:
        info = generate_site(s)
        print(f"Generated {s} ({info['bpl']}):")
        print(f"  modules={info['modules']} kinds={info['module_kinds']}")
        print(f"  iomap={info['iomap']}")
        print(f"  init_tags={info['init']['init_tags']}")
        print(f"  sizes={info['sizes']}")
        for p in info["paths"]:
            print(f"  wrote {p}")


if __name__ == "__main__":
    main()
