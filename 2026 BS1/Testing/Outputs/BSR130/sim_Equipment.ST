(* ====================================

     Equipment Simulations - START

=======================================*)

(* Constant random flow *)
Simulation_Random_Number_0 (	LowerLimit 	:= -0.1,
                            	UpperLimit 	:= 0.1,
                            	RandomNumber 	=> Sim_FTxx_rand);

(* enable and disable all simulations *)
IF Sim_EquipBlocks THEN

(* ====================================

     Safety — PNOZ / interlock feedbacks

=======================================*)

(* PNOZ devices from Sub + Field IO Assignment: *)
(*   PNOZs4: 39 row(s) — drives/tags: BAF130, BAF130GA01, BAF130HP01, BAF130PP05, BCV130, BCV130BK01, BJC130, BJC130HP01, BRB13x *)
(*   PNOZs4.1: 1 row(s) — drives/tags: BRB13x *)
(*   PNOZs7.1: 6 row(s) — drives/tags: BAF130, BRB13x *)
(*   PNOZs7.2: 2 row(s) — drives/tags: BAF130 *)

(* Safety / PNOZ-related DI healthy defaults (also set in sim_Initialise) *)
IF sim_init THEN
	sim_BAF130SY01_I := 1;
	sim_BAF130FNSY01_I := 1;
	sim_BJC130SY01_I := 1;
	sim_BAF130GA01SY01_I := 1;
	sim_BAF130PP07SY01_I := 1;
	sim_BAF130PP01SY01_I := 1;
	sim_BAF130PP02SY01_I := 1;
	sim_BAF130PP04SY01_I := 1;
	sim_BAF130FN01SY01_I := 1;
	sim_BAF130FN02SY01_I := 1;
	sim_BAF130FN03SY01_I := 1;
	sim_BAF130PP05SY01_I := 1;
	sim_BDU130FN01SY01_I := 1;
	sim_BDU130RV01SY01_I := 1;
	sim_BVG130DA01SY01_I := 1;
	sim_BJC130PP01SY01_I := 1;
	sim_BSR130DX02VDC03_I := 1;
	sim_BSR130DX02VDC04_I := 1;
	sim_BSR130DX02VDC06_I := 1;
	sim_BCV131SLC01SY01_I := 1;
	sim_BCV131SY01_I := 1;
	sim_BCV131SLC02SY01_I := 1;
	sim_BCV130SY01_I := 1;
	sim_BCV130DX07SY01_I := 1;
	sim_BCV130DX08SY01_I := 1;
	sim_BCV130DX09SY01_I := 1;
	sim_BCV130MA01SY01_I := 1;
	sim_BCV130MA01SY02_I := 1;
	sim_BCV130GB01SY01_I := 1;
	sim_BTN130PP01SY01_I := 1;
	sim_BCV130PP01SY01_I := 1;
	sim_BCV130PP03SY01_I := 1;
	sim_BCV130PP04SY01_I := 1;
	sim_BCV130FN01SY01_I := 1;
	sim_BCV130FN02SY01_I := 1;
	sim_BCV130PP02SY01_I := 1;
	sim_BCV130FN03SY01_I := 1;
	sim_BCV130FN04SY01_I := 1;
	sim_BCV130MT01EM01SY01_I := 1;
	sim_BCV130MT01EM02SY01_I := 1;
	sim_BBD130PP01SY01_I := 1;
	sim_BBD130DX03VDC06_I := 1;
	sim_BRB13xLCS01SY01_I := 1;
	sim_BRB13xLCS02SY02_I := 1;
	sim_BAF130LCS01SY01_I := 1;
	sim_BAF130HP01LCS01SY01_I := 1;
	sim_BJC130LCS01SY01_I := 1;
	sim_BJC130LCS02SY01_I := 1;
	sim_BRB13xLCS03SY03_I := 1;
	sim_BRB13xLCS04SY04_I := 1;
	sim_BJC130HP01PN01SY01_I := 1;
	sim_BAF130PP05LCS01SY01_I := 1;
	sim_BAF130GA01LCS01SY01_I := 1;
	sim_BRB13xLCS05SY05_I := 1;
	sim_BCV130LCS02SY01_I := 1;
	sim_BCV130LCS03SY01_I := 1;
	sim_BCV130DX08VDC06_I := 1;
	sim_BCV130MA01PN01SY01_I := 1;
	sim_BCV130LCS01SY01_I := 1;
	sim_BCV130BK01LCS01SY01_I := 1;
	sim_BAF130PWS01_I := 1;
	sim_BAF130PWS02_I := 1;
	sim_BCV130PWS09_I := 1;
	sim_BCV130PWS10_I := 1;
	sim_BCV130PWS11_I := 1;
	sim_BCV130PWS12_I := 1;
	sim_BCV130PWS13_I := 1;
	sim_BCV130PWS14_I := 1;
	sim_BCV130PWS05_I := 1;
	sim_BCV130PWS06_I := 1;
	sim_BCV130PWS07_I := 1;
	sim_BCV130PWS08_I := 1;
	sim_BCV130PWS01_I := 1;
	sim_BCV130PWS02_I := 1;
	sim_BCV130PWS03_I := 1;
	sim_BCV130PWS04_I := 1;
END_IF;

(* ====================================

     TeSysT motor starters (SIM_TeSysT)

=======================================*)

(* TeSysT PR sim DI healthy defaults (CB Closed, SY/VAC Healthy, CAX Closed) *)
IF sim_init THEN
	sim_BAF130PP07CB01_I := 1;
	sim_BAF130PP07CAX01_I := 1;
	sim_BAF130PP07SY01_I := 1;
	sim_BAF130PP01CB01_I := 1;
	sim_BAF130PP01CAX01_I := 1;
	sim_BAF130PP01SY01_I := 1;
	sim_BAF130PP01VAC01_I := 1;
	sim_BAF130PP02CB01_I := 1;
	sim_BAF130PP02CAX01_I := 1;
	sim_BAF130PP02SY01_I := 1;
	sim_BAF130PP02VAC01_I := 1;
	sim_BAF130PP04CB01_I := 1;
	sim_BAF130PP04CAX01_I := 1;
	sim_BAF130PP04SY01_I := 1;
	sim_BAF130FN01CB01_I := 1;
	sim_BAF130FN01CAX01_I := 1;
	sim_BAF130FN01SY01_I := 1;
	sim_BAF130FN02CB01_I := 1;
	sim_BAF130FN02CAX01_I := 1;
	sim_BAF130FN02SY01_I := 1;
	sim_BAF130FN03CB01_I := 1;
	sim_BAF130FN03CAX01_I := 1;
	sim_BAF130FN03SY01_I := 1;
	sim_BAF130PP05CB01_I := 1;
	sim_BAF130PP05CAX01_I := 1;
	sim_BAF130PP05SY01_I := 1;
	sim_BDU130FN01CB01_I := 1;
	sim_BDU130FN01CAX01_I := 1;
	sim_BDU130FN01SY01_I := 1;
	sim_BDU130FN01VAC01_I := 1;
	sim_BDU130RV01CB01_I := 1;
	sim_BDU130RV01CAX01_I := 1;
	sim_BDU130RV01SY01_I := 1;
	sim_BVG130DA01CB01_I := 1;
	sim_BVG130DA01CAX01_I := 1;
	sim_BVG130DA01SY01_I := 1;
	sim_BVG130DA01VAC01_I := 1;
	sim_BJC130PP01CB01_I := 1;
	sim_BJC130PP01CAX01_I := 1;
	sim_BJC130PP01SY01_I := 1;
	sim_BTN130PP01CB01_I := 1;
	sim_BTN130PP01CAX01_I := 1;
	sim_BTN130PP01SY01_I := 1;
	sim_BCV130PP01CB01_I := 1;
	sim_BCV130PP01CAX01_I := 1;
	sim_BCV130PP01SY01_I := 1;
	sim_BCV130PP03CB01_I := 1;
	sim_BCV130PP03CAX01_I := 1;
	sim_BCV130PP03SY01_I := 1;
	sim_BCV130PP04CB01_I := 1;
	sim_BCV130PP04CAX01_I := 1;
	sim_BCV130PP04SY01_I := 1;
	sim_BCV130FN01CB01_I := 1;
	sim_BCV130FN01CAX01_I := 1;
	sim_BCV130FN01SY01_I := 1;
	sim_BCV130FN02CB01_I := 1;
	sim_BCV130FN02CAX01_I := 1;
	sim_BCV130FN02SY01_I := 1;
	sim_BCV130PP02CB01_I := 1;
	sim_BCV130PP02CAX01_I := 1;
	sim_BCV130PP02SY01_I := 1;
	sim_BCV130FN03CB01_I := 1;
	sim_BCV130FN03CAX01_I := 1;
	sim_BCV130FN03SY01_I := 1;
	sim_BCV130FN04CB01_I := 1;
	sim_BCV130FN04CAX01_I := 1;
	sim_BCV130FN04SY01_I := 1;
	sim_BCV130MT01EM01CB01_I := 1;
	sim_BCV130MT01EM01CAX01_I := 1;
	sim_BCV130MT01EM01SY01_I := 1;
	sim_BCV130MT01EM02CB01_I := 1;
	sim_BCV130MT01EM02CAX01_I := 1;
	sim_BCV130MT01EM02SY01_I := 1;
	sim_BBD130PP01CB01_I := 1;
	sim_BBD130PP01CAX01_I := 1;
	sim_BBD130PP01SY01_I := 1;
	(* Master IP left 0.0.0.0 unless set by sim_Initialise / HMI *)
END_IF;

(* BAF130PP07 TeSysT → BAF130PP07PR1 *)
SIM_TeSysT_0 (iOutDatDDT := BAF130PP07PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF130PP07CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF130PP07CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF130PP07SY01_I,
               iFltID := 0,
               oInDatDDT => BAF130PP07PR1.Inputs);

(* BAF130PP01 TeSysT → BAF130PP01PR1 *)
SIM_TeSysT_1 (iOutDatDDT := BAF130PP01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF130PP01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := NOT sim_BAF130PP01VAC01_I,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF130PP01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF130PP01SY01_I,
               iFltID := 0,
               oInDatDDT => BAF130PP01PR1.Inputs);

(* BAF130PP02 TeSysT → BAF130PP02PR1 *)
SIM_TeSysT_2 (iOutDatDDT := BAF130PP02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF130PP02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := NOT sim_BAF130PP02VAC01_I,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF130PP02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF130PP02SY01_I,
               iFltID := 0,
               oInDatDDT => BAF130PP02PR1.Inputs);

(* BAF130PP04 TeSysT → BAF130PP04PR1 *)
SIM_TeSysT_3 (iOutDatDDT := BAF130PP04PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF130PP04CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF130PP04CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF130PP04SY01_I,
               iFltID := 0,
               oInDatDDT => BAF130PP04PR1.Inputs);

(* BAF130FN01 TeSysT → BAF130FN01PR1 *)
SIM_TeSysT_4 (iOutDatDDT := BAF130FN01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF130FN01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF130FN01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF130FN01SY01_I,
               iFltID := 0,
               oInDatDDT => BAF130FN01PR1.Inputs);

(* BAF130FN02 TeSysT → BAF130FN02PR1 *)
SIM_TeSysT_5 (iOutDatDDT := BAF130FN02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF130FN02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF130FN02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF130FN02SY01_I,
               iFltID := 0,
               oInDatDDT => BAF130FN02PR1.Inputs);

(* BAF130FN03 TeSysT → BAF130FN03PR1 *)
SIM_TeSysT_6 (iOutDatDDT := BAF130FN03PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF130FN03CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF130FN03CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF130FN03SY01_I,
               iFltID := 0,
               oInDatDDT => BAF130FN03PR1.Inputs);

(* BAF130PP05 TeSysT → BAF130PP05PR1 *)
SIM_TeSysT_7 (iOutDatDDT := BAF130PP05PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF130PP05CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF130PP05CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF130PP05SY01_I,
               iFltID := 0,
               oInDatDDT => BAF130PP05PR1.Inputs);

(* BDU130FN01 TeSysT → BDU130FN01PR1 *)
SIM_TeSysT_8 (iOutDatDDT := BDU130FN01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BDU130FN01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := NOT sim_BDU130FN01VAC01_I,
               iCAX01 := BOOL_TO_INT(IN := sim_BDU130FN01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BDU130FN01SY01_I,
               iFltID := 0,
               oInDatDDT => BDU130FN01PR1.Inputs);

(* BDU130RV01 TeSysT → BDU130RV01PR1 *)
SIM_TeSysT_9 (iOutDatDDT := BDU130RV01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BDU130RV01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BDU130RV01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BDU130RV01SY01_I,
               iFltID := 0,
               oInDatDDT => BDU130RV01PR1.Inputs);

(* BVG130DA01 TeSysT → BVG130DA01PR1 *)
SIM_TeSysT_10 (iOutDatDDT := BVG130DA01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BVG130DA01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := NOT sim_BVG130DA01VAC01_I,
               iCAX01 := BOOL_TO_INT(IN := sim_BVG130DA01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BVG130DA01SY01_I,
               iFltID := 0,
               oInDatDDT => BVG130DA01PR1.Inputs);

(* BJC130PP01 TeSysT → BJC130PP01PR1 *)
SIM_TeSysT_11 (iOutDatDDT := BJC130PP01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BJC130PP01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BJC130PP01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BJC130PP01SY01_I,
               iFltID := 0,
               oInDatDDT => BJC130PP01PR1.Inputs);

(* BTN130PP01 TeSysT → BTN130PP01PR1 *)
SIM_TeSysT_12 (iOutDatDDT := BTN130PP01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BTN130PP01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BTN130PP01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BTN130PP01SY01_I,
               iFltID := 0,
               oInDatDDT => BTN130PP01PR1.Inputs);

(* BCV130PP01 TeSysT → BCV130PP01PR1 *)
SIM_TeSysT_13 (iOutDatDDT := BCV130PP01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV130PP01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV130PP01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV130PP01SY01_I,
               iFltID := 0,
               oInDatDDT => BCV130PP01PR1.Inputs);

(* BCV130PP03 TeSysT → BCV130PP03PR1 *)
SIM_TeSysT_14 (iOutDatDDT := BCV130PP03PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV130PP03CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV130PP03CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV130PP03SY01_I,
               iFltID := 0,
               oInDatDDT => BCV130PP03PR1.Inputs);

(* BCV130PP04 TeSysT → BCV130PP04PR1 *)
SIM_TeSysT_15 (iOutDatDDT := BCV130PP04PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV130PP04CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV130PP04CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV130PP04SY01_I,
               iFltID := 0,
               oInDatDDT => BCV130PP04PR1.Inputs);

(* BCV130FN01 TeSysT → BCV130FN01PR1 *)
SIM_TeSysT_16 (iOutDatDDT := BCV130FN01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV130FN01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV130FN01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV130FN01SY01_I,
               iFltID := 0,
               oInDatDDT => BCV130FN01PR1.Inputs);

(* BCV130FN02 TeSysT → BCV130FN02PR1 *)
SIM_TeSysT_17 (iOutDatDDT := BCV130FN02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV130FN02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV130FN02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV130FN02SY01_I,
               iFltID := 0,
               oInDatDDT => BCV130FN02PR1.Inputs);

(* BCV130PP02 TeSysT → BCV130PP02PR1 *)
SIM_TeSysT_18 (iOutDatDDT := BCV130PP02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV130PP02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV130PP02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV130PP02SY01_I,
               iFltID := 0,
               oInDatDDT => BCV130PP02PR1.Inputs);

(* BCV130FN03 TeSysT → BCV130FN03PR1 *)
SIM_TeSysT_19 (iOutDatDDT := BCV130FN03PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV130FN03CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV130FN03CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV130FN03SY01_I,
               iFltID := 0,
               oInDatDDT => BCV130FN03PR1.Inputs);

(* BCV130FN04 TeSysT → BCV130FN04PR1 *)
SIM_TeSysT_20 (iOutDatDDT := BCV130FN04PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV130FN04CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV130FN04CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV130FN04SY01_I,
               iFltID := 0,
               oInDatDDT => BCV130FN04PR1.Inputs);

(* BCV130MT01EM01 TeSysT → BCV130MT01EM01PR1 *)
SIM_TeSysT_21 (iOutDatDDT := BCV130MT01EM01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV130MT01EM01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV130MT01EM01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV130MT01EM01SY01_I,
               iFltID := 0,
               oInDatDDT => BCV130MT01EM01PR1.Inputs);

(* BCV130MT01EM02 TeSysT → BCV130MT01EM02PR1 *)
SIM_TeSysT_22 (iOutDatDDT := BCV130MT01EM02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV130MT01EM02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV130MT01EM02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV130MT01EM02SY01_I,
               iFltID := 0,
               oInDatDDT => BCV130MT01EM02PR1.Inputs);

(* BBD130PP01 TeSysT → BBD130PP01PR1 *)
SIM_TeSysT_23 (iOutDatDDT := BBD130PP01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BBD130PP01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BBD130PP01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BBD130PP01SY01_I,
               iFltID := 0,
               oInDatDDT => BBD130PP01PR1.Inputs);

(* ====================================

     Analog AI / ART scaling (sim_AHI_Scale)

=======================================*)

(* BBN130LT01 — Level Transmitter 1 → Sim_BBD130DX03DIO1PLM4_Ch00PV *)
sim_AHI_Scale_0 (ioPV := sim_BBN130LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX03DIO1PLM4_Ch00PV);

(* BBN130LT02 — Level Transmitter 2 → Sim_BBD130DX03DIO1PLM4_Ch01PV *)
sim_AHI_Scale_1 (ioPV := sim_BBN130LT02_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX03DIO1PLM4_Ch01PV);

(* BBN130ZT01 — Truck Wheel Position → Sim_BBD130DX03DIO1PLM4_Ch02PV *)
sim_AHI_Scale_2 (ioPV := sim_BBN130ZT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX03DIO1PLM4_Ch02PV);

(* BBN130ZT02 — Truck Tray Position → Sim_BBD130DX03DIO1PLM4_Ch03PV *)
sim_AHI_Scale_3 (ioPV := sim_BBN130ZT02_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX03DIO1PLM4_Ch03PV);

(* BAF130LU01PT01 — Grease  Line 1 Pressure Transducer → Sim_BBD130DX04DIO1PLM6_Ch00PV *)
sim_AHI_Scale_4 (ioPV := sim_BAF130LU01PT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM6_Ch00PV);

(* BAF130LU01PT02 — Grease Line 2 Pressure Transducer → Sim_BBD130DX04DIO1PLM6_Ch01PV *)
sim_AHI_Scale_5 (ioPV := sim_BAF130LU01PT02_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM6_Ch01PV);

(* BAF130LU01PT03 — Oil Pressure Transducer → Sim_BBD130DX04DIO1PLM6_Ch02PV *)
sim_AHI_Scale_6 (ioPV := sim_BAF130LU01PT03_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM6_Ch02PV);

(* BAF130LU01PT04 — End Of Line 1 Pressure Transducer → Sim_BBD130DX04DIO1PLM6_Ch03PV *)
sim_AHI_Scale_7 (ioPV := sim_BAF130LU01PT04_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM6_Ch03PV);

(* BAF130LU01PT05 — End Of Line 2 Pressure Transducer → Sim_BBD130DX04DIO1PLM6_Ch04PV *)
sim_AHI_Scale_8 (ioPV := sim_BAF130LU01PT05_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM6_Ch04PV);

(* BAF130LU01LT01 — Grease Level Transducer → Sim_BBD130DX04DIO1PLM6_Ch05PV *)
sim_AHI_Scale_9 (ioPV := sim_BAF130LU01LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM6_Ch05PV);

(* BAF130HP01TT02 — Oil Cooler Inlet Temperature → Sim_BBD130DX04DIO1PLM6_Ch06PV *)
sim_AHI_Scale_10 (ioPV := sim_BAF130HP01TT02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM6_Ch06PV);

(* BAF130HP01TT03 — Oil Cooler Outlet Temperature → Sim_BBD130DX04DIO1PLM6_Ch07PV *)
sim_AHI_Scale_11 (ioPV := sim_BAF130HP01TT03_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM6_Ch07PV);

(* BAF130LT01 — Level Indicating Transmitter 1 → Sim_BBD130DX04DIO1PLM7_Ch00PV *)
sim_AHI_Scale_12 (ioPV := sim_BAF130LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM7_Ch00PV);

(* BAF130LT02 — Level Indicating Transmitter 2 → Sim_BBD130DX04DIO1PLM7_Ch01PV *)
sim_AHI_Scale_13 (ioPV := sim_BAF130LT02_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM7_Ch01PV);

(* BBD130FT21 — Flow Transmitter → Sim_BBD130DX04DIO1PLM7_Ch04PV *)
sim_AHI_Scale_14 (ioPV := sim_BBD130FT21_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM7_Ch04PV);

(* BAF130HP01FT01 — Hydraulic Motor Drain Flow  → Sim_BBD130DX04DIO1PLM7_Ch05PV *)
sim_AHI_Scale_15 (ioPV := sim_BAF130HP01FT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM7_Ch05PV);

(* BAF130HP01FT02 — Pump Group 1 Case Drain Flow → Sim_BBD130DX04DIO1PLM7_Ch06PV *)
sim_AHI_Scale_16 (ioPV := sim_BAF130HP01FT02_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM7_Ch06PV);

(* BAF130HP01FT03 — Pump Group 2 Case Drain Flow → Sim_BBD130DX04DIO1PLM7_Ch07PV *)
sim_AHI_Scale_17 (ioPV := sim_BAF130HP01FT03_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX04DIO1PLM7_Ch07PV);

(* BJC130LT01 — Chute Level → Sim_BBD130DX05DIO1PLM4_Ch00PV *)
sim_AHI_Scale_18 (ioPV := sim_BJC130LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM4_Ch00PV);

(* BJC130ZT01 — Gap Setting Measurement → Sim_BBD130DX05DIO1PLM4_Ch01PV *)
sim_AHI_Scale_19 (ioPV := sim_BJC130ZT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM4_Ch01PV);

(* BBD130PT20 — Pressure Transmitter → Sim_BBD130DX05DIO1PLM4_Ch02PV *)
sim_AHI_Scale_20 (ioPV := sim_BBD130PT20_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM4_Ch02PV);

(* BJC130HP01TT01 — TEMPERATURE TRANSMITTER → Sim_BBD130DX05DIO1PLM4_Ch03PV *)
sim_AHI_Scale_21 (ioPV := sim_BJC130HP01TT01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM4_Ch03PV);

(* BJC130LU01PT01 — Grease Line 1 Start Of Line Pressure → Sim_BBD130DX05DIO1PLM5_Ch00PV *)
sim_AHI_Scale_22 (ioPV := sim_BJC130LU01PT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM5_Ch00PV);

(* BJC130LU01PT02 — Grease Line 2 Start Of Line Pressure → Sim_BBD130DX05DIO1PLM5_Ch01PV *)
sim_AHI_Scale_23 (ioPV := sim_BJC130LU01PT02_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM5_Ch01PV);

(* BJC130LU01PT03 — Oil Pressure → Sim_BBD130DX05DIO1PLM5_Ch02PV *)
sim_AHI_Scale_24 (ioPV := sim_BJC130LU01PT03_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM5_Ch02PV);

(* BJC130LU01PT04 — Grease Line 1 End Of Line Pressure → Sim_BBD130DX05DIO1PLM5_Ch03PV *)
sim_AHI_Scale_25 (ioPV := sim_BJC130LU01PT04_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM5_Ch03PV);

(* BJC130LU01PT05 — Grease Line 2 End Of Line Pressure → Sim_BBD130DX05DIO1PLM5_Ch04PV *)
sim_AHI_Scale_26 (ioPV := sim_BJC130LU01PT05_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM5_Ch04PV);

(* BJC130LU01LT01 — Grease Level → Sim_BBD130DX05DIO1PLM5_Ch05PV *)
sim_AHI_Scale_27 (ioPV := sim_BJC130LU01LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM5_Ch05PV);

(* BJC130TT01 — Frame Left Bearing Temperature → Sim_BBD130DX05DIO1PLM6_Ch00PV *)
sim_AHI_Scale_28 (ioPV := sim_BJC130TT01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM6_Ch00PV);

(* BJC130TT02 — Frame Right Bearing Temperature → Sim_BBD130DX05DIO1PLM6_Ch01PV *)
sim_AHI_Scale_29 (ioPV := sim_BJC130TT02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM6_Ch01PV);

(* BJC130TT03 — Pitman Left Bearing Temperature → Sim_BBD130DX05DIO1PLM6_Ch02PV *)
sim_AHI_Scale_30 (ioPV := sim_BJC130TT03_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM6_Ch02PV);

(* BJC130TT04 — Pitman Right Bearing Temperature → Sim_BBD130DX05DIO1PLM6_Ch03PV *)
sim_AHI_Scale_31 (ioPV := sim_BJC130TT04_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX05DIO1PLM6_Ch03PV);

(* BBD130SM01LT01 — Level → Sim_BBD130DX06DIO1PLM5_Ch00PV *)
sim_AHI_Scale_32 (ioPV := sim_BBD130SM01LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX06DIO1PLM5_Ch00PV);

(* BDU130CP01PT01 — Filter Air Pressure → Sim_BBD130DX06DIO1PLM5_Ch01PV *)
sim_AHI_Scale_33 (ioPV := sim_BDU130CP01PT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX06DIO1PLM5_Ch01PV);

(* BDU130PDIT01XT01 — Differential Pressure → Sim_BBD130DX06DIO1PLM5_Ch02PV *)
sim_AHI_Scale_34 (ioPV := sim_BDU130PDIT01XT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX06DIO1PLM5_Ch02PV);

(* BAF130HP02TT01 — Temperature → Sim_BBD130DX06DIO1PLM5_Ch03PV *)
sim_AHI_Scale_35 (ioPV := sim_BAF130HP02TT01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD130DX06DIO1PLM5_Ch03PV);

(* BCV130FT04 — Flow Rate → Sim_BCV130DX07DIO1PLM4_Ch00PV *)
sim_AHI_Scale_36 (ioPV := sim_BCV130FT04_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX07DIO1PLM4_Ch00PV);

(* BCV130MA01IT01 — Current → Sim_BCV130DX08DIO1PLM5_Ch00PV *)
sim_AHI_Scale_37 (ioPV := sim_BCV130MA01IT01_PV,
                 iMax := 1000.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 1000.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX08DIO1PLM5_Ch00PV);

(* BCV130MA01XT01 — Voltage → Sim_BCV130DX08DIO1PLM5_Ch01PV *)
sim_AHI_Scale_38 (ioPV := sim_BCV130MA01XT01_PV,
                 iMax := 1000.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 1000.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX08DIO1PLM5_Ch01PV);

(* BCV130SM01LT01 — Level Transmitter → Sim_BCV130DX08DIO1PLM5_Ch02PV *)
sim_AHI_Scale_39 (ioPV := sim_BCV130SM01LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX08DIO1PLM5_Ch02PV);

(* BCV130MA01WT01 — Weightometer → Sim_BCV130DX08DIO1PLM5_Ch03PV *)
sim_AHI_Scale_40 (ioPV := sim_BCV130MA01WT01_PV,
                 iMax := 5000.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 5000.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX08DIO1PLM5_Ch03PV);

(* BTN130SM01LT01 — Sump Level → Sim_BCV130DX09DIO1PLM5_Ch00PV *)
sim_AHI_Scale_41 (ioPV := sim_BTN130SM01LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM5_Ch00PV);

(* BTN130PT01 — Pressure Transmitter → Sim_BCV130DX09DIO1PLM5_Ch01PV *)
sim_AHI_Scale_42 (ioPV := sim_BTN130PT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM5_Ch01PV);

(* BCV130FT03 — Flow Rate → Sim_BCV130DX09DIO1PLM5_Ch02PV *)
sim_AHI_Scale_43 (ioPV := sim_BCV130FT03_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM5_Ch02PV);

(* BCV130PP04FT01 — Flow Rate → Sim_BCV130DX09DIO1PLM5_Ch03PV *)
sim_AHI_Scale_44 (ioPV := sim_BCV130PP04FT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM5_Ch03PV);

(* BCV130RTD01 — Motor Red Winding 1 Temperature → Sim_BCV130DX09DIO1PLM6_Ch00PV *)
sim_AHI_Scale_45 (ioPV := sim_BCV130RTD01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM6_Ch00PV);

(* BCV130RTD02 — Motor White Winding 1 Temperature → Sim_BCV130DX09DIO1PLM6_Ch01PV *)
sim_AHI_Scale_46 (ioPV := sim_BCV130RTD02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM6_Ch01PV);

(* BCV130RTD03 — Motor Blue Winding 1 Temperature → Sim_BCV130DX09DIO1PLM6_Ch02PV *)
sim_AHI_Scale_47 (ioPV := sim_BCV130RTD03_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM6_Ch02PV);

(* BCV130RTD04 — Motor Red Winding 2 Temperature → Sim_BCV130DX09DIO1PLM6_Ch03PV *)
sim_AHI_Scale_48 (ioPV := sim_BCV130RTD04_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM6_Ch03PV);

(* BCV130RTD05 — Motor White Winding 2 Temperature → Sim_BCV130DX09DIO1PLM6_Ch04PV *)
sim_AHI_Scale_49 (ioPV := sim_BCV130RTD05_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM6_Ch04PV);

(* BCV130RTD06 — Motor Blue Winding 2 Temperature → Sim_BCV130DX09DIO1PLM6_Ch05PV *)
sim_AHI_Scale_50 (ioPV := sim_BCV130RTD06_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM6_Ch05PV);

(* BCV130RTD07 — Motor Non Drive End Bearing Temperature → Sim_BCV130DX09DIO1PLM6_Ch06PV *)
sim_AHI_Scale_51 (ioPV := sim_BCV130RTD07_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM6_Ch06PV);

(* BCV130RTD08 — Motor Drive End Bearing Temperature → Sim_BCV130DX09DIO1PLM6_Ch07PV *)
sim_AHI_Scale_52 (ioPV := sim_BCV130RTD08_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM6_Ch07PV);

(* BCV130RTD09 — Motor Air Inlet Ambient Temperature → Sim_BCV130DX09DIO1PLM7_Ch00PV *)
sim_AHI_Scale_53 (ioPV := sim_BCV130RTD09_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM7_Ch00PV);

(* BCV130GB01RTD01 — Gearboxdrive End Bearing Temperature → Sim_BCV130DX09DIO1PLM7_Ch01PV *)
sim_AHI_Scale_54 (ioPV := sim_BCV130GB01RTD01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM7_Ch01PV);

(* BCV130GB01RTD02 — Gearboxoil Temperature → Sim_BCV130DX09DIO1PLM7_Ch02PV *)
sim_AHI_Scale_55 (ioPV := sim_BCV130GB01RTD02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV130DX09DIO1PLM7_Ch02PV);

(* BTY1501FT02 — Raw Water From East Pit Flow Rate → Sim_SUB902DX10DIO1PLM5_Ch00PV *)
sim_AHI_Scale_56 (ioPV := sim_BTY1501FT02_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_SUB902DX10DIO1PLM5_Ch00PV);

(* BTY1501PT02 — Raw Water From East Pit Pressure → Sim_SUB902DX10DIO1PLM5_Ch01PV *)
sim_AHI_Scale_57 (ioPV := sim_BTY1501PT02_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_SUB902DX10DIO1PLM5_Ch01PV);

(* BTY1501FV01ZT01 — East Pit Flow Valve Position Feedback → Sim_SUB902DX10DIO1PLM5_Ch02PV *)
sim_AHI_Scale_58 (ioPV := sim_BTY1501FV01ZT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_SUB902DX10DIO1PLM5_Ch02PV);

(* BTY1501LT02 — Level Transmitter → Sim_SUB902DX10DIO1PLM5_Ch03PV *)
sim_AHI_Scale_59 (ioPV := sim_BTY1501LT02_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_SUB902DX10DIO1PLM5_Ch03PV);

(* BPP1108PT01 — HME Standpipe Pump 1 Pressure → Sim_SUB902DX10DIO1PLM6_Ch00PV *)
sim_AHI_Scale_60 (ioPV := sim_BPP1108PT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_SUB902DX10DIO1PLM6_Ch00PV);

(* BPP1109PT02 — HME Standpipe Pump 2 Pressure → Sim_SUB902DX10DIO1PLM6_Ch01PV *)
sim_AHI_Scale_61 (ioPV := sim_BPP1109PT02_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_SUB902DX10DIO1PLM6_Ch01PV);

(* BSTD1108FT01 — HME Standpipe Flow Rate → Sim_SUB902DX10DIO1PLM6_Ch02PV *)
sim_AHI_Scale_62 (ioPV := sim_BSTD1108FT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_SUB902DX10DIO1PLM6_Ch02PV);

(* BSTD1108FV01ZT01 — HME Standpipe Flow Valve Position → Sim_SUB902DX10DIO1PLM6_Ch03PV *)
sim_AHI_Scale_63 (ioPV := sim_BSTD1108FV01ZT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_SUB902DX10DIO1PLM6_Ch03PV);

(* ====================================

     Water addition / dust suppression / spray valves

=======================================*)

(*---- BBD130 sprays (1 SV) ----*)
IF BBD130SV13_O THEN
	sim_BBD130SV13_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBD130SV13_PV := 0.0;
END_IF;

sim_BBD130FT21_PV := (sim_BBD130SV13_PV) * 10.0;  (* L/s-ish aggregate into BBD130FT21 *)

(*---- BBN130 sprays (13 SV) ----*)
IF BBN130SV01_O THEN
	sim_BBN130SV01_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV01_PV := 0.0;
END_IF;

IF BBN130SV02_O THEN
	sim_BBN130SV02_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV02_PV := 0.0;
END_IF;

IF BBN130SV03_O THEN
	sim_BBN130SV03_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV03_PV := 0.0;
END_IF;

IF BBN130SV04_O THEN
	sim_BBN130SV04_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV04_PV := 0.0;
END_IF;

IF BBN130SV05_O THEN
	sim_BBN130SV05_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV05_PV := 0.0;
END_IF;

IF BBN130SV06_O THEN
	sim_BBN130SV06_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV06_PV := 0.0;
END_IF;

IF BBN130SV07_O THEN
	sim_BBN130SV07_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV07_PV := 0.0;
END_IF;

IF BBN130SV08_O THEN
	sim_BBN130SV08_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV08_PV := 0.0;
END_IF;

IF BBN130SV09_O THEN
	sim_BBN130SV09_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV09_PV := 0.0;
END_IF;

IF BBN130SV10_O THEN
	sim_BBN130SV10_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV10_PV := 0.0;
END_IF;

IF BBN130SV11_O THEN
	sim_BBN130SV11_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV11_PV := 0.0;
END_IF;

IF BBN130SV12_O THEN
	sim_BBN130SV12_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV12_PV := 0.0;
END_IF;

IF BBN130SV14_O THEN
	sim_BBN130SV14_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BBN130SV14_PV := 0.0;
END_IF;

(* No FT AI counterpart for BBN130 — SV PVs only *)

(*---- BCV130 sprays (6 SV) ----*)
IF BCV130SV04_O THEN
	sim_BCV130SV04_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BCV130SV04_PV := 0.0;
END_IF;

IF BCV130SV05_O THEN
	sim_BCV130SV05_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BCV130SV05_PV := 0.0;
END_IF;

IF BCV130SV06_O THEN
	sim_BCV130SV06_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BCV130SV06_PV := 0.0;
END_IF;

IF BCV130SV07_O THEN
	sim_BCV130SV07_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BCV130SV07_PV := 0.0;
END_IF;

IF BCV130SV08_O THEN
	sim_BCV130SV08_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BCV130SV08_PV := 0.0;
END_IF;

IF BCV130SV09_O THEN
	sim_BCV130SV09_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BCV130SV09_PV := 0.0;
END_IF;

sim_BCV130FT04_PV := (sim_BCV130SV04_PV + sim_BCV130SV05_PV + sim_BCV130SV06_PV + sim_BCV130SV07_PV + sim_BCV130SV08_PV + sim_BCV130SV09_PV) * 10.0;  (* L/s-ish aggregate into BCV130FT04 *)

(* ====================================

     Gate / valve actuator position feedback

=======================================*)

(* BAF130GA01 *)
IF BAF130GA01SV01_O THEN
	sim_BAF130GA01ZS01_I := 1;
	sim_BAF130GA01ZS03_I := 1;
	sim_BAF130GA01ZS02_I := 0;
	sim_BAF130GA01ZS04_I := 0;
ELSIF BAF130GA01SV02_O THEN
	sim_BAF130GA01ZS02_I := 1;
	sim_BAF130GA01ZS04_I := 1;
	sim_BAF130GA01ZS01_I := 0;
	sim_BAF130GA01ZS03_I := 0;
END_IF;

(* STUB: BSTD1108FV01 has ZS open=['BSTD1108FV01ZS01'] closed=['BSTD1108FV01ZS02'] but no SV DO on this PLC — drive from AO/remote or HMI *)
(* STUB: BTY1501FV01 has ZS open=['BTY1501FV01ZS01'] closed=['BTY1501FV01ZS02'] but no SV DO on this PLC — drive from AO/remote or HMI *)

(* ====================================

     Conveyor / tail brake (SIM_Brake)

=======================================*)

(* BCV130BK01 *)
SIM_Brake_0 (iReleaseSV 	:= BCV130BK01SV01_O	,
             iPmpReq 		:= BCV130BK01SV02_O	,
             iBrakePrsSP 	:= 1000.0		,
             iBrakePrsHoldSP 	:= 1050.0		,
             iLiftTime 		:= t#5s			,(* sim faster *)
             iDumpTime 		:= t#5s			,
             iFltMode 		:= sim_BCV130BK01_FltMod	,
             oLft 		=> sim_BCV130BK01PS01_I	,
             oPrsLo 		=> sim_BCV130BK01PS01A_I	,
             oBrakePrs 		=> sim_BCV130BK01_Prs_PV	,
	     irst 		:= sim_BCV130BK01_Rst);

sim_BCV130BK01ZS01A_I := sim_BCV130BK01PS01_I;
sim_BCV130BK01ZS02A_I := sim_BCV130BK01PS01_I;

(* ====================================

     Contactor aux (CAX) follows start relay (SR)

=======================================*)

sim_BAF130HT01CAX01_I 	:= BAF130HT01SR01_O;
sim_BAF130HT02CAX01_I 	:= BAF130HT02SR01_O;

(* ====================================

     CB Simulation

=======================================*)

(* BAF130HT01 *)
sim_CBSts_0 (ioSetTripped := sim_BAF130HT01TRP01_SetTrp,
             ioReset 	:= sim_BAF130HT01TRP01_SetOK,
             ioSetOpen 	:= sim_BAF130HT01TRP01_SetOpn,
             oClsd 	=> sim_BAF130HT01CB01_I,
             oTrpd 	=> sim_BAF130HT01TRP01_I);

(* BAF130HT02 *)
sim_CBSts_1 (ioSetTripped := sim_BAF130HT02TRP01_SetTrp,
             ioReset 	:= sim_BAF130HT02TRP01_SetOK,
             ioSetOpen 	:= sim_BAF130HT02TRP01_SetOpn,
             oClsd 	=> sim_BAF130HT02CB01_I,
             oTrpd 	=> sim_BAF130HT02TRP01_I);

(* BCV130MA01PN01 *)
sim_CBSts_2 (ioSetTripped := sim_BCV130MA01PN01TRP01_SetTrp,
             ioReset 	:= sim_BCV130MA01PN01TRP01_SetOK,
             ioSetOpen 	:= sim_BCV130MA01PN01TRP01_SetOpn,
             oClsd 	=> sim_BCV130MA01PN01CB01_I,
             oTrpd 	=> sim_BCV130MA01PN01TRP01_I);

(* BCV130VS01 *)
sim_CBSts_3 (ioSetTripped := sim_BCV130VS01TRP01_SetTrp,
             ioReset 	:= sim_BCV130VS01TRP01_SetOK,
             ioSetOpen 	:= sim_BCV130VS01TRP01_SetOpn,
             oClsd 	=> sim_BCV130VS01CB03_I,
             oTrpd 	=> sim_BCV130VS01TRP01_I);

(* BCV130WN01PN01 *)
sim_CBSts_4 (ioSetTripped := sim_BCV130WN01PN01TRP01_SetTrp,
             ioReset 	:= sim_BCV130WN01PN01TRP01_SetOK,
             ioSetOpen 	:= sim_BCV130WN01PN01TRP01_SetOpn,
             oClsd 	=> sim_BCV130WN01PN01CB01_I,
             oTrpd 	=> sim_BCV130WN01PN01TRP01_I);

(* BDU130CP01 *)
sim_CBSts_5 (ioSetTripped := sim_BDU130CP01TRP01_SetTrp,
             ioReset 	:= sim_BDU130CP01TRP01_SetOK,
             ioSetOpen 	:= sim_BDU130CP01TRP01_SetOpn,
             oClsd 	=> sim_BDU130CP01CB01_I,
             oTrpd 	=> sim_BDU130CP01TRP01_I);

(* BJC130HP01PN01 *)
sim_CBSts_6 (ioSetTripped := sim_BJC130HP01PN01TRP01_SetTrp,
             ioReset 	:= sim_BJC130HP01PN01TRP01_SetOK,
             ioSetOpen 	:= sim_BJC130HP01PN01TRP01_SetOpn,
             oClsd 	=> sim_BJC130HP01PN01CB01_I,
             oTrpd 	=> sim_BJC130HP01PN01TRP01_I);

(* BJC130VS01 *)
sim_CBSts_7 (ioSetTripped := sim_BJC130VS01TRP01_SetTrp,
             ioReset 	:= sim_BJC130VS01TRP01_SetOK,
             ioSetOpen 	:= sim_BJC130VS01TRP01_SetOpn,
             oClsd 	=> sim_BJC130VS01CB03_I,
             oTrpd 	=> sim_BJC130VS01TRP01_I);

(* BMC1301INC01 *)
sim_CBSts_8 (ioSetTripped := sim_BMC1301INC01TRP02_SetTrp,
             ioReset 	:= sim_BMC1301INC01TRP02_SetOK,
             ioSetOpen 	:= sim_BMC1301INC01TRP02_SetOpn,
             oClsd 	=> sim_BMC1301INC01CB02_I,
             oTrpd 	=> sim_BMC1301INC01TRP02_I);

(* BMC1302INC01 *)
sim_CBSts_9 (ioSetTripped := sim_BMC1302INC01TRP02_SetTrp,
             ioReset 	:= sim_BMC1302INC01TRP02_SetOK,
             ioSetOpen 	:= sim_BMC1302INC01TRP02_SetOpn,
             oClsd 	=> sim_BMC1302INC01CB02_I,
             oTrpd 	=> sim_BMC1302INC01TRP02_I);

(* BMC1302INC03 *)
sim_CBSts_10 (ioSetTripped := sim_BMC1302INC03TRP02_SetTrp,
             ioReset 	:= sim_BMC1302INC03TRP02_SetOK,
             ioSetOpen 	:= sim_BMC1302INC03TRP02_SetOpn,
             oClsd 	=> sim_BMC1302INC03CB03_I,
             oTrpd 	=> sim_BMC1302INC03TRP02_I);

(* BMC802INC01 *)
sim_CBSts_11 (ioSetTripped := sim_BMC802INC01TRP02_SetTrp,
             ioReset 	:= sim_BMC802INC01TRP02_SetOK,
             ioSetOpen 	:= sim_BMC802INC01TRP02_SetOpn,
             oClsd 	=> sim_BMC802INC01CB02_I,
             oTrpd 	=> sim_BMC802INC01TRP02_I);

(* BMC802INC02 *)
sim_CBSts_12 (ioSetTripped := sim_BMC802INC02TRP02_SetTrp,
             ioReset 	:= sim_BMC802INC02TRP02_SetOK,
             ioSetOpen 	:= sim_BMC802INC02TRP02_SetOpn,
             oClsd 	=> sim_BMC802INC02CB03_I,
             oTrpd 	=> sim_BMC802INC02TRP02_I);

(* BRB131CC01DB01 *)
sim_CBSts_13 (ioSetTripped := sim_BRB131CC01DB01TRP01_SetTrp,
             ioReset 	:= sim_BRB131CC01DB01TRP01_SetOK,
             ioSetOpen 	:= sim_BRB131CC01DB01TRP01_SetOpn,
             oClsd 	=> sim_BRB131CC01DB01CB01_I,
             oTrpd 	=> sim_BRB131CC01DB01TRP01_I);

(* BRB131HP01 *)
sim_CBSts_14 (ioSetTripped := sim_BRB131HP01TRP01_SetTrp,
             ioReset 	:= sim_BRB131HP01TRP01_SetOK,
             ioSetOpen 	:= sim_BRB131HP01TRP01_SetOpn,
             oClsd 	=> sim_BRB131HP01CB01_I,
             oTrpd 	=> sim_BRB131HP01TRP01_I);

(* BRB132HP01 *)
sim_CBSts_15 (ioSetTripped := sim_BRB132HP01TRP01_SetTrp,
             ioReset 	:= sim_BRB132HP01TRP01_SetOK,
             ioSetOpen 	:= sim_BRB132HP01TRP01_SetOpn,
             oClsd 	=> sim_BRB132HP01CB01_I,
             oTrpd 	=> sim_BRB132HP01TRP01_I);

(* BSB1301 *)
sim_CBSts_16 (ioSetTripped := sim_BSB1301TRP01_SetTrp,
             ioReset 	:= sim_BSB1301TRP01_SetOK,
             ioSetOpen 	:= sim_BSB1301TRP01_SetOpn,
             oClsd 	=> sim_BSB1301CB03_I,
             oTrpd 	=> sim_BSB1301TRP01_I);

(* BSR130AC01 *)
sim_CBSts_17 (ioSetTripped := sim_BSR130AC01TRP01_SetTrp,
             ioReset 	:= sim_BSR130AC01TRP01_SetOK,
             ioSetOpen 	:= sim_BSR130AC01TRP01_SetOpn,
             oClsd 	=> sim_BSR130AC01CB01_I,
             oTrpd 	=> sim_BSR130AC01TRP01_I);

(* BSR130AC02 *)
sim_CBSts_18 (ioSetTripped := sim_BSR130AC02TRP01_SetTrp,
             ioReset 	:= sim_BSR130AC02TRP01_SetOK,
             ioSetOpen 	:= sim_BSR130AC02TRP01_SetOpn,
             oClsd 	=> sim_BSR130AC02CB01_I,
             oTrpd 	=> sim_BSR130AC02TRP01_I);

(* BSR130BC01 *)
sim_CBSts_19 (ioSetTripped := sim_BSR130BC01TRP01_SetTrp,
             ioReset 	:= sim_BSR130BC01TRP01_SetOK,
             ioSetOpen 	:= sim_BSR130BC01TRP01_SetOpn,
             oClsd 	=> sim_BSR130BC01CB01_I,
             oTrpd 	=> sim_BSR130BC01TRP01_I);

(* BSR130BC02 *)
sim_CBSts_20 (ioSetTripped := sim_BSR130BC02TRP01_SetTrp,
             ioReset 	:= sim_BSR130BC02TRP01_SetOK,
             ioSetOpen 	:= sim_BSR130BC02TRP01_SetOpn,
             oClsd 	=> sim_BSR130BC02CB01_I,
             oTrpd 	=> sim_BSR130BC02TRP01_I);

(* BSR130DB01 *)
sim_CBSts_21 (ioSetTripped := sim_BSR130DB01TRP01_SetTrp,
             ioReset 	:= sim_BSR130DB01TRP01_SetOK,
             ioSetOpen 	:= sim_BSR130DB01TRP01_SetOpn,
             oClsd 	=> sim_BSR130DB01CB01_I,
             oTrpd 	=> sim_BSR130DB01TRP01_I);

(* BSR130DB02 *)
sim_CBSts_22 (ioSetTripped := sim_BSR130DB02TRP01_SetTrp,
             ioReset 	:= sim_BSR130DB02TRP01_SetOK,
             ioSetOpen 	:= sim_BSR130DB02TRP01_SetOpn,
             oClsd 	=> sim_BSR130DB02CB01_I,
             oTrpd 	=> sim_BSR130DB02TRP01_I);

(* BSR130DB03 *)
sim_CBSts_23 (ioSetTripped := sim_BSR130DB03TRP01_SetTrp,
             ioReset 	:= sim_BSR130DB03TRP01_SetOK,
             ioSetOpen 	:= sim_BSR130DB03TRP01_SetOpn,
             oClsd 	=> sim_BSR130DB03CB01_I,
             oTrpd 	=> sim_BSR130DB03TRP01_I);

(* BSR130DB04 *)
sim_CBSts_24 (ioSetTripped := sim_BSR130DB04TRP01_SetTrp,
             ioReset 	:= sim_BSR130DB04TRP01_SetOK,
             ioSetOpen 	:= sim_BSR130DB04TRP01_SetOpn,
             oClsd 	=> sim_BSR130DB04CB01_I,
             oTrpd 	=> sim_BSR130DB04TRP01_I);

(* BSR130DB05 *)
sim_CBSts_25 (ioSetTripped := sim_BSR130DB05TRP01_SetTrp,
             ioReset 	:= sim_BSR130DB05TRP01_SetOK,
             ioSetOpen 	:= sim_BSR130DB05TRP01_SetOpn,
             oClsd 	=> sim_BSR130DB05CB01_I,
             oTrpd 	=> sim_BSR130DB05TRP01_I);

(* BSR130UP01 *)
sim_CBSts_26 (ioSetTripped := sim_BSR130UP01TRP01_SetTrp,
             ioReset 	:= sim_BSR130UP01TRP01_SetOK,
             ioSetOpen 	:= sim_BSR130UP01TRP01_SetOpn,
             oClsd 	=> sim_BSR130UP01CB01_I,
             oTrpd 	=> sim_BSR130UP01TRP01_I);

(* SUB902BC01 *)
sim_CBSts_27 (ioSetTripped := sim_SUB902BC01TRP01_SetTrp,
             ioReset 	:= sim_SUB902BC01TRP01_SetOK,
             ioSetOpen 	:= sim_SUB902BC01TRP01_SetOpn,
             oClsd 	=> sim_SUB902BC01CB01_I,
             oTrpd 	=> sim_SUB902BC01TRP01_I);

(* SUB902BC02 *)
sim_CBSts_28 (ioSetTripped := sim_SUB902BC02TRP01_SetTrp,
             ioReset 	:= sim_SUB902BC02TRP01_SetOK,
             ioSetOpen 	:= sim_SUB902BC02TRP01_SetOpn,
             oClsd 	=> sim_SUB902BC02CB01_I,
             oTrpd 	=> sim_SUB902BC02TRP01_I);

(* SUB902DB01 *)
sim_CBSts_29 (ioSetTripped := sim_SUB902DB01TRP01_SetTrp,
             ioReset 	:= sim_SUB902DB01TRP01_SetOK,
             ioSetOpen 	:= sim_SUB902DB01TRP01_SetOpn,
             oClsd 	=> sim_SUB902DB01CB01_I,
             oTrpd 	=> sim_SUB902DB01TRP01_I);

END_IF;

(* ====================================

     Equipment Simulations - END

=======================================*)
