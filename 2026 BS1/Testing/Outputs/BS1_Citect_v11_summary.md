# BS1_Citect_v11 – summary

Base: BS1_Citect_v10.xlsm. One cell changed, in red font: SCADA References E348. Everything else is unchanged. calcChain stays removed; vbaProject.bin is byte-identical to Tim's file; full recalc on open.

## Row 348 (TM1 → MA01)
- NOT_BCV130TM1_AvlFlt_Hty → **NOT_BCV130MA01_AvlFlt_Hty**
- **Does not resolve.** None of these exist in SCADA Alarms or Tags, exactly or ignoring case, with or without the STS1 segment:
  - NOT_BCV130MA01_AvlFlt_Hty, BCV130MA01_AvlFlt(_Hty/_A)
  - BCV130MA01_Avl / BCV130MA01_Flt (and their NOT_/_Hty/_A forms)
- No MA01 tag has "Avl" in its name. So I used the fallback name, as instructed.
- Referenced Equipment is left as BR4.INLOADING.BP3PRCR.BCV130.MA01, which is the MA01 equipment. Category IL_NonCritical and Order 13 are unchanged.
- Closest real candidates:
  - NOT_BCV130MA01STS1_SysOK (Alarms; BCV130MA01STS1_SysOK in Tags). "System OK" is the closest to "available".
  - BCV130MA01STS1_PwrFlt / BCV130MA01STS1_PwrFlt_A (Alarms and Tags). This is a fault, but specifically a power fault.
  - NOT_BCV130MA01_Req, NOT_BCV130MA01_LocSttIL, NOT_BCV130MA01_SeqStpIL (Alarms)
  - All have equipment BR4.INLOADING.BP3PRCR.BCV130.MA01.

## Other TM1 references (not changed – flagged)
- **SCADA References rows 966 and 970:** NOT_BCV130TM1_AutRdy (IL_SeqStart and IL_LocalStart, under BCV130). This tag exists exactly in SCADA Alarms (equipment BR4.INLOADING.BP3PRCR.BCV130), and BCV130TM1_AutRdy exists in Tags. An MA01 version (BCV130MA01_AutRdy) doesn't exist, so renaming would break a reference that currently resolves. I left both unchanged.
- **Runtime params tab (Tim's source text, not edited):**
  - row 2897: Alarm:CV701TM1_AvlFlt_A, Not_Input:CV701TM1_Avl, Not_Interlock:CV701TM1_AvlFlt_Hty
  - rows 4819, 4830: Interlock:BCV130TM1_AutRdy

## Checks
- verify (v10 → v11): 1 intended red change, nothing lost or unintended.
- strict_check: only the two existing info items (Used Pages and Runtime Params autoFilters are shorter than their data).
