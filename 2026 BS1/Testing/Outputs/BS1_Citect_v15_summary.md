# BS1_Citect_v15 – summary

Tim: "create the alarms for them". Built from v14. SCADA References is byte-identical to v14. SCADA Alarms has 37 new rows (4825–4861), all red: one per unique Referenced Item among the 50 rows restored in v14. calcChain stays removed; fullCalcOnLoad is on; vbaProject.bin is byte-identical to Tim's file.

## Counts
- 37 unique items from 50 reference rows. Duplicates got one alarm each: NOT_BCV131RIS01PLC01_SysOK_Hty ×4, NOT_BS1OLC2_CshStp_Hty ×3, NOT_BCV130SPY1FIT01_Dsc_Hty ×3, BCV131FN01_AutRun ×3, NOT_BAF131HP01FS04_Hty ×2, BCV130MA01FN03/FN04_SeqReq ×2, and the expression item ×2.
- NOT_ interlocks: 18; _A alarms: 9; other status items: 10
- Every SCADA References item now exists in SCADA Alarms or SCADA Tags (0 missing).

## Rules used
- **NOT_X:** v13 interlock form. Var A "NOT X"; Custom 1 X; Cat from the reference Category (IL_Critical wins a tie); C_HIPRI, Class_Process, Custom 7 blank; Desc ends in "Interlock".
- **_A:** Var A and Custom 1 are the tag. Cat, Custom 6 and Custom 8 copy the sibling alarm (all CAT_P3 / C_HIPRI / Class_Process; there are no pullwire or SY01 FTC/FTO items). Custom 7 is the instrument code, as on Tim's BPP rows.
- **Other items (_SeqReq, _AutRun, _StpReq, _C, _S):** these follow Tim's plain interlock rows (e.g. BCV131WN1_AutSlp, BCV131WN1AUTSTP01_Stp). Var A and Custom 1 are the item; Cat is the reference IL category; C_HIPRI, Class_Process; no "Interlock" suffix.
- **Equipment:** the equipment of other tags with the same device code. Failing that, the matching SCADA Equip path. Failing that, the reference row's Referenced Equipment.
- **Alarm Name:** the equipment description, as in v13.
- **Desc:** the base tags don't exist, so there's no tag comment to work from.
  - Tim's wording comes from a sibling alarm (same pattern, different unit number) where one exists, else a same-suffix alarm, else the tag name pattern.
  - Location or relay words specific to the sibling are dropped, e.g. "ROM Bin", "Primary Crusher Area", "(K187)".
- **Comment:** "<device code> <desc phrase>", plus "Healthy" for _Hty or "Alarm" for _A.
- **Other fields:** Cluster BR4_Cluster1; Custom 4 Modified Custom7; Area by equipment; Privil PRIV_ALARMACK; Project BS1_Tags; Found-in COUNTIF formulas. Item Name, Delay, Help, Var B, Custom 2/3/5 and Paging are left blank, as on comparable rows.
- The Alarms autoFilter, dimension and _FilterDatabase are now A1:M4861 / A1:AB4861. The _FilterDatabase name had been left at row 4811 in v13/v14; it is now fixed.

## Flagged for Tim
- **Review: `BCV131WN1VSD1_FwdFB_OR_BCV131WN1VSD1_RevFB_AND_NOT_BCV131WN1VSD`** (row 4828). A truncated expression. The row was created with placeholder Desc "VSD Forward Or Reverse Feedback (expression truncated - review)".
- **Typo-looking items (unchanged):**
  - BVC210_StpReq_C (BCV210?)
  - BPP1101FT03_HiH_A (Tim has BPP1101FT03_HiHi_A)
- **Probably the wrong instrument (unchanged):** these 10 BPL131 items name BPP1104/BPP1105 PT08/FT06 or BPP1102FT03, but those instruments don't exist. The shared header instruments are BPP1103PT08, BPP1103FT06 and BPP1101FT03, which is also what Tim's Referenced Equipment points to, and their alarms already exist (e.g. NOT_BPP1103PT08_HiHi_Hty, BPP1103FT06_Frz_A, BPP1101FT03_Frz_A). If renamed to those, these new alarms become unnecessary. The new alarms use that header equipment, so their Alarm Names read "Water Transfer Pump 1 …" / "…Pump 1 Common Discharge Header Flow". The items:
  - NOT_BPP1104PT08_HiHi/Frz_Hty, NOT_BPP1104FT06_HiHi_Hty, BPP1104FT06_Frz/LkFlt_A
  - BPP1105PT08_HiHi/Frz_A, BPP1105FT06_HiHi/Frz/LkFlt_A
  - BPP1102FT03_Frz_A
- **No equipment (Equipment left blank, Alarm Name "BCV210 Conveyor"):** BCV210_AutRun_C, BVC210_StpReq_C, NOT_BCV210_NCILOK_C, BCV210_AutRun. There's no BCV210 equipment in SCADA Equip.
- **One alarm, three drive equipments:** BCV131FN01_AutRun is referenced from BCV131A, B and C. The alarm uses BCV131A.FN01.
- **Descriptions guessed from the tag name only (no sibling):**
  - NOT_BCV131WN1RIS1_Flt, NOT_BCV131RIS01PLC01_SysOK_Hty, NOT_BCV130MA01_AvlFlt_Hty, NOT_BCV130SPY1FIT01_Dsc_Hty
  - BCV130_StpReq, BJC130_ADV_CrsStpReq_S, BJC130_ADV_Adjustment_S, the _SeqReq/_AutRun items

## New rows
| Row | Alarm Tag | Equipment | Alarm Name | Cat | Alarm Desc | Equipment from | Desc from |
|---|---|---|---|---|---|---|---|
| 4825 | NOT_BBD130SV13_ExcRun_Hty | BR4.INLOADING.BP3PRCR.SPRAYS.BVG130DUST.BBD130SV13 | BVG130 Grizzly Feeder Dust Suppression Spray Valve | IL_Critical | Dust Supression Excessive Run Time Interlock | equipment of other BBD130SV13* tags in SCADA Tags | same-suffix alarm NOT_BBN130SV14_ExcRun_Hty |
| 4826 | NOT_BCV131RIS01PLC01_SysOK_Hty | BR4.SRV.CTRLSYS.PLC.BCV131WN01PLC01 | BCV131 Active Winch PLC01 | IL_Critical | System OK Interlock | Referenced Equipment on the reference row(s) | tag name pattern |
| 4827 | NOT_BCV131WN1RIS1_Flt | BR4.INLOADING.BP3OLC.BCV131.WN01 | BCV131 Winch | IL_Critical | Fault Interlock | equipment of other BCV131WN1RIS1* tags in SCADA Tags | tag name pattern |
| 4828 | BCV131WN1VSD1_FwdFB_OR_BCV131WN1VSD1_RevFB_AND_NOT_BCV131WN1VSD | BR4.INLOADING.BP3OLC.BCV131.WN01.VSD1 | BCV131WN1 VSD | IL_LocalRun | VSD Forward Or Reverse Feedback (expression truncated - review) | equipment of other BCV131WN1VSD1* tags in SCADA Tags | expression item - placeholder text, needs review |
| 4829 | BPP1101FT03_HiH_A | BR4.UTILITIES.WATER.BS1.RWD1.BPP1101.FieldIO.FT03 | Production Plant & NPI Water Supply Pump 1 Common Discharge Header Flow | CAT_P3 | NPI And Process Water Supply Flow High High Healthy | equipment of other BPP1101FT03* tags in SCADA Tags | sibling alarm BPP1101FT03_HiHi_A |
| 4830 | BPP1102FT03_Frz_A | BR4.UTILITIES.WATER.BS1.RWD1.BPP1101.FieldIO.FT03 | Production Plant & NPI Water Supply Pump 1 Common Discharge Header Flow | CAT_P3 | Flow Transmitter Frozen | Referenced Equipment on the reference row(s) | sibling alarm BPP1101FT03_Frz_A |
| 4831 | NOT_BPP1104PT08_HiHi_Hty | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.PT08 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Pressure | IL_NonCritical | Transfer System Pressure High High Interlock | Referenced Equipment on the reference row(s) | sibling alarm NOT_BPP1103PT08_HiHi_Hty |
| 4832 | NOT_BPP1104PT08_Frz_Hty | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.PT08 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Pressure | IL_NonCritical | Transfer System Pressure Transmitter Frozen Interlock | Referenced Equipment on the reference row(s) | sibling alarm NOT_BPP1103PT08_Frz_Hty |
| 4833 | NOT_BPP1104FT06_HiHi_Hty | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.FT06 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Flow | IL_NonCritical | Transfer Flow High High Interlock | Referenced Equipment on the reference row(s) | sibling alarm NOT_BPP1103FT06_HiHi_Hty |
| 4834 | BPP1104FT06_Frz_A | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.FT06 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Flow | CAT_P3 | Transfer Flow Transmitter Frozen | Referenced Equipment on the reference row(s) | sibling alarm BPP1103FT06_Frz_A |
| 4835 | BPP1104FT06_LkFlt_A | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.FT06 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Flow | CAT_P3 | Pipeline Leak Detected | Referenced Equipment on the reference row(s) | sibling alarm BPP1103FT06_LkFlt_A |
| 4836 | BPP1105PT08_HiHi_A | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.PT08 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Pressure | CAT_P3 | System Pressure High High | Referenced Equipment on the reference row(s) | sibling alarm BPP1103PT08_HiHi_A |
| 4837 | BPP1105PT08_Frz_A | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.PT08 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Pressure | CAT_P3 | System Pressure Transmitter Frozen | Referenced Equipment on the reference row(s) | sibling alarm BPP1103PT08_Frz_A |
| 4838 | BPP1105FT06_HiHi_A | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.FT06 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Flow | CAT_P3 | Transfer Flow High High | Referenced Equipment on the reference row(s) | sibling alarm BPP1103FT06_HiHi_A |
| 4839 | BPP1105FT06_Frz_A | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.FT06 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Flow | CAT_P3 | Transfer Flow Transmitter Frozen | Referenced Equipment on the reference row(s) | sibling alarm BPP1103FT06_Frz_A |
| 4840 | BPP1105FT06_LkFlt_A | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.FT06 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Flow | CAT_P3 | Pipeline Leak Detected | Referenced Equipment on the reference row(s) | sibling alarm BPP1103FT06_LkFlt_A |
| 4841 | BCV130_StpReq | BR4.INLOADING.BP3PRCR.BCV130 | BCV130 Conveyor | IL_Critical | Stop Requested | equipment of other BCV130* tags in SCADA Tags | tag name pattern |
| 4842 | NOT_BCV130MA01_AvlFlt_Hty | BR4.INLOADING.BP3PRCR.BCV130.MA01 | BCV130 Conveyor Magnet | IL_NonCritical | Availability Fault Interlock | equipment of other BCV130MA01* tags in SCADA Tags | tag name pattern |
| 4843 | NOT_BDU130RV01THR01_Hi_Hty | BR4.INLOADING.BP3PRCR.BDU130.RV01 | BDU130 Dust Collector Rotary Valve | IL_Critical | PTC Thermistor Relay Interlock | Referenced Equipment on the reference row(s) | same-suffix alarm NOT_BDU130FN01THR01_Hi_Hty (location/relay words specific to BDU130FN01THR01 dropped) |
| 4844 | BCV130MA01FN03_SeqReq | BR4.INLOADING.BP3PRCR.BCV130.MA01.FN03 | BCV130 Conveyor Magnet Cooling Fan 1 | IL_SeqStart | Sequence Requested | SCADA Equip path matching BCV130MA01FN03 | tag name pattern |
| 4845 | BCV130MA01FN04_SeqReq | BR4.INLOADING.BP3PRCR.BCV130.MA01.FN04 | BCV130 Conveyor Magnet Cooling Fan 2 | IL_SeqStart | Sequence Requested | SCADA Equip path matching BCV130MA01FN04 | tag name pattern |
| 4846 | BJC130_ADV_CrsStpReq_S | BR4.INLOADING.BP3PRCR.BJC130 | BJC130 Jaw Crusher | IL_SeqRun | Crusher Stop Request | equipment of other BJC130* tags in SCADA Tags | tag name pattern |
| 4847 | BJC130_ADV_Adjustment_S | BR4.INLOADING.BP3PRCR.BJC130 | BJC130 Jaw Crusher | IL_SeqRun | Adjustment | equipment of other BJC130* tags in SCADA Tags | tag name pattern |
| 4848 | NOT_BS1OLC2_CshStp_Hty | BR4.SRV.CTRLSYS.PLC.BPL132 | Overland Conveying PLC 132 | IL_Critical | Crash Stop Interlock | Referenced Equipment on the reference row(s) | same-suffix alarm NOT_BS1PC3_CshStp_Hty |
| 4849 | BCV210_AutRun_C | (blank) | BCV210 Conveyor | IL_SeqRun | Auto Running | none found | tag name pattern |
| 4850 | BCV131FN01_AutRun | BR4.INLOADING.BP3OLC.BCV131.BCV131A.FN01 | BCV131 Overland Conveyor Drive A Reducer Cooling Fan | IL_SeqRun | Auto Running | Referenced Equipment on the reference row(s) | tag name pattern |
| 4851 | NOT_BBD131SM01LT01_LoLo_Hty | BR4.INLOADING.BP3OLC.BBD131.SM01.FieldIO.LT01 | BBD131SM01 Surge Bin Facility Sump | IL_NonCritical | Low Low Interlock | Referenced Equipment on the reference row(s) | sibling alarm NOT_BBD130SM01LT01_LoLo_Hty |
| 4852 | NOT_BBD131SM01LT01_Frz_Hty | BR4.INLOADING.BP3OLC.BBD131.SM01.FieldIO.LT01 | BBD131SM01 Surge Bin Facility Sump | IL_NonCritical | Sump Level Frozen Value Interlock | Referenced Equipment on the reference row(s) | sibling alarm NOT_BBD130SM01LT01_Frz_Hty (location/relay words specific to BBD130SM01LT01 dropped) |
| 4853 | NOT_BAF131CH02BCS01_Hty | BR4.INLOADING.BP3OLC.BAF131 | BAF131 Apron Feeder | IL_Critical | Dribble Chute 2 Blocked Chute Switch Interlock | Referenced Equipment on the reference row(s) | sibling alarm NOT_BAF130CH02BCS01_Hty (location/relay words specific to BAF130CH02BCS01 dropped) |
| 4854 | BVC210_StpReq_C | (blank) | BCV210 Conveyor | IL_Critical | Stop Requested | none found | tag name pattern |
| 4855 | NOT_BAF131LUY01_RunEmpFlt_Hty | BR4.INLOADING.BP3OLC.BAF131 | BAF131 Apron Feeder | IL_NonCritical | No Ore Detected Interlock | Referenced Equipment on the reference row(s) | sibling alarm NOT_BAF130LUY01_RunEmpFlt_Hty (location/relay words specific to BAF130LUY01 dropped) |
| 4856 | NOT_BCV210_NCILOK_C | (blank) | BCV210 Conveyor | IL_NonCritical | Non-Critical Interlocks OK Interlock | none found | tag name pattern |
| 4857 | BCV210_AutRun | (blank) | BCV210 Conveyor | IL_SeqFwdRun | Auto Running | none found | tag name pattern |
| 4858 | NOT_BAF131PP01STS1_RunFBFlt_Hty | BR4.INLOADING.BP3OLC.BAF131.HP01.PP01 | BAF131 Apron Feeder Hydraulic Pack Pump | IL_Critical | Hydraulic Power Unit 1 Pump 1 Running Feedback Fault (Spider) Interlock | equipment of other BAF131PP01STS1* tags in SCADA Tags | same-suffix alarm NOT_BAF130HP01PP01STS1_RunFBFlt_Hty |
| 4859 | NOT_BAF131PP01STS1_StpFBFlt_Hty | BR4.INLOADING.BP3OLC.BAF131.HP01.PP01 | BAF131 Apron Feeder Hydraulic Pack Pump | IL_Critical | Hydraulic Power Unit 1 Pump 1 Stop Feedback Fault (Spider) Interlock | equipment of other BAF131PP01STS1* tags in SCADA Tags | same-suffix alarm NOT_BAF130HP01PP01STS1_StpFBFlt_Hty |
| 4860 | NOT_BAF131HP01FS04_Hty | BR4.INLOADING.BP3OLC.BAF131.HP01 | BPL131 Apron Feeder Hydraulic Pack | IL_Critical | Hydraulic Power Pack Flow Switch Interlock | Referenced Equipment on the reference row(s) | sibling alarm NOT_BAF130HP01FS04_Hty |
| 4861 | NOT_BCV130SPY1FIT01_Dsc_Hty | BR4.INLOADING.BP3PRCR.SPRAYS.BCV130BULK.BCV130SPY1 | BCV130 Discharge Conveyor Loading Point Water Addition Module | IL_Critical | Flow Discrepancy Interlock | Referenced Equipment on the reference row(s) | tag name pattern |

## Checks
- verify SCADA Alarms (v14 → v15): nothing lost or unintended; 37 rows appended, all red.
- verify SCADA References: identical (the sheet XML is byte-identical to v14).
- strict_check: only the two existing info items (Used Pages and Runtime Params autoFilters are shorter than their data).
