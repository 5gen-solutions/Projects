# BS1_Citect_v14 – summary

Tim: "please include those references we will fix later". Built from v11 with only the 18 malformed copies deleted. Every other v13 change is kept, including the 13 NOT_ interlock alarms (SCADA Alarms is identical to v13). calcChain stays removed; fullCalcOnLoad is on; vbaProject.bin is byte-identical to Tim's file.

## SCADA References
- Rows restored vs v12: 63 (13 from v13 + 50 new). All their cells are red, and they keep their original position, Equipment, Referenced Equipment, Category, Order and other fields.
- The 50 new ones: 26 NOT_ items whose base tag isn't in SCADA Tags, and 24 items not in SCADA Tags or Alarms. No alarms were created for them; Tim will fix them later.
- By I/O Dev (new 50): {'BPL130': 12, 'BCV131WN01PLC01': 7, 'BPL131': 12, 'BPL132': 19}
- Still deleted: the 18 malformed copies (tile parameters pasted into the Referenced Item). Each has a clean row with the same Equipment, Category and Order.
- Data rows: 1739. Dimension, autoFilter and _FilterDatabase are A1:T1740. The row 2 "Found in" formulas are unchanged.
- Order: 0 cells changed vs v11. The 18 deleted rows duplicate surviving Order values, so deleting them leaves no gaps. The 329 Order changes made in v13 are back to Tim's original values.

| v14 row | Equipment | Referenced Item | Category | Order | I/O Dev |
|---|---|---|---|---|---|
| 5 | BR4.INLOADING.BP3PRCR.SPRAYS.BVG130DUST.BBD130SV13 | NOT_BBD130SV13_ExcRun_Hty | IL_Critical | 2 | BPL130 |
| 36 | BR4.INLOADING.BP3OLC.BCV131.WN01.LP1 | NOT_BCV131RIS01PLC01_SysOK_Hty | IL_Critical | 1 | BCV131WN01PLC01 |
| 50 | BR4.INLOADING.BP3OLC.BCV131.WN01.FN1 | NOT_BCV131RIS01PLC01_SysOK_Hty | IL_Critical | 1 | BCV131WN01PLC01 |
| 67 | BR4.INLOADING.BP3OLC.BCV131.WN01.BR1 | NOT_BCV131WN1RIS1_Flt | IL_Critical | 7 | BCV131WN01PLC01 |
| 73 | BR4.INLOADING.BP3OLC.BCV131.WN01.BR1 | NOT_BCV131RIS01PLC01_SysOK_Hty | IL_Critical | 1 | BCV131WN01PLC01 |
| 80 | BR4.INLOADING.BP3OLC.BCV131.WN01 | BCV131WN1VSD1_FwdFB_OR_BCV131WN1VSD1_RevFB_AND_NOT_BCV131WN1VSD | IL_LocalRun | 3 | BCV131WN01PLC01 |
| 86 | BR4.INLOADING.BP3OLC.BCV131.WN01 | BCV131WN1VSD1_FwdFB_OR_BCV131WN1VSD1_RevFB_AND_NOT_BCV131WN1VSD | IL_SeqRun | 4 | BCV131WN01PLC01 |
| 120 | BR4.INLOADING.BP3OLC.BCV131.WN01 | NOT_BCV131RIS01PLC01_SysOK_Hty | IL_Critical | 1 | BCV131WN01PLC01 |
| 139 | BR4.UTILITIES.WATER.BS1.RWD1.BPP1101 | BPP1101FT03_HiH_A | IL_NonCritical | 3 | BPL131 |
| 162 | BR4.UTILITIES.WATER.BS1.RWD1.BPP1102 | BPP1102FT03_Frz_A | IL_NonCritical | 4 | BPL131 |
| 208 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | NOT_BPP1104PT08_HiHi_Hty | IL_NonCritical | 1 | BPL131 |
| 209 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | NOT_BPP1104PT08_Frz_Hty | IL_NonCritical | 2 | BPL131 |
| 210 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | NOT_BPP1104FT06_HiHi_Hty | IL_NonCritical | 3 | BPL131 |
| 211 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | BPP1104FT06_Frz_A | IL_NonCritical | 4 | BPL131 |
| 212 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | BPP1104FT06_LkFlt_A | IL_NonCritical | 5 | BPL131 |
| 232 | BR4.UTILITIES.WATER.BS1.RWT.BPP1105 | BPP1105PT08_HiHi_A | IL_NonCritical | 1 | BPL131 |
| 233 | BR4.UTILITIES.WATER.BS1.RWT.BPP1105 | BPP1105PT08_Frz_A | IL_NonCritical | 2 | BPL131 |
| 234 | BR4.UTILITIES.WATER.BS1.RWT.BPP1105 | BPP1105FT06_HiHi_A | IL_NonCritical | 3 | BPL131 |
| 235 | BR4.UTILITIES.WATER.BS1.RWT.BPP1105 | BPP1105FT06_Frz_A | IL_NonCritical | 4 | BPL131 |
| 236 | BR4.UTILITIES.WATER.BS1.RWT.BPP1105 | BPP1105FT06_LkFlt_A | IL_NonCritical | 5 | BPL131 |
| 335 | BR4.INLOADING.BP3PRCR.BAF130 | BCV130_StpReq | IL_Critical | 34 | BPL130 |
| 348 | BR4.INLOADING.BP3PRCR.BAF130 | NOT_BCV130MA01_AvlFlt_Hty | IL_NonCritical | 13 | BPL130 |
| 561 | BR4.INLOADING.BP3PRCR.BDU130.RV01 | NOT_BDU130RV01THR01_Hi_Hty | IL_Critical | 12 | BPL130 |
| 993 | BR4.INLOADING.BP3PRCR.BCV130.MA01.FN03 | BCV130MA01FN03_SeqReq | IL_SeqStart | 1 | BPL130 |
| 995 | BR4.INLOADING.BP3PRCR.BCV130.MA01.FN03 | BCV130MA01FN03_SeqReq | IL_SeqRun | 1 | BPL130 |
| 998 | BR4.INLOADING.BP3PRCR.BCV130.MA01.FN04 | BCV130MA01FN04_SeqReq | IL_SeqStart | 1 | BPL130 |
| 1000 | BR4.INLOADING.BP3PRCR.BCV130.MA01.FN04 | BCV130MA01FN04_SeqReq | IL_SeqRun | 1 | BPL130 |
| 1010 | BR4.INLOADING.BP3PRCR.BJC130 | BJC130_ADV_CrsStpReq_S | IL_SeqRun | 1 | BPL130 |
| 1011 | BR4.INLOADING.BP3PRCR.BJC130 | BJC130_ADV_Adjustment_S | IL_SeqRun | 2 | BPL130 |
| 1021 | BR4.INLOADING.BP3OLC.BCV131 | NOT_BS1OLC2_CshStp_Hty | IL_Critical | 1 | BPL132 |
| 1288 | BR4.INLOADING.BP3OLC.BCV131 | BCV210_AutRun_C | IL_SeqRun | 1 | BPL132 |
| 1326 | BR4.INLOADING.BP3OLC.BCV131.BCV131A.PP02 | BCV131FN01_AutRun | IL_SeqRun | 2 | BPL132 |
| 1393 | BR4.INLOADING.BP3OLC.BCV131.BCV131B.PP02 | BCV131FN01_AutRun | IL_SeqRun | 2 | BPL132 |
| 1460 | BR4.INLOADING.BP3OLC.BCV131.BCV131C.PP02 | BCV131FN01_AutRun | IL_SeqRun | 2 | BPL132 |
| 1598 | BR4.INLOADING.BP3OLC.BBD131.SM01.PP01 | NOT_BBD131SM01LT01_LoLo_Hty | IL_NonCritical | 1 | BPL132 |
| 1599 | BR4.INLOADING.BP3OLC.BBD131.SM01.PP01 | NOT_BBD131SM01LT01_Frz_Hty | IL_NonCritical | 2 | BPL132 |
| 1602 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BS1OLC2_CshStp_Hty | IL_Critical | 1 | BPL132 |
| 1611 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BAF131CH02BCS01_Hty | IL_Critical | 10 | BPL132 |
| 1623 | BR4.INLOADING.BP3OLC.BAF131 | BVC210_StpReq_C | IL_Critical | 23 | BPL132 |
| 1629 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BAF131LUY01_RunEmpFlt_Hty | IL_NonCritical | 6 | BPL132 |
| 1630 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BCV210_NCILOK_C | IL_NonCritical | 7 | BPL132 |
| 1639 | BR4.INLOADING.BP3OLC.BAF131 | BCV210_AutRun | IL_SeqFwdRun | 2 | BPL132 |
| 1683 | BR4.INLOADING.BP3OLC.BAF131.HP01.PP01 | NOT_BAF131PP01STS1_RunFBFlt_Hty | IL_Critical | 17 | BPL132 |
| 1684 | BR4.INLOADING.BP3OLC.BAF131.HP01.PP01 | NOT_BAF131PP01STS1_StpFBFlt_Hty | IL_Critical | 18 | BPL132 |
| 1687 | BR4.INLOADING.BP3OLC.BAF131.HP01.PP01 | NOT_BAF131HP01FS04_Hty | IL_Critical | 21 | BPL132 |
| 1702 | BR4.INLOADING.BP3OLC.BAF131.HP01.PP04 | NOT_BAF131HP01FS04_Hty | IL_Critical | 12 | BPL132 |
| 1704 | BR4.INLOADING.BP3OLC.BAF131.LU01.PP02 | NOT_BS1OLC2_CshStp_Hty | IL_Critical | 1 | BPL132 |
| 1718 | BR4.INLOADING.BP3PRCR.SPRAYS.BCV130BULK.BCV130SPY1 | NOT_BCV130SPY1FIT01_Dsc_Hty | IL_Critical | 2 | BPL130 |
| 1726 | BR4.INLOADING.BP3PRCR.SPRAYS.BCV130BULK.BCV130SPY2 | NOT_BCV130SPY1FIT01_Dsc_Hty | IL_Critical | 2 | BPL130 |
| 1734 | BR4.INLOADING.BP3OLC.SPRAYS.BCV131BULK.BCV131SPY1 | NOT_BCV130SPY1FIT01_Dsc_Hty | IL_Critical | 2 | BPL132 |

## Checks
- References content check: v14 = v11 minus the 18 malformed rows. 1740 rows, 0 mismatches; all restored cells are red.
- verify SCADA Alarms (v11 → v14): nothing lost or unintended; 13 rows appended (same as v13).
- strict_check: only the two existing info items (Used Pages and Runtime Params autoFilters are shorter than their data).
