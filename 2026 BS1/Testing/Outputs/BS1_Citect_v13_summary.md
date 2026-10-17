# BS1_Citect_v13 – summary

Tim: "for the NOT_ references they should exist in the Alarms tab as interlocks; please keep them in the references tab". Built from v11 with the v12 deletion list minus the restored rows, so restored rows sit in their original position. Same result as editing v12. calcChain stays removed; vbaProject.bin is byte-identical to Tim's file; full recalc on open.

## References restored: 13 (red), by I/O Dev: {'BPL131': 9, 'BPL132': 4}
| v13 row | Equipment | Referenced Item | Category | Order | I/O Dev |
|---|---|---|---|---|---|
| 155 | BR4.UTILITIES.WATER.BS1.RWT.BPP1103 | NOT_BPP1103CB01_Hty | IL_Critical | 1 | BPL131 |
| 156 | BR4.UTILITIES.WATER.BS1.RWT.BPP1103 | NOT_BPP1103TRP01_Hty | IL_Critical | 2 | BPL131 |
| 176 | BR4.UTILITIES.WATER.BS1.RWT.BPP1103 | NOT_BPP1103FT06_HiHi_Hty | IL_NonCritical | 3 | BPL131 |
| 177 | BR4.UTILITIES.WATER.BS1.RWT.BPP1103 | NOT_BPP1103FT06_Frz_Hty | IL_NonCritical | 4 | BPL131 |
| 178 | BR4.UTILITIES.WATER.BS1.RWT.BPP1103 | NOT_BPP1103FT06_LkFlt_Hty | IL_NonCritical | 5 | BPL131 |
| 179 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | NOT_BPP1104CB01_Hty | IL_Critical | 1 | BPL131 |
| 180 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | NOT_BPP1104TRP01_Hty | IL_Critical | 2 | BPL131 |
| 256 | BR4.UTILITIES.WATER.BS1.BTY1502.FV01 | NOT_BTY1502FV01CB01_Hty | IL_Critical | 2 | BPL131 |
| 279 | BR4.UTILITIES.WATER.BS1.STD1.BSTD1107.FV02 | NOT_BSTD1107FV02_LmtFlt_Hty | IL_Critical | 6 | BPL131 |
| 1591 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BCV210WM01_Flt_Hty | IL_NonCritical | 9 | BPL132 |
| 1592 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BCV210WM01_HiHi_Hty | IL_NonCritical | 10 | BPL132 |
| 1593 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BCV210TRK01_HiHi_Hty | IL_NonCritical | 11 | BPL132 |
| 1594 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BCV210PUY01_LoLo_Hty | IL_NonCritical | 12 | BPL132 |

The restored rows keep their original Equipment, Referenced Equipment, Category and Order. All their cells are red.

## Still deleted: 68
- NOT_ item: 26
- not a NOT_ item and not in SCADA Tags or Alarms: 24
- malformed copy: 18

| v11 row | Equipment | Referenced Item | Category | I/O Dev | Why |
|---|---|---|---|---|---|
| 5 | BR4.INLOADING.BP3PRCR.SPRAYS.BVG130DUST.BBD130SV13 | NOT_BBD130SV13_ExcRun_Hty | IL_Critical | BPL130 | NOT_ item; base tag BBD130SV13_ExcRun_Hty not in SCADA Tags |
| 36 | BR4.INLOADING.BP3OLC.BCV131.WN01.LP1 | NOT_BCV131RIS01PLC01_SysOK_Hty | IL_Critical | BCV131WN01PLC01 | NOT_ item; base tag BCV131RIS01PLC01_SysOK_Hty not in SCADA Tags |
| 50 | BR4.INLOADING.BP3OLC.BCV131.WN01.FN1 | NOT_BCV131RIS01PLC01_SysOK_Hty | IL_Critical | BCV131WN01PLC01 | NOT_ item; base tag BCV131RIS01PLC01_SysOK_Hty not in SCADA Tags |
| 67 | BR4.INLOADING.BP3OLC.BCV131.WN01.BR1 | NOT_BCV131WN1RIS1_Flt | IL_Critical | BCV131WN01PLC01 | NOT_ item; base tag BCV131WN1RIS1_Flt not in SCADA Tags |
| 73 | BR4.INLOADING.BP3OLC.BCV131.WN01.BR1 | NOT_BCV131RIS01PLC01_SysOK_Hty | IL_Critical | BCV131WN01PLC01 | NOT_ item; base tag BCV131RIS01PLC01_SysOK_Hty not in SCADA Tags |
| 80 | BR4.INLOADING.BP3OLC.BCV131.WN01 | BCV131WN1VSD1_FwdFB_OR_BCV131WN1VSD1_RevFB_AND_NOT_BCV131WN1 | IL_LocalRun | BCV131WN01PLC01 | not a NOT_ item and not in SCADA Tags or Alarms |
| 86 | BR4.INLOADING.BP3OLC.BCV131.WN01 | BCV131WN1VSD1_FwdFB_OR_BCV131WN1VSD1_RevFB_AND_NOT_BCV131WN1 | IL_SeqRun | BCV131WN01PLC01 | not a NOT_ item and not in SCADA Tags or Alarms |
| 120 | BR4.INLOADING.BP3OLC.BCV131.WN01 | NOT_BCV131RIS01PLC01_SysOK_Hty | IL_Critical | BCV131WN01PLC01 | NOT_ item; base tag BCV131RIS01PLC01_SysOK_Hty not in SCADA Tags |
| 139 | BR4.UTILITIES.WATER.BS1.RWD1.BPP1101 | BPP1101FT03_HiH_A | IL_NonCritical | BPL131 | not a NOT_ item and not in SCADA Tags or Alarms |
| 162 | BR4.UTILITIES.WATER.BS1.RWD1.BPP1102 | BPP1102FT03_Frz_A | IL_NonCritical | BPL131 | not a NOT_ item and not in SCADA Tags or Alarms |
| 208 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | NOT_BPP1104PT08_HiHi_Hty | IL_NonCritical | BPL131 | NOT_ item; base tag BPP1104PT08_HiHi_Hty not in SCADA Tags |
| 209 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | NOT_BPP1104PT08_Frz_Hty | IL_NonCritical | BPL131 | NOT_ item; base tag BPP1104PT08_Frz_Hty not in SCADA Tags |
| 210 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | NOT_BPP1104FT06_HiHi_Hty | IL_NonCritical | BPL131 | NOT_ item; base tag BPP1104FT06_HiHi_Hty not in SCADA Tags |
| 211 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | BPP1104FT06_Frz_A | IL_NonCritical | BPL131 | not a NOT_ item and not in SCADA Tags or Alarms |
| 212 | BR4.UTILITIES.WATER.BS1.RWT.BPP1104 | BPP1104FT06_LkFlt_A | IL_NonCritical | BPL131 | not a NOT_ item and not in SCADA Tags or Alarms |
| 232 | BR4.UTILITIES.WATER.BS1.RWT.BPP1105 | BPP1105PT08_HiHi_A | IL_NonCritical | BPL131 | not a NOT_ item and not in SCADA Tags or Alarms |
| 233 | BR4.UTILITIES.WATER.BS1.RWT.BPP1105 | BPP1105PT08_Frz_A | IL_NonCritical | BPL131 | not a NOT_ item and not in SCADA Tags or Alarms |
| 234 | BR4.UTILITIES.WATER.BS1.RWT.BPP1105 | BPP1105FT06_HiHi_A | IL_NonCritical | BPL131 | not a NOT_ item and not in SCADA Tags or Alarms |
| 235 | BR4.UTILITIES.WATER.BS1.RWT.BPP1105 | BPP1105FT06_Frz_A | IL_NonCritical | BPL131 | not a NOT_ item and not in SCADA Tags or Alarms |
| 236 | BR4.UTILITIES.WATER.BS1.RWT.BPP1105 | BPP1105FT06_LkFlt_A | IL_NonCritical | BPL131 | not a NOT_ item and not in SCADA Tags or Alarms |
| 335 | BR4.INLOADING.BP3PRCR.BAF130 | BCV130_StpReq | IL_Critical | BPL130 | not a NOT_ item and not in SCADA Tags or Alarms |
| 348 | BR4.INLOADING.BP3PRCR.BAF130 | NOT_BCV130MA01_AvlFlt_Hty | IL_NonCritical | BPL130 | NOT_ item; base tag BCV130MA01_AvlFlt_Hty not in SCADA Tags |
| 561 | BR4.INLOADING.BP3PRCR.BDU130.RV01 | NOT_BDU130RV01THR01_Hi_Hty | IL_Critical | BPL130 | NOT_ item; base tag BDU130RV01THR01_Hi_Hty not in SCADA Tags |
| 617 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130RTD01_HiHi_Hty,Value:BCV130RTD01_HiHi_SP,ValueIsSP | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130RTD01_HiHi_Hty already exists for the same Equipment+Category |
| 618 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130RTD02_HiHi_Hty,Value:BCV130RTD02_HiHi_SP,ValueIsSP | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130RTD02_HiHi_Hty already exists for the same Equipment+Category |
| 619 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130RTD03_HiHi_Hty,Value:BCV130RTD03_HiHi_SP,ValueIsSP | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130RTD03_HiHi_Hty already exists for the same Equipment+Category |
| 620 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130RTD04_HiHi_Hty,Value:BCV130RTD04_HiHi_SP,ValueIsSP | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130RTD04_HiHi_Hty already exists for the same Equipment+Category |
| 621 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130RTD05_HiHi_Hty,Value:BCV130RTD05_HiHi_SP,ValueIsSP | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130RTD05_HiHi_Hty already exists for the same Equipment+Category |
| 622 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130RTD06_HiHi_Hty,Value:BCV130RTD06_HiHi_SP,ValueIsSP | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130RTD06_HiHi_Hty already exists for the same Equipment+Category |
| 623 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130RTD07_HiHi_Hty,Value:BCV130RTD07_HiHi_SP,ValueIsSP | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130RTD07_HiHi_Hty already exists for the same Equipment+Category |
| 624 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130RTD08_HiHi_Hty,Value:BCV130RTD08_HiHi_SP,ValueIsSP | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130RTD08_HiHi_Hty already exists for the same Equipment+Category |
| 625 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130RTD09_HiHi_Hty,Value:BCV130RTD09_HiHi_SP,ValueIsSP | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130RTD09_HiHi_Hty already exists for the same Equipment+Category |
| 626 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130GB01RTD01_HiHi_Hty,Value:BCV130RTD01_HiHi_SP,Value | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130GB01RTD01_HiHi_Hty already exists for the same Equipment+Category |
| 627 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130GB01RTD02_HiHi_Hty,Value:BCV130RTD01_HiHi_SP,Value | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130GB01RTD02_HiHi_Hty already exists for the same Equipment+Category |
| 640 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130_EqpMonOC_Hty,Input:BCV130_EqpMonOC | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130_EqpMonOC_Hty already exists for the same Equipment+Category |
| 641 | BR4.INLOADING.BP3PRCR.BCV130 | NOT_BCV130_EqpMonAbnSpk_Hty,Input:BCV130_EqpMonAbnSpk | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BCV130_EqpMonAbnSpk_Hty already exists for the same Equipment+Category |
| 810 | BR4.INLOADING.BP3PRCR.BJC130 | NOT_BJC130TT01_HiHi_Hty,Value:BJC130TT01_HiHiSP,ValueIsSP:1, | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BJC130TT01_HiHi_Hty already exists for the same Equipment+Category |
| 811 | BR4.INLOADING.BP3PRCR.BJC130 | NOT_BJC130TT02_HiHi_Hty,Value:BJC130TT02_HiHiSP,ValueIsSP:1, | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BJC130TT02_HiHi_Hty already exists for the same Equipment+Category |
| 812 | BR4.INLOADING.BP3PRCR.BJC130 | NOT_BJC130TT03_HiHi_Hty,Value:BJC130TT03_HiHiSP,ValueIsSP:1, | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BJC130TT03_HiHi_Hty already exists for the same Equipment+Category |
| 813 | BR4.INLOADING.BP3PRCR.BJC130 | NOT_BJC130TT04_HiHi_Hty,Value:BJC130TT04_HiHiSP,ValueIsSP:1, | IL_Critical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BJC130TT04_HiHi_Hty already exists for the same Equipment+Category |
| 851 | BR4.INLOADING.BP3PRCR.BBD130.SM01.PP01 | NOT_BBD130SM01LT01_LoLo_Hty,Value:BBD130SM01LT01_LoLo_SP,Val | IL_NonCritical | BPL130 | malformed copy (tile parameters pasted in); the clean row NOT_BBD130SM01LT01_LoLo_Hty already exists for the same Equipment+Category |
| 1011 | BR4.INLOADING.BP3PRCR.BCV130.MA01.FN03 | BCV130MA01FN03_SeqReq | IL_SeqStart | BPL130 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1013 | BR4.INLOADING.BP3PRCR.BCV130.MA01.FN03 | BCV130MA01FN03_SeqReq | IL_SeqRun | BPL130 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1016 | BR4.INLOADING.BP3PRCR.BCV130.MA01.FN04 | BCV130MA01FN04_SeqReq | IL_SeqStart | BPL130 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1018 | BR4.INLOADING.BP3PRCR.BCV130.MA01.FN04 | BCV130MA01FN04_SeqReq | IL_SeqRun | BPL130 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1028 | BR4.INLOADING.BP3PRCR.BJC130 | BJC130_ADV_CrsStpReq_S | IL_SeqRun | BPL130 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1029 | BR4.INLOADING.BP3PRCR.BJC130 | BJC130_ADV_Adjustment_S | IL_SeqRun | BPL130 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1039 | BR4.INLOADING.BP3OLC.BCV131 | NOT_BS1OLC2_CshStp_Hty | IL_Critical | BPL132 | NOT_ item; base tag BS1OLC2_CshStp_Hty not in SCADA Tags |
| 1306 | BR4.INLOADING.BP3OLC.BCV131 | BCV210_AutRun_C | IL_SeqRun | BPL132 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1344 | BR4.INLOADING.BP3OLC.BCV131.BCV131A.PP02 | BCV131FN01_AutRun | IL_SeqRun | BPL132 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1411 | BR4.INLOADING.BP3OLC.BCV131.BCV131B.PP02 | BCV131FN01_AutRun | IL_SeqRun | BPL132 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1478 | BR4.INLOADING.BP3OLC.BCV131.BCV131C.PP02 | BCV131FN01_AutRun | IL_SeqRun | BPL132 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1616 | BR4.INLOADING.BP3OLC.BBD131.SM01.PP01 | NOT_BBD131SM01LT01_LoLo_Hty | IL_NonCritical | BPL132 | NOT_ item; base tag BBD131SM01LT01_LoLo_Hty not in SCADA Tags |
| 1617 | BR4.INLOADING.BP3OLC.BBD131.SM01.PP01 | NOT_BBD131SM01LT01_Frz_Hty | IL_NonCritical | BPL132 | NOT_ item; base tag BBD131SM01LT01_Frz_Hty not in SCADA Tags |
| 1620 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BS1OLC2_CshStp_Hty | IL_Critical | BPL132 | NOT_ item; base tag BS1OLC2_CshStp_Hty not in SCADA Tags |
| 1629 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BAF131CH02BCS01_Hty | IL_Critical | BPL132 | NOT_ item; base tag BAF131CH02BCS01_Hty not in SCADA Tags |
| 1641 | BR4.INLOADING.BP3OLC.BAF131 | BVC210_StpReq_C | IL_Critical | BPL132 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1647 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BAF131LUY01_RunEmpFlt_Hty | IL_NonCritical | BPL132 | NOT_ item; base tag BAF131LUY01_RunEmpFlt_Hty not in SCADA Tags |
| 1648 | BR4.INLOADING.BP3OLC.BAF131 | NOT_BCV210_NCILOK_C | IL_NonCritical | BPL132 | NOT_ item; base tag BCV210_NCILOK_C not in SCADA Tags |
| 1657 | BR4.INLOADING.BP3OLC.BAF131 | BCV210_AutRun | IL_SeqFwdRun | BPL132 | not a NOT_ item and not in SCADA Tags or Alarms |
| 1701 | BR4.INLOADING.BP3OLC.BAF131.HP01.PP01 | NOT_BAF131PP01STS1_RunFBFlt_Hty | IL_Critical | BPL132 | NOT_ item; base tag BAF131PP01STS1_RunFBFlt_Hty not in SCADA Tags |
| 1702 | BR4.INLOADING.BP3OLC.BAF131.HP01.PP01 | NOT_BAF131PP01STS1_StpFBFlt_Hty | IL_Critical | BPL132 | NOT_ item; base tag BAF131PP01STS1_StpFBFlt_Hty not in SCADA Tags |
| 1705 | BR4.INLOADING.BP3OLC.BAF131.HP01.PP01 | NOT_BAF131HP01FS04_Hty | IL_Critical | BPL132 | NOT_ item; base tag BAF131HP01FS04_Hty not in SCADA Tags |
| 1720 | BR4.INLOADING.BP3OLC.BAF131.HP01.PP04 | NOT_BAF131HP01FS04_Hty | IL_Critical | BPL132 | NOT_ item; base tag BAF131HP01FS04_Hty not in SCADA Tags |
| 1722 | BR4.INLOADING.BP3OLC.BAF131.LU01.PP02 | NOT_BS1OLC2_CshStp_Hty | IL_Critical | BPL132 | NOT_ item; base tag BS1OLC2_CshStp_Hty not in SCADA Tags |
| 1736 | BR4.INLOADING.BP3PRCR.SPRAYS.BCV130BULK.BCV130SPY1 | NOT_BCV130SPY1FIT01_Dsc_Hty | IL_Critical | BPL130 | NOT_ item; base tag BCV130SPY1FIT01_Dsc_Hty not in SCADA Tags |
| 1744 | BR4.INLOADING.BP3PRCR.SPRAYS.BCV130BULK.BCV130SPY2 | NOT_BCV130SPY1FIT01_Dsc_Hty | IL_Critical | BPL130 | NOT_ item; base tag BCV130SPY1FIT01_Dsc_Hty not in SCADA Tags |
| 1752 | BR4.INLOADING.BP3OLC.SPRAYS.BCV131BULK.BCV131SPY1 | NOT_BCV130SPY1FIT01_Dsc_Hty | IL_Critical | BPL132 | NOT_ item; base tag BCV130SPY1FIT01_Dsc_Hty not in SCADA Tags |

## Order: 329 cells renumbered vs v11 (red)
Recomputed on the final deletion set. Only gaps left by deleted rows are closed; earlier gaps and duplicates are kept.

Sheet: 1689 data rows; dimension, autoFilter and _FilterDatabase are A1:T1690. The row 2 "Found in" formulas are unchanged.

## SCADA Alarms: 13 NOT_ interlock rows added (rows 4812–4824, red)
These are all the NOT_ References items with no NOT_ alarm. After this, every NOT_ Referenced Item has a NOT_ alarm.
Built with the v6 interlock rules:
- Alarm Tag NOT_X; Var A "NOT X"; Custom 1 X.
- Equipment is X's equipment in SCADA Tags.
- Alarm Name is the equipment description.
- Comment is X's tag comment.
- Alarm Desc is the comment minus the name overlap, with Healthy turned into Interlock.
  - Where sibling alarms with the same pattern exist (e.g. NOT_BPP1101/1102/1105–1107CB01/TRP01_Hty), Tim's wording is reused.
  - Interlock is appended where the comment has no "Healthy".
- Cat comes from the reference Category.
- Cluster BR4_Cluster1; Custom 4 Modified Custom7; Custom 6 C_HIPRI; Custom 8 Class_Process; Area by equipment; Privil PRIV_ALARMACK; Project BS1_Tags; Found-in COUNTIF formulas.
- The Alarms autoFilter is extended to A1:M4824.
- Note: Tim has an active filter on Alarm Tag (NOT_BAF130PWS01/02_Hty). The new rows are visible until the filter is reapplied.

| Row | Alarm Tag | Equipment | Alarm Name | Cat | Alarm Desc | Desc source |
|---|---|---|---|---|---|---|
| 4812 | NOT_BPP1103CB01_Hty | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.Sub.CB01 | Water Transfer Pump 1 Main Circuit Breaker | IL_Critical | Circuit Breaker (Q103) Open Interlock | same as sibling alarms |
| 4813 | NOT_BPP1103TRP01_Hty | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.Sub.CB01 | Water Transfer Pump 1 Main Circuit Breaker | IL_Critical | Tripped Interlock | same as sibling alarms |
| 4814 | NOT_BPP1103FT06_HiHi_Hty | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.FT06 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Flow | IL_NonCritical | Transfer Flow High High Interlock | v6 rule |
| 4815 | NOT_BPP1103FT06_Frz_Hty | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.FT06 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Flow | IL_NonCritical | Transfer Flow Transmitter Frozen Interlock | v6 rule |
| 4816 | NOT_BPP1103FT06_LkFlt_Hty | BR4.UTILITIES.WATER.BS1.RWT.BPP1103.FieldIO.FT06 | Water Transfer Pump 1 Water Transfer Pump Discharge Header Flow | IL_NonCritical | Water Transfer Pipeline Leak Detected Interlock | v6 rule |
| 4817 | NOT_BPP1104CB01_Hty | BR4.UTILITIES.WATER.BS1.RWT.BPP1104.Sub.CB01 | Water Transfer Pump 2 Main Circuit Breaker | IL_Critical | Circuit Breaker (Q103) Open Interlock | same as sibling alarms |
| 4818 | NOT_BPP1104TRP01_Hty | BR4.UTILITIES.WATER.BS1.RWT.BPP1104.Sub.CB01 | Water Transfer Pump 2 Main Circuit Breaker | IL_Critical | Tripped Interlock | same as sibling alarms |
| 4819 | NOT_BTY1502FV01CB01_Hty | BR4.UTILITIES.WATER.BS1.BTY1502.FV01.FieldIO.CB01 | BTY1502 West Turkeys Nest Process Water Recirculation Flow Valve 240VAC Circuit Breaker | IL_Critical | West Turkeys Nest 240VAC Flow Valve Power Circuit Breaker Open Interlock | v6 rule |
| 4820 | NOT_BSTD1107FV02_LmtFlt_Hty | BR4.UTILITIES.WATER.BS1.STD1.BSTD1107.FV02 | BSTD1107 HME West Standpipe Flow Valve | IL_Critical | West Turkeys Nest HME Standpipe Valve Dual Limit Fault Interlock | v6 rule |
| 4821 | NOT_BCV210WM01_Flt_Hty | BR4.INLOADING.BP2OLC.BCV210.WM01 | BCV210WM01 Weightometer | IL_NonCritical | Weightometer Fault Interlock | v6 rule |
| 4822 | NOT_BCV210WM01_HiHi_Hty | BR4.INLOADING.BP2OLC.BCV210.WM01 | BCV210WM01 Weightometer | IL_NonCritical | Weightometer High High Interlock | v6 rule |
| 4823 | NOT_BCV210TRK01_HiHi_Hty | BR4.INLOADING.BP2OLC.BCV210.WM01 | BCV210WM01 Weightometer | IL_NonCritical | Tons On Belt High-High Interlock | v6 rule |
| 4824 | NOT_BCV210PUY01_LoLo_Hty | BR4.INLOADING.BP2OLC.BCV210.WM01 | BCV210WM01 Weightometer | IL_NonCritical | Belt Edge Clearance Low-Low Interlock | v6 rule + Interlock |

## Checks
- References content check: v13 = v11 minus the remaining deletions, with the new Orders. 1690 rows, 0 mismatches. Restored rows and changed Orders are red.
- verify SCADA Alarms (v11 → v13): nothing lost or unintended; 13 rows appended.
- strict_check: only the two existing info items.
