# BS1_Citect_v10 – summary

Base: BS1_Citect_v9.xlsm. Only SCADA References column E (Referenced Item) changed, on 4 cells, in red font. Every other cell, including the confirmed fills from v9 and the BPL132 tags placed under the PLC, is unchanged. calcChain stays removed; vbaProject.bin is byte-identical to Tim's file; full recalc on open; the external link to Variable_ReMapper is untouched.

## CV701 → BCV130 (4 renamed)
| Row | Old | New | Equipment | Referenced Equipment (unchanged) |
|---|---|---|---|---|
| 348 | NOT_CV701TM1_AvlFlt_Hty | NOT_BCV130TM1_AvlFlt_Hty | BR4.INLOADING.BP3PRCR.BAF130 (Tim's row) | BR4.INLOADING.BP3PRCR.BCV130.MA01 |
| 1736 | NOT_CV701SPY1FIT01_Dsc_Hty | NOT_BCV130SPY1FIT01_Dsc_Hty | …SPRAYS.BCV130BULK.BCV130SPY1 | …BCV130BULK.BCV130SPY1 |
| 1744 | NOT_CV701SPY1FIT01_Dsc_Hty | NOT_BCV130SPY1FIT01_Dsc_Hty | …SPRAYS.BCV130BULK.BCV130SPY2 | …BCV130BULK.BCV130SPY1 |
| 1752 | NOT_CV701SPY1FIT01_Dsc_Hty | NOT_BCV130SPY1FIT01_Dsc_Hty | …SPRAYS.BCV131BULK.BCV131SPY1 (BPL132) | …BCV130BULK.BCV130SPY1 |

No other CV701 item exists in SCADA References. Category and Order were already filled, so they are unchanged.

## Resolution against SCADA Alarms / Tags: 0 of 4 resolve (exact or case-insensitive)
Neither BCV130 name exists, with or without NOT_ and with or without _Hty. Referenced Equipment is left as it was, not guessed.
- **NOT_BCV130TM1_AvlFlt_Hty**: no TM1 availability-fault tag exists. Nearest real tags are on the same device:
  - NOT_BCV130TM1_AutRdy (Alarms) and BCV130TM1_AutRdy (Tags), both with equipment BR4.INLOADING.BP3PRCR.BCV130.
  - These are the only TM1 tags in the workbook. "AutRdy" is a different signal from "AvlFlt".
- **NOT_BCV130SPY1FIT01_Dsc_Hty**: no FIT01 or flow-discrepancy (_Dsc) tag exists for BCV130 or anywhere else in the workbook.
  - SPY1's flow transmitter is FT04: BCV130FT04_PV, equipment …BCV130BULK.BCV130SPY1.FT04. It has only PV and totaliser tags, no alarms.
  - The nearest SPY1 alarm is NOT_BCV130SPY1STS1_ExcRun_Hty (equipment …BCV130SPY1).
  - Row 1752 (BCV131SPY1, BPL132) probably needs a BCV131 tag rather than a BCV130 one. It came from the runtime params tab as written.
- In the runtime params tab, the alarm/input names on these tiles also use CV701: CV701TM1_AvlFlt_A, CV701TM1_Avl, CV701SPY1FIT01_Dsc_A, CV701SPY1FIT01_Dsc. Those tags need creating under BCV130, or the tiles need re-pointing to the candidates above.

## Checks
- verify (v9 → v10, SCADA References): 4 intended changes, all red; nothing lost or unintended.
- strict_check: only the two existing info items (Used Pages and Runtime Params autoFilters are shorter than their data; both untouched).
