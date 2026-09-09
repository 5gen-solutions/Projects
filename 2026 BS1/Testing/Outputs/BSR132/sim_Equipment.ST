(* ====================================

     Equipment Simulations - START

=======================================*)


(* enable and disable all simulations *)
IF Sim_EquipBlocks THEN

(* ====================================

     ABB REX640 6.6kV Relays

=======================================*)

(* Incomer: BMC1321INC01PR1 → BMC1321INC01PR1.Inputs *)
sim_BMC1321INC01PR1_SlotBDI := 	BIT_TO_WORD (BIT0 := sim_BMC1321INC01CB01A_I,
	                         BIT1 := sim_BMC1321INC01CB01B_I,
	                         BIT2 := sim_BMC1321INC01XS04_I,
	                         BIT3 := sim_BMC1321INC01XS01A_I,
	                         BIT4 := sim_BMC1321INC01XS01B_I,
	                         BIT5 := sim_BMC1321INC01XS02A_I,
	                         BIT6 := sim_BMC1321INC01XS02B_I,
	                         BIT7 := sim_BMC1321INC01XS03A_I,
	                         BIT8 := sim_BMC1321INC01XS03B_I,
	                         BIT9 := sim_BMC1321INC01XS03C_I,
	                         BIT10 := sim_BMC1321INC01CB02_I,
	                         BIT11 := sim_BMC1321INC01CB03_I,
	                         BIT12 := FALSE,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

sim_BMC1321INC01PR1_SlotCDI := 	BIT_TO_WORD (BIT0 := sim_BMC1321INC01XS06_I,
	                         BIT1 := sim_BMC1321INC01SW01A_I,
	                         BIT2 := sim_BMC1321INC01SW01B_I,
	                         BIT3 := sim_BMC1321INC01SW02_I,
	                         BIT4 := sim_BMC1321INC01SW03_I,
	                         BIT5 := sim_BMC1321INC01CB04_I,
	                         BIT6 := FALSE,
	                         BIT7 := sim_BMC1321INC01XS07_I,
	                         BIT8 := FALSE,
	                         BIT9 := sim_BMC1321INC01TRP03_I,
	                         BIT10 := sim_BMC1321INC01TRP04_I,
	                         BIT11 := sim_BMC1321INC01TRP05_I,
	                         BIT12 := FALSE,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

sim_BMC1321INC01PR1_SlotGDIO := 	BIT_TO_WORD (BIT0 := FALSE,
	                         BIT1 := FALSE,
	                         BIT2 := FALSE,
	                         BIT3 := FALSE,
	                         BIT4 := FALSE,
	                         BIT5 := FALSE,
	                         BIT6 := FALSE,
	                         BIT7 := sim_BMC1321INC01TRP01_I,
	                         BIT8 := sim_BMC1321INC01TRP02_I,
	                         BIT9 := FALSE,
	                         BIT10 := FALSE,
	                         BIT11 := FALSE,
	                         BIT12 := FALSE,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

IF sim_init THEN
	sim_BMC1321INC01PR1_Amps	:= 15.0;
	sim_BMC1321INC01PR1_Volts	:= 6.6;
END_IF;
sim_rex640_0 (iFlt 	:= sim_BMC1321INC01PR1_Flt,
              iSlotBDI 	:= sim_BMC1321INC01PR1_SlotBDI,
              iSlotCDI 	:= sim_BMC1321INC01PR1_SlotCDI,
              iSlotBDO := sim_BMC1321INC01PR1_SlotBDO,
              iSlotCDO := sim_BMC1321INC01PR1_SlotCDO,
              iSlotGDIO := sim_BMC1321INC01PR1_SlotGDIO,
              iFunSts := sim_BMC1321INC01PR1_FunSts,
              iAmps := sim_BMC1321INC01PR1_Amps,
              iVolts := sim_BMC1321INC01PR1_Volts,
	      iIn	:= 600.0,
	      iUn	:= 6.6,
              oDatDDT => BMC1321INC01PR1.Inputs);

(* Feeder: BMC1321FDR01PR1 → BMC1321FDR01PR1.Inputs *)
sim_BMC1321FDR01PR1_SlotBDI := 	BIT_TO_WORD (BIT0 := sim_BMC1321FDR01CB01A_I,
	                         BIT1 := sim_BMC1321FDR01CB01B_I,
	                         BIT2 := sim_BMC1321FDR01XS04_I,
	                         BIT3 := sim_BMC1321FDR01XS01A_I,
	                         BIT4 := sim_BMC1321FDR01XS01B_I,
	                         BIT5 := sim_BMC1321FDR01XS02A_I,
	                         BIT6 := sim_BMC1321FDR01XS02B_I,
	                         BIT7 := sim_BMC1321FDR01XS03A_I,
	                         BIT8 := sim_BMC1321FDR01XS03B_I,
	                         BIT9 := sim_BMC1321FDR01XS03C_I,
	                         BIT10 := sim_BMC1321FDR01CB02_I,
	                         BIT11 := sim_BMC1321FDR01CB03_I,
	                         BIT12 := FALSE,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

sim_BMC1321FDR01PR1_SlotCDI := 	BIT_TO_WORD (BIT0 := sim_BMC1321FDR01XS06_I,
	                         BIT1 := sim_BMC1321FDR01SW01A_I,
	                         BIT2 := sim_BMC1321FDR01SW01B_I,
	                         BIT3 := sim_BMC1321FDR01SW02_I,
	                         BIT4 := sim_BMC1321FDR01SW03_I,
	                         BIT5 := sim_BMC1321FDR01CB04_I,
	                         BIT6 := FALSE,
	                         BIT7 := sim_BMC1321FDR01XS07_I,
	                         BIT8 := sim_BMC1321FDR01XS08_I,
	                         BIT9 := sim_BMC1321FDR01TRP03_I,
	                         BIT10 := sim_BMC1321FDR01TRP04_I,
	                         BIT11 := sim_BMC1321FDR01XS12_I,
	                         BIT12 := sim_BMC1321FDR01XS09_I,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

sim_BMC1321FDR01PR1_SlotGDIO := 	BIT_TO_WORD (BIT0 := FALSE,
	                         BIT1 := FALSE,
	                         BIT2 := FALSE,
	                         BIT3 := FALSE,
	                         BIT4 := FALSE,
	                         BIT5 := FALSE,
	                         BIT6 := FALSE,
	                         BIT7 := sim_BMC1321FDR01TRP01_I,
	                         BIT8 := sim_BMC1321FDR01TRP02_I,
	                         BIT9 := FALSE,
	                         BIT10 := FALSE,
	                         BIT11 := FALSE,
	                         BIT12 := FALSE,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

IF sim_init THEN
	sim_BMC1321FDR01PR1_Amps	:= 15.0;
	sim_BMC1321FDR01PR1_Volts	:= 6.6;
END_IF;
sim_rex640_1 (iFlt 	:= sim_BMC1321FDR01PR1_Flt,
              iSlotBDI 	:= sim_BMC1321FDR01PR1_SlotBDI,
              iSlotCDI 	:= sim_BMC1321FDR01PR1_SlotCDI,
              iSlotBDO := sim_BMC1321FDR01PR1_SlotBDO,
              iSlotCDO := sim_BMC1321FDR01PR1_SlotCDO,
              iSlotGDIO := sim_BMC1321FDR01PR1_SlotGDIO,
              iFunSts := sim_BMC1321FDR01PR1_FunSts,
              iAmps := sim_BMC1321FDR01PR1_Amps,
              iVolts := sim_BMC1321FDR01PR1_Volts,
	      iIn	:= 400.0,
	      iUn	:= 6.6,
              oDatDDT => BMC1321FDR01PR1.Inputs);

(* Feeder: BMC1321FDR02PR1 → BMC1321FDR02PR1.Inputs *)
sim_BMC1321FDR02PR1_SlotBDI := 	BIT_TO_WORD (BIT0 := sim_BMC1321FDR02CB01A_I,
	                         BIT1 := sim_BMC1321FDR02CB01B_I,
	                         BIT2 := sim_BMC1321FDR02XS04_I,
	                         BIT3 := sim_BMC1321FDR02XS01A_I,
	                         BIT4 := sim_BMC1321FDR02XS01B_I,
	                         BIT5 := sim_BMC1321FDR02XS02A_I,
	                         BIT6 := sim_BMC1321FDR02XS02B_I,
	                         BIT7 := sim_BMC1321FDR02XS03A_I,
	                         BIT8 := sim_BMC1321FDR02XS03B_I,
	                         BIT9 := sim_BMC1321FDR02XS03C_I,
	                         BIT10 := sim_BMC1321FDR02CB02_I,
	                         BIT11 := sim_BMC1321FDR02CB03_I,
	                         BIT12 := FALSE,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

sim_BMC1321FDR02PR1_SlotCDI := 	BIT_TO_WORD (BIT0 := sim_BMC1321FDR02XS06_I,
	                         BIT1 := sim_BMC1321FDR02SW01A_I,
	                         BIT2 := sim_BMC1321FDR02SW01B_I,
	                         BIT3 := sim_BMC1321FDR02SW02_I,
	                         BIT4 := sim_BMC1321FDR02SW03_I,
	                         BIT5 := sim_BMC1321FDR02CB04_I,
	                         BIT6 := FALSE,
	                         BIT7 := sim_BMC1321FDR02XS07_I,
	                         BIT8 := sim_BMC1321FDR02XS08_I,
	                         BIT9 := sim_BMC1321FDR02TRP03_I,
	                         BIT10 := sim_BMC1321FDR02TRP04_I,
	                         BIT11 := sim_BMC1321FDR02XS12_I,
	                         BIT12 := sim_BMC1321FDR02XS09_I,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

sim_BMC1321FDR02PR1_SlotGDIO := 	BIT_TO_WORD (BIT0 := FALSE,
	                         BIT1 := FALSE,
	                         BIT2 := FALSE,
	                         BIT3 := FALSE,
	                         BIT4 := FALSE,
	                         BIT5 := FALSE,
	                         BIT6 := FALSE,
	                         BIT7 := sim_BMC1321FDR02TRP01_I,
	                         BIT8 := sim_BMC1321FDR02TRP02_I,
	                         BIT9 := FALSE,
	                         BIT10 := FALSE,
	                         BIT11 := FALSE,
	                         BIT12 := FALSE,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

IF sim_init THEN
	sim_BMC1321FDR02PR1_Amps	:= 15.0;
	sim_BMC1321FDR02PR1_Volts	:= 6.6;
END_IF;
sim_rex640_2 (iFlt 	:= sim_BMC1321FDR02PR1_Flt,
              iSlotBDI 	:= sim_BMC1321FDR02PR1_SlotBDI,
              iSlotCDI 	:= sim_BMC1321FDR02PR1_SlotCDI,
              iSlotBDO := sim_BMC1321FDR02PR1_SlotBDO,
              iSlotCDO := sim_BMC1321FDR02PR1_SlotCDO,
              iSlotGDIO := sim_BMC1321FDR02PR1_SlotGDIO,
              iFunSts := sim_BMC1321FDR02PR1_FunSts,
              iAmps := sim_BMC1321FDR02PR1_Amps,
              iVolts := sim_BMC1321FDR02PR1_Volts,
	      iIn	:= 400.0,
	      iUn	:= 6.6,
              oDatDDT => BMC1321FDR02PR1.Inputs);

(* Feeder: BMC1321FDR03PR1 → BMC1321FDR03PR1.Inputs *)
sim_BMC1321FDR03PR1_SlotBDI := 	BIT_TO_WORD (BIT0 := sim_BMC1321FDR03CB01A_I,
	                         BIT1 := sim_BMC1321FDR03CB01B_I,
	                         BIT2 := sim_BMC1321FDR03XS04_I,
	                         BIT3 := sim_BMC1321FDR03XS01A_I,
	                         BIT4 := sim_BMC1321FDR03XS01B_I,
	                         BIT5 := sim_BMC1321FDR03XS02A_I,
	                         BIT6 := sim_BMC1321FDR03XS02B_I,
	                         BIT7 := sim_BMC1321FDR03XS03A_I,
	                         BIT8 := sim_BMC1321FDR03XS03B_I,
	                         BIT9 := sim_BMC1321FDR03XS03C_I,
	                         BIT10 := sim_BMC1321FDR03CB02_I,
	                         BIT11 := sim_BMC1321FDR03CB03_I,
	                         BIT12 := FALSE,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

sim_BMC1321FDR03PR1_SlotCDI := 	BIT_TO_WORD (BIT0 := sim_BMC1321FDR03XS06_I,
	                         BIT1 := sim_BMC1321FDR03SW01A_I,
	                         BIT2 := sim_BMC1321FDR03SW01B_I,
	                         BIT3 := sim_BMC1321FDR03SW02_I,
	                         BIT4 := sim_BMC1321FDR03SW03_I,
	                         BIT5 := sim_BMC1321FDR03CB04_I,
	                         BIT6 := FALSE,
	                         BIT7 := sim_BMC1321FDR03XS07_I,
	                         BIT8 := sim_BMC1321FDR03XS08_I,
	                         BIT9 := sim_BMC1321FDR03TRP03_I,
	                         BIT10 := sim_BMC1321FDR03TRP04_I,
	                         BIT11 := sim_BMC1321FDR03XS12_I,
	                         BIT12 := sim_BMC1321FDR03XS09_I,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

sim_BMC1321FDR03PR1_SlotGDIO := 	BIT_TO_WORD (BIT0 := FALSE,
	                         BIT1 := FALSE,
	                         BIT2 := FALSE,
	                         BIT3 := FALSE,
	                         BIT4 := FALSE,
	                         BIT5 := FALSE,
	                         BIT6 := FALSE,
	                         BIT7 := sim_BMC1321FDR03TRP01_I,
	                         BIT8 := sim_BMC1321FDR03TRP02_I,
	                         BIT9 := FALSE,
	                         BIT10 := FALSE,
	                         BIT11 := FALSE,
	                         BIT12 := FALSE,
	                         BIT13 := FALSE,
	                         BIT14 := FALSE,
	                         BIT15 := FALSE);

IF sim_init THEN
	sim_BMC1321FDR03PR1_Amps	:= 15.0;
	sim_BMC1321FDR03PR1_Volts	:= 6.6;
END_IF;
sim_rex640_3 (iFlt 	:= sim_BMC1321FDR03PR1_Flt,
              iSlotBDI 	:= sim_BMC1321FDR03PR1_SlotBDI,
              iSlotCDI 	:= sim_BMC1321FDR03PR1_SlotCDI,
              iSlotBDO := sim_BMC1321FDR03PR1_SlotBDO,
              iSlotCDO := sim_BMC1321FDR03PR1_SlotCDO,
              iSlotGDIO := sim_BMC1321FDR03PR1_SlotGDIO,
              iFunSts := sim_BMC1321FDR03PR1_FunSts,
              iAmps := sim_BMC1321FDR03PR1_Amps,
              iVolts := sim_BMC1321FDR03PR1_Volts,
	      iIn	:= 400.0,
	      iUn	:= 6.6,
              oDatDDT => BMC1321FDR03PR1.Inputs);

(* ====================================

     Safety — FlexiSoft 

=======================================*)

(* FlexiSoft BCV131SLC02 *)

sim_BCV131SLC01_PriOKArr[0] := BIT_TO_WORD
			(BIT0 := sim_BAF130PWS01_I,
                         BIT1 := sim_BAF130PWS02_I,
                         BIT2 := sim_BAF131PWS01_I,
                         BIT3 := sim_BAF131PWS02_I,
                         BIT4 := sim_BCV130PWS01_I,
                         BIT5 := sim_BCV130PWS02_I,
                         BIT6 := sim_BCV130PWS03_I,
                         BIT7 := sim_BCV130PWS04_I,
                         BIT8 := sim_BCV130PWS05_I,
                         BIT9 := sim_BCV130PWS06_I,
                         BIT10 := sim_BCV130PWS07_I,
                         BIT11 := sim_BCV130PWS08_I,
                         BIT12 := sim_BCV130PWS09_I,
                         BIT13 := sim_BCV130PWS10_I,
                         BIT14 := sim_BCV130PWS11_I,
                         BIT15 := sim_BCV130PWS12_I);
sim_BCV131SLC01_PriOKArr[1] := BIT_TO_WORD
			(BIT0 := sim_BCV130PWS13_I,
                         BIT1 := sim_BCV130PWS14_I,
                         BIT2 := TRUE,
                         BIT3 := TRUE,
                         BIT4 := TRUE,
                         BIT5 := TRUE,
                         BIT6 := TRUE,
                         BIT7 := TRUE,
                         BIT8 := TRUE,
                         BIT9 := TRUE,
                         BIT10 := TRUE,
                         BIT11 := TRUE,
                         BIT12 := TRUE,
                         BIT13 := TRUE,
                         BIT14 := TRUE,
                         BIT15 := TRUE);
sim_BCV131SLC01_PriOKArr[2] := BIT_TO_WORD
			(BIT0 := TRUE,
                         BIT1 := TRUE,
                         BIT2 := TRUE,
                         BIT3 := TRUE,
                         BIT4 := TRUE,
                         BIT5 := TRUE,
                         BIT6 := TRUE,
                         BIT7 := TRUE,
                         BIT8 := TRUE,
                         BIT9 := TRUE,
                         BIT10 := TRUE,
                         BIT11 := TRUE,
                         BIT12 := TRUE,
                         BIT13 := TRUE,
                         BIT14 := TRUE,
                         BIT15 := TRUE);
sim_BCV131SLC01_PriOKArr[3] := BIT_TO_WORD
			(BIT0 := TRUE,
                         BIT1 := TRUE,
                         BIT2 := TRUE,
                         BIT3 := TRUE,
                         BIT4 := TRUE,
                         BIT5 := TRUE,
                         BIT6 := TRUE,
                         BIT7 := TRUE,
                         BIT8 := TRUE,
                         BIT9 := TRUE,
                         BIT10 := TRUE,
                         BIT11 := TRUE,
                         BIT12 := TRUE,
                         BIT13 := TRUE,
                         BIT14 := TRUE,
                         BIT15 := TRUE);
SIM_FlexiSoft_0 (iOutDatDDT := BCV131SLC01.Outputs,
                 iPriOKWd1 := sim_BCV131SLC01_PriOKArr[0],
                 iPriOKWd2 := sim_BCV131SLC01_PriOKArr[1],
		 iPriOKWd3 := sim_BCV131SLC01_PriOKArr[2],
                 iPriOKWd4 := sim_BCV131SLC01_PriOKArr[3],
                 oInDatDDT => BCV131SLC01.Inputs);

(* FlexiSoft BCV131SLC02 *)

sim_BCV131SLC02_PriOKArr[0] := BIT_TO_WORD
			(BIT0 := sim_BAF130PWS01_I,
                         BIT1 := sim_BAF130PWS02_I,
                         BIT2 := sim_BAF131PWS01_I,
                         BIT3 := sim_BAF131PWS02_I,
                         BIT4 := sim_BCV130PWS01_I,
                         BIT5 := sim_BCV130PWS02_I,
                         BIT6 := sim_BCV130PWS03_I,
                         BIT7 := sim_BCV130PWS04_I,
                         BIT8 := sim_BCV130PWS05_I,
                         BIT9 := sim_BCV130PWS06_I,
                         BIT10 := sim_BCV130PWS07_I,
                         BIT11 := sim_BCV130PWS08_I,
                         BIT12 := sim_BCV130PWS09_I,
                         BIT13 := sim_BCV130PWS10_I,
                         BIT14 := sim_BCV130PWS11_I,
                         BIT15 := sim_BCV130PWS12_I);
sim_BCV131SLC02_PriOKArr[1] := BIT_TO_WORD
			(BIT0 := sim_BCV130PWS13_I,
                         BIT1 := sim_BCV130PWS14_I,
                         BIT2 := TRUE,
                         BIT3 := TRUE,
                         BIT4 := TRUE,
                         BIT5 := TRUE,
                         BIT6 := TRUE,
                         BIT7 := TRUE,
                         BIT8 := TRUE,
                         BIT9 := TRUE,
                         BIT10 := TRUE,
                         BIT11 := TRUE,
                         BIT12 := TRUE,
                         BIT13 := TRUE,
                         BIT14 := TRUE,
                         BIT15 := TRUE);
sim_BCV131SLC02_PriOKArr[2] := BIT_TO_WORD
			(BIT0 := TRUE,
                         BIT1 := TRUE,
                         BIT2 := TRUE,
                         BIT3 := TRUE,
                         BIT4 := TRUE,
                         BIT5 := TRUE,
                         BIT6 := TRUE,
                         BIT7 := TRUE,
                         BIT8 := TRUE,
                         BIT9 := TRUE,
                         BIT10 := TRUE,
                         BIT11 := TRUE,
                         BIT12 := TRUE,
                         BIT13 := TRUE,
                         BIT14 := TRUE,
                         BIT15 := TRUE);
sim_BCV131SLC02_PriOKArr[3] := BIT_TO_WORD
			(BIT0 := TRUE,
                         BIT1 := TRUE,
                         BIT2 := TRUE,
                         BIT3 := TRUE,
                         BIT4 := TRUE,
                         BIT5 := TRUE,
                         BIT6 := TRUE,
                         BIT7 := TRUE,
                         BIT8 := TRUE,
                         BIT9 := TRUE,
                         BIT10 := TRUE,
                         BIT11 := TRUE,
                         BIT12 := TRUE,
                         BIT13 := TRUE,
                         BIT14 := TRUE,
                         BIT15 := TRUE);
SIM_FlexiSoft_1 (iOutDatDDT := BCV131SLC02.Outputs,
                 iPriOKWd1 := sim_BCV131SLC02_PriOKArr[0],
                 iPriOKWd2 := sim_BCV131SLC02_PriOKArr[1],
		 iPriOKWd3 := sim_BCV131SLC02_PriOKArr[2],
                 iPriOKWd4 := sim_BCV131SLC02_PriOKArr[3],
                 oInDatDDT => BCV131SLC02.Inputs);


(* ====================================

     Analog AI / ART scaling (sim_AHI_Scale)

=======================================*)

(* BBN131LIT01 — Bin Level → Sim_BBD131DX03DIO1PLM3_Ch00PV *)
sim_AHI_Scale_0 (ioPV := sim_BBN131LIT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX03DIO1PLM3_Ch00PV);

(* BBN131LIT02 — Bin Level → Sim_BBD131DX03DIO1PLM3_Ch01PV *)
sim_AHI_Scale_1 (ioPV := sim_BBN131LIT02_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX03DIO1PLM3_Ch01PV);

(* BDU131PN01PDT01 — Filter Bag Pressure Differential → Sim_BBD131DX03DIO1PLM3_Ch02PV *)
sim_AHI_Scale_2 (ioPV := sim_BDU131PN01PDT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX03DIO1PLM3_Ch02PV);

(* BAF131LU01PT01 — End Of Line 1 Pressure Transducer → Sim_BBD131DX04DIO1PLM4_Ch00PV *)
sim_AHI_Scale_3 (ioPV := sim_BAF131LU01PT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM4_Ch00PV);

(* BAF131LU01PT02 — End Of Line 2 Pressure Transducer → Sim_BBD131DX04DIO1PLM4_Ch01PV *)
sim_AHI_Scale_4 (ioPV := sim_BAF131LU01PT02_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM4_Ch01PV);

(* BAF131LU01PT03 — Oil Pressure Transducer → Sim_BBD131DX04DIO1PLM4_Ch02PV *)
sim_AHI_Scale_5 (ioPV := sim_BAF131LU01PT03_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM4_Ch02PV);

(* BAF131LU01PT04 — Pump Line 1 Pressure Transducer → Sim_BBD131DX04DIO1PLM4_Ch03PV *)
sim_AHI_Scale_6 (ioPV := sim_BAF131LU01PT04_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM4_Ch03PV);

(* BAF131LU01PT05 — Pump Line 2 Pressure Transducer → Sim_BBD131DX04DIO1PLM4_Ch04PV *)
sim_AHI_Scale_7 (ioPV := sim_BAF131LU01PT05_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM4_Ch04PV);

(* BAF131LU01LT01 — Grease Level Transducer → Sim_BBD131DX04DIO1PLM4_Ch05PV *)
sim_AHI_Scale_8 (ioPV := sim_BAF131LU01LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM4_Ch05PV);

(* BBD131SM01LIT01 — Sump Level → Sim_BBD131DX04DIO1PLM5_Ch00PV *)
sim_AHI_Scale_9 (ioPV := sim_BBD131SM01LIT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM5_Ch00PV);

(* BDU131CP01PIT01PT01 — Pressure → Sim_BBD131DX04DIO1PLM5_Ch01PV *)
sim_AHI_Scale_10 (ioPV := sim_BDU131CP01PIT01PT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM5_Ch01PV);

(* BBD131FIT02FT02 — Flow Rate → Sim_BBD131DX04DIO1PLM5_Ch02PV *)
sim_AHI_Scale_11 (ioPV := sim_BBD131FIT02FT02_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM5_Ch02PV);

(* BAF131HP01TT02 — Oil Cooler Inlet Temperature → Sim_BBD131DX04DIO1PLM5_Ch03PV *)
sim_AHI_Scale_12 (ioPV := sim_BAF131HP01TT02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM5_Ch03PV);

(* BAF131HP01TT03 — Oil Cooler Outlet Temperature → Sim_BBD131DX04DIO1PLM5_Ch04PV *)
sim_AHI_Scale_13 (ioPV := sim_BAF131HP01TT03_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX04DIO1PLM5_Ch04PV);

(* BTK2104FT01 — Flow Rate → Sim_BBD131DX05DIO1PLM4_Ch00PV *)
sim_AHI_Scale_14 (ioPV := sim_BTK2104FT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM4_Ch00PV);

(* BTK2104LT01 — Tank Level → Sim_BBD131DX05DIO1PLM4_Ch01PV *)
sim_AHI_Scale_15 (ioPV := sim_BTK2104LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM4_Ch01PV);

(* BTK2105FT01 — Flow Rate → Sim_BBD131DX05DIO1PLM4_Ch02PV *)
sim_AHI_Scale_16 (ioPV := sim_BTK2105FT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM4_Ch02PV);

(* BTK2105LT01 — Tank Level → Sim_BBD131DX05DIO1PLM4_Ch03PV *)
sim_AHI_Scale_17 (ioPV := sim_BTK2105LT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM4_Ch03PV);

(* BTK2104FV01ZT01 — Valve Position Feedback → Sim_BBD131DX05DIO1PLM4_Ch04PV *)
sim_AHI_Scale_18 (ioPV := sim_BTK2104FV01ZT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM4_Ch04PV);

(* BTK2105FV01ZT01 — Valve Position Feedback → Sim_BBD131DX05DIO1PLM4_Ch05PV *)
sim_AHI_Scale_19 (ioPV := sim_BTK2105FV01ZT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM4_Ch05PV);

(* BPP2104FV01ZT01 — Valve Position Feedback → Sim_BBD131DX05DIO1PLM4_Ch06PV *)
sim_AHI_Scale_20 (ioPV := sim_BPP2104FV01ZT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM4_Ch06PV);

(* BPP2104PT01 — Discharge Pressure → Sim_BBD131DX05DIO1PLM5_Ch00PV *)
sim_AHI_Scale_21 (ioPV := sim_BPP2104PT01_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM5_Ch00PV);

(* BPP2105PT02 — Discharge Pressure → Sim_BBD131DX05DIO1PLM5_Ch01PV *)
sim_AHI_Scale_22 (ioPV := sim_BPP2105PT02_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM5_Ch01PV);

(* BPP2104FIT06FT06 — Flow Rate → Sim_BBD131DX05DIO1PLM5_Ch02PV *)
sim_AHI_Scale_23 (ioPV := sim_BPP2104FIT06FT06_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM5_Ch02PV);

(* BPP2104FIT05FT05 — Flow Rate → Sim_BBD131DX05DIO1PLM5_Ch03PV *)
sim_AHI_Scale_24 (ioPV := sim_BPP2104FIT05FT05_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM5_Ch03PV);

(* BPP2104PIT03PT03 — Discharge Pressure → Sim_BBD131DX05DIO1PLM5_Ch04PV *)
sim_AHI_Scale_25 (ioPV := sim_BPP2104PIT03PT03_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM5_Ch04PV);

(* BPP2104PIT04PT04 — Discharge Pressure → Sim_BBD131DX05DIO1PLM5_Ch05PV *)
sim_AHI_Scale_26 (ioPV := sim_BPP2104PIT04PT04_PV,
                 iMax := 250.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 250.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM5_Ch05PV);

(* BBD131FIT03FT03 — Flow Rate → Sim_BBD131DX05DIO1PLM5_Ch07PV *)
sim_AHI_Scale_27 (ioPV := sim_BBD131FIT03FT03_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BBD131DX05DIO1PLM5_Ch07PV);

(* BCV131SM01LIT01 — Level Indicating Transmitter -  Level → Sim_BCV131DX06DIO1PLM4_Ch00PV *)
sim_AHI_Scale_28 (ioPV := sim_BCV131SM01LIT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM4_Ch00PV);

(* BCV131APP02FT01 — Oil Flow Transmitter → Sim_BCV131DX06DIO1PLM4_Ch01PV *)
sim_AHI_Scale_29 (ioPV := sim_BCV131APP02FT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM4_Ch01PV);

(* BCV131BPP02FT01 — Oil Flow Transmitter → Sim_BCV131DX06DIO1PLM4_Ch02PV *)
sim_AHI_Scale_30 (ioPV := sim_BCV131BPP02FT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM4_Ch02PV);

(* BCV131ARTD01 — Motor 1 Red Winding 1 Temperature → Sim_BCV131DX06DIO1PLM5_Ch00PV *)
sim_AHI_Scale_31 (ioPV := sim_BCV131ARTD01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM5_Ch00PV);

(* BCV131ARTD02 — Motor 1 White Winding 1 Temperature → Sim_BCV131DX06DIO1PLM5_Ch01PV *)
sim_AHI_Scale_32 (ioPV := sim_BCV131ARTD02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM5_Ch01PV);

(* BCV131ARTD03 — Motor 1 Blue Winding 1 Temperature → Sim_BCV131DX06DIO1PLM5_Ch02PV *)
sim_AHI_Scale_33 (ioPV := sim_BCV131ARTD03_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM5_Ch02PV);

(* BCV131ARTD04 — Motor 1 Red Winding 2 Temperature → Sim_BCV131DX06DIO1PLM5_Ch03PV *)
sim_AHI_Scale_34 (ioPV := sim_BCV131ARTD04_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM5_Ch03PV);

(* BCV131ARTD05 — Motor 1 White Winding 2 Temperature → Sim_BCV131DX06DIO1PLM5_Ch04PV *)
sim_AHI_Scale_35 (ioPV := sim_BCV131ARTD05_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM5_Ch04PV);

(* BCV131ARTD06 — Motor 1 Blue Winding 2 Temperature → Sim_BCV131DX06DIO1PLM5_Ch05PV *)
sim_AHI_Scale_36 (ioPV := sim_BCV131ARTD06_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM5_Ch05PV);

(* BCV131ARTD07 — Motor 1 Non Drive End Bearing Temperature → Sim_BCV131DX06DIO1PLM5_Ch06PV *)
sim_AHI_Scale_37 (ioPV := sim_BCV131ARTD07_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM5_Ch06PV);

(* BCV131ARTD08 — Motor 1 Drive End Bearing Temperature → Sim_BCV131DX06DIO1PLM5_Ch07PV *)
sim_AHI_Scale_38 (ioPV := sim_BCV131ARTD08_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM5_Ch07PV);

(* BCV131ARTD09 — Motor 1 Air Inlet Ambient Temperature → Sim_BCV131DX06DIO1PLM6_Ch00PV *)
sim_AHI_Scale_39 (ioPV := sim_BCV131ARTD09_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM6_Ch00PV);

(* BCV131AGB01RTD01 — Gearbox 1 Drive End Bearing Temperature → Sim_BCV131DX06DIO1PLM6_Ch01PV *)
sim_AHI_Scale_40 (ioPV := sim_BCV131AGB01RTD01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM6_Ch01PV);

(* BCV131AGB01RTD02 — Gearbox 1 Oil Temperature → Sim_BCV131DX06DIO1PLM6_Ch02PV *)
sim_AHI_Scale_41 (ioPV := sim_BCV131AGB01RTD02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM6_Ch02PV);

(* BCV131BRTD01 — Motor 2 Red Winding 1 Temperature → Sim_BCV131DX06DIO1PLM7_Ch00PV *)
sim_AHI_Scale_42 (ioPV := sim_BCV131BRTD01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM7_Ch00PV);

(* BCV131BRTD02 — Motor 2 White Winding 1 Temperature → Sim_BCV131DX06DIO1PLM7_Ch01PV *)
sim_AHI_Scale_43 (ioPV := sim_BCV131BRTD02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM7_Ch01PV);

(* BCV131BRTD03 — Motor 2 Blue Winding 1 Temperature → Sim_BCV131DX06DIO1PLM7_Ch02PV *)
sim_AHI_Scale_44 (ioPV := sim_BCV131BRTD03_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM7_Ch02PV);

(* BCV131BRTD04 — Motor 2 Red Winding 2 Temperature → Sim_BCV131DX06DIO1PLM7_Ch03PV *)
sim_AHI_Scale_45 (ioPV := sim_BCV131BRTD04_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM7_Ch03PV);

(* BCV131BRTD05 — Motor 2 White Winding 2 Temperature → Sim_BCV131DX06DIO1PLM7_Ch04PV *)
sim_AHI_Scale_46 (ioPV := sim_BCV131BRTD05_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM7_Ch04PV);

(* BCV131BRTD06 — Motor 2 Blue Winding 2 Temperature → Sim_BCV131DX06DIO1PLM7_Ch05PV *)
sim_AHI_Scale_47 (ioPV := sim_BCV131BRTD06_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM7_Ch05PV);

(* BCV131BRTD07 — Motor 2 Non Drive End Bearing Temperature → Sim_BCV131DX06DIO1PLM7_Ch06PV *)
sim_AHI_Scale_48 (ioPV := sim_BCV131BRTD07_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM7_Ch06PV);

(* BCV131BRTD08 — Motor 2 Drive End Bearing Temperature → Sim_BCV131DX06DIO1PLM7_Ch07PV *)
sim_AHI_Scale_49 (ioPV := sim_BCV131BRTD08_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM7_Ch07PV);

(* BCV131BRTD09 — Motor 2 Air Inlet Ambient Temperature → Sim_BCV131DX06DIO1PLM8_Ch00PV *)
sim_AHI_Scale_50 (ioPV := sim_BCV131BRTD09_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM8_Ch00PV);

(* BCV131BGB01RTD01 — Gearbox 2 Drive End Bearing Temperature → Sim_BCV131DX06DIO1PLM8_Ch01PV *)
sim_AHI_Scale_51 (ioPV := sim_BCV131BGB01RTD01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM8_Ch01PV);

(* BCV131BGB01RTD02 — Gearbox 2 Oil Temperature → Sim_BCV131DX06DIO1PLM8_Ch02PV *)
sim_AHI_Scale_52 (ioPV := sim_BCV131BGB01RTD02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX06DIO1PLM8_Ch02PV);

(* BCV131SM02LIT02 — Water Level → Sim_BCV131DX07DIO1PLM4_Ch00PV *)
sim_AHI_Scale_53 (ioPV := sim_BCV131SM02LIT02_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM4_Ch00PV);

(* BCV131CPP02FT01 — OIL FLOW TRANSMITTER → Sim_BCV131DX07DIO1PLM4_Ch01PV *)
sim_AHI_Scale_54 (ioPV := sim_BCV131CPP02FT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM4_Ch01PV);

(* BCV131CRTD01 — Motor 3 Red Winding 1 Temperature → Sim_BCV131DX07DIO1PLM5_Ch00PV *)
sim_AHI_Scale_55 (ioPV := sim_BCV131CRTD01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM5_Ch00PV);

(* BCV131CRTD02 — Motor 3 White Winding 1 Temperature → Sim_BCV131DX07DIO1PLM5_Ch01PV *)
sim_AHI_Scale_56 (ioPV := sim_BCV131CRTD02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM5_Ch01PV);

(* BCV131CRTD03 — Motor 3 Blue Winding 1 Temperature → Sim_BCV131DX07DIO1PLM5_Ch02PV *)
sim_AHI_Scale_57 (ioPV := sim_BCV131CRTD03_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM5_Ch02PV);

(* BCV131CRTD04 — Motor 3 Red Winding 2 Temperature → Sim_BCV131DX07DIO1PLM5_Ch03PV *)
sim_AHI_Scale_58 (ioPV := sim_BCV131CRTD04_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM5_Ch03PV);

(* BCV131CRTD05 — Motor 3 White Winding 2 Temperature → Sim_BCV131DX07DIO1PLM5_Ch04PV *)
sim_AHI_Scale_59 (ioPV := sim_BCV131CRTD05_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM5_Ch04PV);

(* BCV131CRTD06 — Motor 3 Blue Winding 2 Temperature → Sim_BCV131DX07DIO1PLM5_Ch05PV *)
sim_AHI_Scale_60 (ioPV := sim_BCV131CRTD06_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM5_Ch05PV);

(* BCV131CRTD07 — Motor 3 Non Drive End Bearing Temperature → Sim_BCV131DX07DIO1PLM5_Ch06PV *)
sim_AHI_Scale_61 (ioPV := sim_BCV131CRTD07_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM5_Ch06PV);

(* BCV131CRTD08 — Motor 3 Drive End Bearing Temperature → Sim_BCV131DX07DIO1PLM5_Ch07PV *)
sim_AHI_Scale_62 (ioPV := sim_BCV131CRTD08_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM5_Ch07PV);

(* BCV131CRTD09 — Motor 3 Air Inlet Ambient Temperature → Sim_BCV131DX07DIO1PLM6_Ch00PV *)
sim_AHI_Scale_63 (ioPV := sim_BCV131CRTD09_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM6_Ch00PV);

(* BCV131CGB01RTD01 — Gearbox 3 Drive End Bearing Temperature → Sim_BCV131DX07DIO1PLM6_Ch01PV *)
sim_AHI_Scale_64 (ioPV := sim_BCV131CGB01RTD01_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM6_Ch01PV);

(* BCV131CGB01RTD02 — Gearbox 3 Oil Temperature → Sim_BCV131DX07DIO1PLM6_Ch02PV *)
sim_AHI_Scale_65 (ioPV := sim_BCV131CGB01RTD02_PV,
                 iMax := 120.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 120.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX07DIO1PLM6_Ch02PV);

(* BCV131FIT10FT10 — Flow Indicating Transmitter → Sim_BCV131DX08DIO1PLM3_Ch00PV *)
sim_AHI_Scale_66 (ioPV := sim_BCV131FIT10FT10_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX08DIO1PLM3_Ch00PV);

(* BTN130FIT01FT01 — Transfer Tower → Sim_BCV131DX12DIO1PLM4_Ch00PV *)
sim_AHI_Scale_67 (ioPV := sim_BTN130FIT01FT01_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX12DIO1PLM4_Ch00PV);

(* BCV131FIT02FT02 — BCV131 Dust Suppression → Sim_BCV131DX12DIO1PLM4_Ch01PV *)
sim_AHI_Scale_68 (ioPV := sim_BCV131FIT02FT02_PV,
                 iMax := 100.0,
                 iMin := 0.0,
                 iEngMin := 0.0,
                 iEngMax := 100.0,
                 iRand_LL := -0.05,
                 iRand_UL := 0.05,
                 oPVPer => Sim_BCV131DX12DIO1PLM4_Ch01PV);

(* ====================================

     Water addition / dust suppression / spray valves

=======================================*)


sim_BBD131FIT02FT02_PV := (sim_BBD131SV02_PV) * 36.0;  (*aggregate into BBD131FIT02FT02 *)

(*---- BCV131 sprays (1 SV) ----*)
IF BCV131SV07_O THEN
	sim_BCV131SV07_PV := 1.0;  (* nominal spray contribution *)
ELSE
	sim_BCV131SV07_PV := 0.0;
END_IF;

sim_BCV131APP02FT01_PV := (sim_BCV131SV07_PV) * 36.0;  (*aggregate into BCV131APP02FT01 *)


(* ====================================

     Conveyor / tail brake (SIM_Brake)

=======================================*)

(* BCV131BK01 *)
SIM_Brake_0 (iReleaseSV 	:= BCV131BK01SV01_O	,
             iPmpReq 		:= BCV131BK01SV03_O	,
             iBrakePrsSP 	:= 1000.0		,
             iBrakePrsHoldSP 	:= 1050.0		,
             iLiftTime 		:= t#5s			,(* sim faster *)
             iDumpTime 		:= t#5s			,
             iFltMode 		:= sim_BCV131BK01_FltMod	,
             oLft 		=> sim_BCV131BK01PS01_I	,
             oPrsLo 		=> sim_BCV131BK01PS02_I	,
             oBrakePrs 		=> sim_BCV131BK01_Prs_PV	,
	     irst 		:= sim_BCV131BK01_Rst);

sim_BCV131BK01ZS01A_I := sim_BCV131BK01PS01_I;
sim_BCV131BK01ZS02A_I := sim_BCV131BK01PS01_I;
sim_BCV131BK01ZS03A_I := sim_BCV131BK01PS01_I;
sim_BCV131BK01ZS04A_I := sim_BCV131BK01PS01_I;

(* BCV131BK02 *)
SIM_Brake_1 (iReleaseSV 	:= BCV131BK02SV01_O	,
             iPmpReq 		:= BCV131BK02SV03_O	,
             iBrakePrsSP 	:= 1000.0		,
             iBrakePrsHoldSP 	:= 1050.0		,
             iLiftTime 		:= t#5s			,(* sim faster *)
             iDumpTime 		:= t#5s			,
             iFltMode 		:= sim_BCV131BK02_FltMod	,
             oLft 		=> sim_BCV131BK02PS01_I	,
             oPrsLo 		=> sim_BCV131BK02PS02_I	,
             oBrakePrs 		=> sim_BCV131BK02_Prs_PV	,
	     irst 		:= sim_BCV131BK02_Rst);

sim_BCV131BK02ZS01A_I := sim_BCV131BK02PS01_I;
sim_BCV131BK02ZS02A_I := sim_BCV131BK02PS01_I;
sim_BCV131BK02ZS03A_I := sim_BCV131BK02PS01_I;
sim_BCV131BK02ZS04A_I := sim_BCV131BK02PS01_I;

(* ====================================

     Contactor aux (CAX) follows start relay (SR)

=======================================*)

sim_BAF131HT01CAX01_I 	:= BAF131HT01SR01_O;

(* ====================================

     CB Simulation

=======================================*)

(* BAF131HT01 *)
sim_CBSts_0 (ioSetTripped := sim_BAF131HT01TRP01_SetTrp,
             ioReset 	:= sim_BAF131HT01TRP01_SetOK,
             ioSetOpen 	:= sim_BAF131HT01TRP01_SetOpn,
             oClsd 	=> sim_BAF131HT01CB01_I,
             oTrpd 	=> sim_BAF131HT01TRP01_I);

(* BCV131AVS01 *)
sim_CBSts_1 (ioSetTripped := sim_BCV131AVS01TRP01_SetTrp,
             ioReset 	:= sim_BCV131AVS01TRP01_SetOK,
             ioSetOpen 	:= sim_BCV131AVS01TRP01_SetOpn,
             oClsd 	=> sim_BCV131AVS01CB01_I,
             oTrpd 	=> sim_BCV131AVS01TRP01_I);

(* BCV131BVS01 *)
sim_CBSts_2 (ioSetTripped := sim_BCV131BVS01TRP01_SetTrp,
             ioReset 	:= sim_BCV131BVS01TRP01_SetOK,
             ioSetOpen 	:= sim_BCV131BVS01TRP01_SetOpn,
             oClsd 	=> sim_BCV131BVS01CB01_I,
             oTrpd 	=> sim_BCV131BVS01TRP01_I);

(* BCV131CVS01 *)
sim_CBSts_3 (ioSetTripped := sim_BCV131CVS01TRP01_SetTrp,
             ioReset 	:= sim_BCV131CVS01TRP01_SetOK,
             ioSetOpen 	:= sim_BCV131CVS01TRP01_SetOpn,
             oClsd 	=> sim_BCV131CVS01CB01_I,
             oTrpd 	=> sim_BCV131CVS01TRP01_I);

(* BCV131WN01PN01 *)
sim_CBSts_4 (ioSetTripped := sim_BCV131WN01PN01TRP01_SetTrp,
             ioReset 	:= sim_BCV131WN01PN01TRP01_SetOK,
             ioSetOpen 	:= sim_BCV131WN01PN01TRP01_SetOpn,
             oClsd 	=> sim_BCV131WN01PN01CB01_I,
             oTrpd 	=> sim_BCV131WN01PN01TRP01_I);

(* BDU131CP01 *)
sim_CBSts_5 (ioSetTripped := sim_BDU131CP01TRP01_SetTrp,
             ioReset 	:= sim_BDU131CP01TRP01_SetOK,
             ioSetOpen 	:= sim_BDU131CP01TRP01_SetOpn,
             oClsd 	=> sim_BDU131CP01CB01_I,
             oTrpd 	=> sim_BDU131CP01TRP01_I);

(* BPP2104 *)
sim_CBSts_6 (ioSetTripped := sim_BPP2104TRP01_SetTrp,
             ioReset 	:= sim_BPP2104TRP01_SetOK,
             ioSetOpen 	:= sim_BPP2104TRP01_SetOpn,
             oClsd 	=> sim_BPP2104CB01_I,
             oTrpd 	=> sim_BPP2104TRP01_I);

(* BPP2105 *)
sim_CBSts_7 (ioSetTripped := sim_BPP2105TRP01_SetTrp,
             ioReset 	:= sim_BPP2105TRP01_SetOK,
             ioSetOpen 	:= sim_BPP2105TRP01_SetOpn,
             oClsd 	=> sim_BPP2105CB01_I,
             oTrpd 	=> sim_BPP2105TRP01_I);

(* BPQE2106DB01 *)
sim_CBSts_8 (ioSetTripped := sim_BPQE2106DB01TRP01_SetTrp,
             ioReset 	:= sim_BPQE2106DB01TRP01_SetOK,
             ioSetOpen 	:= sim_BPQE2106DB01TRP01_SetOpn,
             oClsd 	=> sim_BPQE2106DB01CB01_I,
             oTrpd 	=> sim_BPQE2106DB01TRP01_I);

(* BPQE2106PN01 *)
sim_CBSts_9 (ioSetTripped := sim_BPQE2106PN01TRP01_SetTrp,
             ioReset 	:= sim_BPQE2106PN01TRP01_SetOK,
             ioSetOpen 	:= sim_BPQE2106PN01TRP01_SetOpn,
             oClsd 	=> sim_BPQE2106PN01CB01_I,
             oTrpd 	=> sim_BPQE2106PN01TRP01_I);

(* BSR132AC01 *)
sim_CBSts_10 (ioSetTripped := sim_BSR132AC01TRP01_SetTrp,
             ioReset 	:= sim_BSR132AC01TRP01_SetOK,
             ioSetOpen 	:= sim_BSR132AC01TRP01_SetOpn,
             oClsd 	=> sim_BSR132AC01CB01_I,
             oTrpd 	=> sim_BSR132AC01TRP01_I);

(* BSR132AC02 *)
sim_CBSts_11 (ioSetTripped := sim_BSR132AC02TRP01_SetTrp,
             ioReset 	:= sim_BSR132AC02TRP01_SetOK,
             ioSetOpen 	:= sim_BSR132AC02TRP01_SetOpn,
             oClsd 	=> sim_BSR132AC02CB01_I,
             oTrpd 	=> sim_BSR132AC02TRP01_I);

(* BSR132AC03 *)
sim_CBSts_12 (ioSetTripped := sim_BSR132AC03TRP01_SetTrp,
             ioReset 	:= sim_BSR132AC03TRP01_SetOK,
             ioSetOpen 	:= sim_BSR132AC03TRP01_SetOpn,
             oClsd 	=> sim_BSR132AC03CB01_I,
             oTrpd 	=> sim_BSR132AC03TRP01_I);

(* BSR132BC01 *)
sim_CBSts_13 (ioSetTripped := sim_BSR132BC01TRP01_SetTrp,
             ioReset 	:= sim_BSR132BC01TRP01_SetOK,
             ioSetOpen 	:= sim_BSR132BC01TRP01_SetOpn,
             oClsd 	=> sim_BSR132BC01CB01_I,
             oTrpd 	=> sim_BSR132BC01TRP01_I);

(* BSR132BC02 *)
sim_CBSts_14 (ioSetTripped := sim_BSR132BC02TRP01_SetTrp,
             ioReset 	:= sim_BSR132BC02TRP01_SetOK,
             ioSetOpen 	:= sim_BSR132BC02TRP01_SetOpn,
             oClsd 	=> sim_BSR132BC02CB01_I,
             oTrpd 	=> sim_BSR132BC02TRP01_I);

(* BSR132DB01 *)
sim_CBSts_15 (ioSetTripped := sim_BSR132DB01TRP01_SetTrp,
             ioReset 	:= sim_BSR132DB01TRP01_SetOK,
             ioSetOpen 	:= sim_BSR132DB01TRP01_SetOpn,
             oClsd 	=> sim_BSR132DB01CB01_I,
             oTrpd 	=> sim_BSR132DB01TRP01_I);

(* BSR132DB02 *)
sim_CBSts_16 (ioSetTripped := sim_BSR132DB02TRP01_SetTrp,
             ioReset 	:= sim_BSR132DB02TRP01_SetOK,
             ioSetOpen 	:= sim_BSR132DB02TRP01_SetOpn,
             oClsd 	=> sim_BSR132DB02CB01_I,
             oTrpd 	=> sim_BSR132DB02TRP01_I);

(* BSR132DB03 *)
sim_CBSts_17 (ioSetTripped := sim_BSR132DB03TRP01_SetTrp,
             ioReset 	:= sim_BSR132DB03TRP01_SetOK,
             ioSetOpen 	:= sim_BSR132DB03TRP01_SetOpn,
             oClsd 	=> sim_BSR132DB03CB01_I,
             oTrpd 	=> sim_BSR132DB03TRP01_I);

(* BSR132DB04 *)
sim_CBSts_18 (ioSetTripped := sim_BSR132DB04TRP01_SetTrp,
             ioReset 	:= sim_BSR132DB04TRP01_SetOK,
             ioSetOpen 	:= sim_BSR132DB04TRP01_SetOpn,
             oClsd 	=> sim_BSR132DB04CB01_I,
             oTrpd 	=> sim_BSR132DB04TRP01_I);

(* BSR132UP01SW01 *)
sim_CBSts_19 (ioSetTripped := sim_BSR132UP01SW01TRP01_SetTrp,
             ioReset 	:= sim_BSR132UP01SW01TRP01_SetOK,
             ioSetOpen 	:= sim_BSR132UP01SW01TRP01_SetOpn,
             oClsd 	=> sim_BSR132UP01SW01CB01_I,
             oTrpd 	=> sim_BSR132UP01SW01TRP01_I);

(* ====================================

     TeSysT motor starters (SIM_TeSysT)

=======================================*)

(* TeSysT PR sim DI healthy defaults (CB Closed, SY/VAC Healthy, CAX Closed) *)
IF sim_init THEN
	sim_BCV131PP02CB01_I := 1;
	sim_BCV131PP02CAX01_I := 1;
	sim_BCV131PP02SY01_I := 1;
	sim_BCV131PP03CB01_I := 1;
	sim_BCV131PP03CAX01_I := 1;
	sim_BCV131PP03SY01_I := 1;
	sim_BBD131PP01CB01_I := 1;
	sim_BBD131PP01CAX01_I := 1;
	sim_BBD131PP01SY01_I := 1;
	sim_BAF131PP01CB01_I := 1;
	sim_BAF131PP01CAX01_I := 1;
	sim_BAF131PP01SY01_I := 1;
	sim_BAF131PP02CB01_I := 1;
	sim_BAF131PP02CAX01_I := 1;
	sim_BAF131PP02SY01_I := 1;
	sim_BAF131PP04CB01_I := 1;
	sim_BAF131PP04CAX01_I := 1;
	sim_BAF131PP04SY01_I := 1;
	sim_BAF131FN01CB01_I := 1;
	sim_BAF131FN01CAX01_I := 1;
	sim_BAF131FN01SY01_I := 1;
	sim_BDU131FN01CB01_I := 1;
	sim_BDU131FN01CAX01_I := 1;
	sim_BDU131FN01SY01_I := 1;
	sim_BCV131AFN01CB01_I := 1;
	sim_BCV131AFN01CAX01_I := 1;
	sim_BCV131AFN01SY01_I := 1;
	sim_BCV131AFN02CB01_I := 1;
	sim_BCV131AFN02CAX01_I := 1;
	sim_BCV131AFN02SY01_I := 1;
	sim_BCV131AFN03CB01_I := 1;
	sim_BCV131AFN03CAX01_I := 1;
	sim_BCV131AFN03SY01_I := 1;
	sim_BCV131APP02CB01_I := 1;
	sim_BCV131APP02CAX01_I := 1;
	sim_BCV131APP02SY01_I := 1;
	sim_BCV131BFN01CB01_I := 1;
	sim_BCV131BFN01CAX01_I := 1;
	sim_BCV131BFN01SY01_I := 1;
	sim_BCV131BFN02CB01_I := 1;
	sim_BCV131BFN02CAX01_I := 1;
	sim_BCV131BFN02SY01_I := 1;
	sim_BCV131BFN03CB01_I := 1;
	sim_BCV131BFN03CAX01_I := 1;
	sim_BCV131BFN03SY01_I := 1;
	sim_BCV131BPP02CB01_I := 1;
	sim_BCV131BPP02CAX01_I := 1;
	sim_BCV131BPP02SY01_I := 1;
	sim_BCV131CFN01CB01_I := 1;
	sim_BCV131CFN01CAX01_I := 1;
	sim_BCV131CFN01SY01_I := 1;
	sim_BCV131CFN02CB01_I := 1;
	sim_BCV131CFN02CAX01_I := 1;
	sim_BCV131CFN02SY01_I := 1;
	sim_BCV131CFN03CB01_I := 1;
	sim_BCV131CFN03CAX01_I := 1;
	sim_BCV131CFN03SY01_I := 1;
	sim_BCV131CPP02CB01_I := 1;
	sim_BCV131CPP02CAX01_I := 1;
	sim_BCV131CPP02SY01_I := 1;
	sim_BCV131PP04CB01_I := 1;
	sim_BCV131PP04CAX01_I := 1;
	sim_BCV131PP04SY01_I := 1;
	sim_BCV131PP05CB01_I := 1;
	sim_BCV131PP05CAX01_I := 1;
	sim_BCV131PP05SY01_I := 1;
	(* Master IP left 0.0.0.0 unless set by sim_Initialise / HMI *)
END_IF;

(* BCV131PP02 TeSysT → BCV131PP02PR1 *)
SIM_TeSysT_0 (iOutDatDDT := BCV131PP02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131PP02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131PP02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131PP02SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131PP02PR1.Inputs);

(* BCV131PP03 TeSysT → BCV131PP03PR1 *)
SIM_TeSysT_1 (iOutDatDDT := BCV131PP03PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131PP03CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131PP03CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131PP03SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131PP03PR1.Inputs);

(* BBD131PP01 TeSysT → BBD131PP01PR1 *)
SIM_TeSysT_2 (iOutDatDDT := BBD131PP01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BBD131PP01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BBD131PP01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BBD131PP01SY01_I,
               iFltID := 0,
               oInDatDDT => BBD131PP01PR1.Inputs);

(* BAF131PP01 TeSysT → BAF131PP01PR1 *)
SIM_TeSysT_3 (iOutDatDDT := BAF131PP01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF131PP01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF131PP01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF131PP01SY01_I,
               iFltID := 0,
               oInDatDDT => BAF131PP01PR1.Inputs);

(* BAF131PP02 TeSysT → BAF131PP02PR1 *)
SIM_TeSysT_4 (iOutDatDDT := BAF131PP02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF131PP02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF131PP02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF131PP02SY01_I,
               iFltID := 0,
               oInDatDDT => BAF131PP02PR1.Inputs);

(* BAF131PP04 TeSysT → BAF131PP04PR1 *)
SIM_TeSysT_5 (iOutDatDDT := BAF131PP04PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF131PP04CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF131PP04CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF131PP04SY01_I,
               iFltID := 0,
               oInDatDDT => BAF131PP04PR1.Inputs);

(* BAF131FN01 TeSysT → BAF131FN01PR1 *)
SIM_TeSysT_6 (iOutDatDDT := BAF131FN01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BAF131FN01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BAF131FN01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BAF131FN01SY01_I,
               iFltID := 0,
               oInDatDDT => BAF131FN01PR1.Inputs);

(* BDU131FN01 TeSysT → BDU131FN01PR1 *)
SIM_TeSysT_7 (iOutDatDDT := BDU131FN01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BDU131FN01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BDU131FN01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BDU131FN01SY01_I,
               iFltID := 0,
               oInDatDDT => BDU131FN01PR1.Inputs);

(* BCV131AFN01 TeSysT → BCV131AFN01PR1 *)
SIM_TeSysT_8 (iOutDatDDT := BCV131AFN01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131AFN01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131AFN01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131AFN01SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131AFN01PR1.Inputs);

(* BCV131AFN02 TeSysT → BCV131AFN02PR1 *)
SIM_TeSysT_9 (iOutDatDDT := BCV131AFN02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131AFN02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131AFN02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131AFN02SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131AFN02PR1.Inputs);

(* BCV131AFN03 TeSysT → BCV131AFN03PR1 *)
SIM_TeSysT_10 (iOutDatDDT := BCV131AFN03PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131AFN03CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131AFN03CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131AFN03SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131AFN03PR1.Inputs);

(* BCV131APP02 TeSysT → BCV131APP02PR1 *)
SIM_TeSysT_11 (iOutDatDDT := BCV131APP02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131APP02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131APP02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131APP02SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131APP02PR1.Inputs);

(* BCV131BFN01 TeSysT → BCV131BFN01PR1 *)
SIM_TeSysT_12 (iOutDatDDT := BCV131BFN01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131BFN01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131BFN01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131BFN01SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131BFN01PR1.Inputs);

(* BCV131BFN02 TeSysT → BCV131BFN02PR1 *)
SIM_TeSysT_13 (iOutDatDDT := BCV131BFN02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131BFN02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131BFN02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131BFN02SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131BFN02PR1.Inputs);

(* BCV131BFN03 TeSysT → BCV131BFN03PR1 *)
SIM_TeSysT_14 (iOutDatDDT := BCV131BFN03PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131BFN03CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131BFN03CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131BFN03SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131BFN03PR1.Inputs);

(* BCV131BPP02 TeSysT → BCV131BPP02PR1 *)
SIM_TeSysT_15 (iOutDatDDT := BCV131BPP02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131BPP02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131BPP02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131BPP02SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131BPP02PR1.Inputs);

(* BCV131CFN01 TeSysT → BCV131CFN01PR1 *)
SIM_TeSysT_16 (iOutDatDDT := BCV131CFN01PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131CFN01CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131CFN01CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131CFN01SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131CFN01PR1.Inputs);

(* BCV131CFN02 TeSysT → BCV131CFN02PR1 *)
SIM_TeSysT_17 (iOutDatDDT := BCV131CFN02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131CFN02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131CFN02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131CFN02SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131CFN02PR1.Inputs);

(* BCV131CFN03 TeSysT → BCV131CFN03PR1 *)
SIM_TeSysT_18 (iOutDatDDT := BCV131CFN03PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131CFN03CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131CFN03CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131CFN03SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131CFN03PR1.Inputs);

(* BCV131CPP02 TeSysT → BCV131CPP02PR1 *)
SIM_TeSysT_19 (iOutDatDDT := BCV131CPP02PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131CPP02CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131CPP02CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131CPP02SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131CPP02PR1.Inputs);

(* BCV131PP04 TeSysT → BCV131PP04PR1 *)
SIM_TeSysT_20 (iOutDatDDT := BCV131PP04PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131PP04CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131PP04CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131PP04SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131PP04PR1.Inputs);

(* BCV131PP05 TeSysT → BCV131PP05PR1 *)
SIM_TeSysT_21 (iOutDatDDT := BCV131PP05PR1.Outputs,
               iMstIPAdr := sim_TeSysT_MstIP,
               iRun := 0,	(* 0=Sim; 1=Stop; 2=Fwd; 3=Rev *)
               iCB01_Opn := NOT sim_BCV131PP05CB01_I,	(* Open pin ← NOT Closed sim DI *)
               iVAC01_Off := FALSE,
               iCAX01 := BOOL_TO_INT(IN := sim_BCV131PP05CAX01_I),	(* INT from sim CAX DI *)
               iESS01_Off := NOT sim_BCV131PP05SY01_I,
               iFltID := 0,
               oInDatDDT => BCV131PP05PR1.Inputs);

(* ====================================

     Equipment Simulations - END

=======================================*)
