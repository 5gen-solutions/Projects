# BS1_Citect_v7 – summary

## 1. SCADA Tags – Eng Unit / Format from tag comments

Base: Tim's `BS1_Citect_v6_TJS.xlsm` (17/10/2026 7:04 AM). Sheets changed: SCADA Tags, SCADA Alarms, SCADA Trends (+ styles.xml, workbook.xml calcPr fullCalcOnLoad=1) (calcChain removed so Excel rebuilds it); changed cells red; scaling untouched; digital tags untouched; nothing Tim changed vs v6 was reverted.

Unit read from a trailing “(unit)” in the comment, else from one unambiguous keyword (Temperature→C, Frequency/Hz→Hz, Voltage→V, Current→A, kW, kVAR, kVA, mA, rpm, seconds/minutes/hours on time quantities). Comments that look like IDs/status/codes/modes are ignored. Format = Tim's most common Format for that unit (default `#.# EU`).

## Cells written: Eng Unit 1108, Format 1096 (rows 1108)
### Eng Unit filled (blank before), by unit
- %: 287
- A: 269
- C: 197
- mA: 96
- V: 58
- Hz: 52
- s: 50
- kW: 21
- rpm: 14
- kV: 12
- ms: 7
- min: 7
- t/h: 6
- m/s: 6
- bar: 5
- mm: 4
- m3/h: 3
- L/s: 3
- kVAR: 3
- L/min: 2
- t: 1
- kPa: 1
### Format filled where Eng Unit already matched the comment
### Format convention used
- % → `#.# EU`
- A → `#.# EU`
- C → `#.# EU`
- Hz → `#.# EU`
- L/min → `#.# EU`
- L/s → `#.# EU`
- V → `#.# EU`
- bar → `#.# EU`
- kPa → `# EU`
- kV → `#.# EU`
- kVAR → `#.# EU`
- kW → `#.# EU`
- m/s → `#.# EU`
- m3/h → `# EU`
- mA → `#.# EU`
- min → `#.# EU`
- mm → `## EU`
- ms → `# EU`
- rpm → `#`
- s → `#.# EU`
- t → `#.# EU`
- t/h → `#.# EU`

## Corrections – existing Eng Unit contradicted an explicit “(unit)” in the comment: 4
- row 7225 `BSR132BC02CordexDAT1_Phs1V`: 'A' → 'V' (Format '#.# EU') – “BSR132BC02 Battery Charger Cordex DDT Estimated AC Phase 1 Voltage (V)”
- row 7226 `BSR132BC02CordexDAT1_Phs2V`: 'min' → 'V' (Format '#.# EU') – “BSR132BC02 Battery Charger Cordex DDT Estimated AC Phase 2 Voltage (V)”
- row 7227 `BSR132BC02CordexDAT1_Phs3V`: 'C' → 'V' (Format '#.# EU') – “BSR132BC02 Battery Charger Cordex DDT Estimated AC Phase 3 Voltage (V)”
- row 7228 `BSR132BC02CordexDAT1_CapRqd`: 'V' → '%' (Format '#.# EU') – “BSR132BC02 Battery Charger Cordex DDT Estimated Required Capacity (%)”

## Skipped
- existing Eng Unit differs, comment not explicit (kept): 109
- scaled/placeholder unit in comment (x.xxxx): 48
- scaled/placeholder unit in comment (x 0.1 kW): 48
- scaled/placeholder unit in comment (x 0.01): 48
- scaled/placeholder unit in comment (x 0.1 kVAR): 48
- scaled/placeholder unit in comment (u): 18
- scaled/placeholder unit in comment (Unused): 1

### Existing Eng Unit differs but comment not explicit (left alone)
- `BMC1301INC01PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC1301INC01 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC1301INC01PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC1301INC01 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC1301INC01PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC1301INC01 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC1301INC01PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC1301INC01 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC1301INC01PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC1301INC01 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC1301INC01PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC1301INC01 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC1301INC01PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC1301INC01 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC1301INC01PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC1301INC01 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC1301INC01PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC1301INC01 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC1302INC01PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC1302INC01 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC1302INC01PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC1302INC01 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC1302INC01PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC1302INC01 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC1302INC01PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC1302INC01 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC1302INC01PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC1302INC01 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC1302INC01PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC1302INC01 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC1302INC01PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC1302INC01 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC1302INC01PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC1302INC01 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC1302INC01PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC1302INC01 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC1302INC02PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC1302INC02 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC1302INC02PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC1302INC02 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC1302INC02PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC1302INC02 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC1302INC02PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC1302INC02 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC1302INC02PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC1302INC02 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC1302INC02PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC1302INC02 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC1302INC02PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC1302INC02 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC1302INC02PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC1302INC02 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC1302INC02PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC1302INC02 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC1302INC03PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC1302INC03 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC1302INC03PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC1302INC03 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC1302INC03PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC1302INC03 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC1302INC03PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC1302INC03 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC1302INC03PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC1302INC03 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC1302INC03PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC1302INC03 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC1302INC03PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC1302INC03 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC1302INC03PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC1302INC03 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC1302INC03PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC1302INC03 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC802INC01PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC802INC01 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC802INC01PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC802INC01 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC802INC01PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC802INC01 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC802INC01PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC802INC01 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC802INC01PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC802INC01 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC802INC01PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC802INC01 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC802INC01PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC802INC01 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC802INC01PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC802INC01 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC802INC01PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC802INC01 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC802INC02PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC802INC02 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC802INC02PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC802INC02 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC802INC02PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC802INC02 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC802INC02PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC802INC02 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC802INC02PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC802INC02 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC802INC02PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC802INC02 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC802INC02PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC802INC02 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC802INC02PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC802INC02 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC802INC02PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC802INC02 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BSR130BC02CordexDAT1_StgCharge` '%' vs comment 'C' (“BSR130BC02 Battery Charger Cordex Battery Temperature”)
- `BMC1322INC01PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC1322INC01 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC1322INC01PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC1322INC01 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC1322INC01PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC1322INC01 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC1322INC01PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC1322INC01 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC1322INC01PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC1322INC01 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC1322INC01PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC1322INC01 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC1322INC01PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC1322INC01 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC1322INC01PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC1322INC01 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC1322INC01PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC1322INC01 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC1322INC02PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC1322INC02 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC1322INC02PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC1322INC02 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC1322INC02PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC1322INC02 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC1322INC02PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC1322INC02 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC1322INC02PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC1322INC02 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC1322INC02PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC1322INC02 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC1322INC02PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC1322INC02 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC1322INC02PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC1322INC02 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC1322INC02PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC1322INC02 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC1322INC03PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC1322INC03 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC1322INC03PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC1322INC03 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC1322INC03PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC1322INC03 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC1322INC03PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC1322INC03 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC1322INC03PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC1322INC03 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC1322INC03PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC1322INC03 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC1322INC03PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC1322INC03 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC1322INC03PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC1322INC03 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC1322INC03PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC1322INC03 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC131INC02PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC131INC02 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC131INC02PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC131INC02 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC131INC02PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC131INC02 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC131INC02PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC131INC02 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC131INC02PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC131INC02 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC131INC02PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC131INC02 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC131INC02PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC131INC02 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC131INC02PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC131INC02 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC131INC02PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC131INC02 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC131INC03PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC131INC03 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC131INC03PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC131INC03 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC131INC03PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC131INC03 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC131INC03PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC131INC03 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC131INC03PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC131INC03 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC131INC03PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC131INC03 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC131INC03PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC131INC03 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC131INC03PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC131INC03 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC131INC03PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC131INC03 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)
- `BMC131INC01PR1DAT1_VabTHD` '%' vs comment 'V' (“BMC131INC01 Process Incomer MasterPact RMS Phase A to B Voltage Total Harmonic Distortion”)
- `BMC131INC01PR1DAT1_VbcTHD` '%' vs comment 'V' (“BMC131INC01 Process Incomer MasterPact RMS Phase B to C Voltage Total Harmonic Distortion”)
- `BMC131INC01PR1DAT1_VcaTHD` '%' vs comment 'V' (“BMC131INC01 Process Incomer MasterPact RMS Phase C to A Voltage Total Harmonic Distortion”)
- `BMC131INC01PR1DAT1_VanTHD` '%' vs comment 'V' (“BMC131INC01 Process Incomer MasterPact RMS Phase A Voltage Total Harmonic Distortion”)
- `BMC131INC01PR1DAT1_VbnTHD` '%' vs comment 'V' (“BMC131INC01 Process Incomer MasterPact RMS Phase B Voltage Total Harmonic Distortion”)
- `BMC131INC01PR1DAT1_VcnTHD` '%' vs comment 'V' (“BMC131INC01 Process Incomer MasterPact RMS Phase C Voltage Total Harmonic Distortion”)
- `BMC131INC01PR1DAT1_IaTHD` '%' vs comment 'A' (“BMC131INC01 Process Incomer MasterPact RMS Current on Phase A Total Harmonic Distortion”)
- `BMC131INC01PR1DAT1_IbTHD` '%' vs comment 'A' (“BMC131INC01 Process Incomer MasterPact RMS Current on Phase B Total Harmonic Distortion”)
- `BMC131INC01PR1DAT1_IcTHD` '%' vs comment 'A' (“BMC131INC01 Process Incomer MasterPact RMS Current on Phase C Total Harmonic Distortion”)

### Ambiguous comments (several units)

### Current-related comments that are not amps

## 2. SCADA Alarms – Alarm Name = equipment description only
Rule: name = the SCADA Equip comment for the row's Equipment. Applied to names we generated (red, not edited by Tim) and to any name with condition words. Kept: formula names (INDEX to SCADA Equip), names Tim edited vs v6, and Tim's own names that already only describe equipment.

- set to equipment description: 3141
- Tim's own name, equipment-only – kept: 1041
- already equals equipment description: 470
- formula (already equipment description) – kept: 137
- Tim edited vs v6 – kept: 22

Only one name had a condition-like word: `BCV130VS01CB04_A` "BCV130 VSD Trip Supply". "Trip Supply" is part of the equipment description ("BCV130 Conveyor VSD Trip Supply"), so it was treated as equipment wording and nothing was moved to the desc. Every alarm Equipment has a SCADA Equip description, so there were no gaps.

## 3. SCADA Alarms – Alarm Desc minus Alarm Name overlap (all rows, hidden included)
Removes the leading words/codes of the desc that repeat the (new) name: case-insensitive, Conv=Conveyor etc., "Drive No. 1" = "Drive A", equipment codes anywhere. Also removes a short alternative equipment wording before a matched run when only the condition follows (e.g. "Discharge Conveyor Motor Cooling Fan Auto Running" → "Auto Running"). Interlock kept. Original spacing/punctuation is kept.

- descs changed: 1335
- of which shortened to the shortest meaningful form (full removal would leave nothing/just a condition code): 269
- left unchanged because nothing meaningful would remain: 12

### Examples (name before → after | desc before → after)
- `BCV130PP04CAX01_FTO_A`: BCV130PP04 Main Contactor → **BCV130 Conveyor Drive Gearbox Auxillary Lubrication Pump Main Contactor** | Drive Gearbox Auxillary Lubrication Pump Fail to Open → **Fail to Open**
- `NOT_BAF130FN01_LocRunIL`: BAF130FN01 Cooling Fan 1 → **BAF130 Apron Feeder Hydraulic Pack Cooling Fan 1** | HPU Oil Cooling Fan 1 Local Run Interlock → **Local Run Interlock**
- `BCV131CGB01RTD02_HiHi_A`: BCV131C Drive C → **BCV131 Overland Conveyor Drive C Gearbox Oil Temperature** | Overland Conveyor Gearbox Oil Temperature (C) High High → **Oil Temperature (C) High High**
- `NOT_BCV131PWS18_Hty`: BCV131PWS17_32 Pullwire Switches 17-32 → **BCV131 Overland Conveyor Pullwire Switch 18** | Overland Conveyor Pullwire Switch 18 Interlock → **Pullwire Switch 18 Interlock**
- `BSR130BC02_BACSFlt_A`: BSR130BC02BACS BACS Webmanager → **BSR130BC02 BACS Webmanager** | BACS Fault → **Fault**
- `NOT_BCV131PWS09_Hty`: BCV131PWS01_16 Pullwire Switches 1-14 → **BCV131 Overland Conveyor Pullwire Switch 9** | Overland Conveyor Pullwire Switch 09 Interlock → **Pullwire Switch 09 Interlock**
- `NOT_BCV131BDS03_Hty`: BCV131BDS01_16 Belt Drift Switches 1-16 → **BCV131 Overland Conveyor Belt Drift Switch 3** | Overland Conveyor Belt Drift Switch 3 Interlock → **Drift Switch 3 Interlock**
- `BDU130RV01PR1_Flt_A`: BDU130RV01 Rotary Valve → **BDU130 Dust Collector Rotary Valve TeSysT** | Dust Collector Rotary Valve Protection Relay Fault → **Protection Relay Fault**
- `NOT_BCV131PWS71_Hty`: BCV131PWS65_74 Pullwire Switches 33-48 → **BCV131 Overland Conveyor Pullwire Switch 71** | Overland Conveyor Pullwire Switch 71 Interlock → **Pullwire Switch 71 Interlock**
- `NOT_BCV131AFN03STS1_SysOK`: BCV131AFN03 Motor Cooling Fan 2 → **BCV131 Overland Conveyor Drive A Motor Cooling Fan 2** | Motor Cooling Fan 2 Overall Control System Interlock → **Overall Control System Interlock**
- `BTN130PP01PR1_Flt_A`: BTN130PP01 Sump Pump → **Transfer Tower Sump Pump TeSysT** | Transfer Tower Sump Pump Protection Relay Fault → **Protection Relay Fault**
- `NOT_BBN130LUY01_ChFlt_Hty`: BBN130LUY01 Active Level → **BBN130 ROM Bin Level Active Level** | ROM Bin Level Channel Fault → **Channel Fault**

### Desc unchanged (would be empty / bare Interlock)
- `BJC130VS01CB05_A` name "BJC130 Jaw Crusher VSD 24VDC Cubicle Bus Supply" desc "Primary Jaw Crusher Ok"
- `BJC130VS01CB07_A` name "BJC130 Jaw Crusher VSD 110/24VDC Power Supply" desc "Primary Jaw Crusher Ok"
- `NOT_BSTD1106FV03XS01_Hty` name "BSTD1106 LME West Standpipe Flow Valve" desc "Valve Interlock"
- `BBD131PP01LCS01IS01_A` name "Surge Bin Facility Sump Pump Isolator" desc "Isolator"
- `BCV131PP02LCS01IS01_A` name "BCV131 Overland Conveyor Drive Station 1 Sump Pump Isolator" desc "Isolator"
- `BCV131PP03LCS01IS01_A` name "BCV131 Overland Conveyor Drive Station 2 Sump Pump Isolator" desc "Isolator"
- `BSR132FIP01XS01_A` name "Overland Conveyor Switchroom BSR132 Fire Panel" desc "A"
- `BTK2101LT01_Hi_A` name "BS1 NPI Fire Water Tank 1 Tank Level" desc "Hi"
- `BTK2102LT01_Hi_A` name "BS1 NPI Fire Water Tank 2 Tank Level" desc "Hi"
- `NOT_BCV131PP02LCS01IS01_Hty` name "BCV131 Overland Conveyor Drive Station 1 Sump Pump Isolator" desc "Isolator Interlock"
- `NOT_BCV131PP03LCS01IS01_Hty` name "BCV131 Overland Conveyor Drive Station 2 Sump Pump Isolator" desc "Isolator Interlock"
- `NOT_BBD131PP01LCS01IS01_Hty` name "Surge Bin Facility Sump Pump Isolator" desc "Isolator Interlock"

### Shortest-form examples
- `NOT_BAF130ZS05_Hty` "Pan Deflection Switch 1 Interlock" → "Deflection Switch 1 Interlock"
- `NOT_BAF130ZS06_Hty` "Pan Deflection Switch 2 Interlock" → "Deflection Switch 2 Interlock"
- `NOT_BAF130HP01PN01_DatOK` "Hydraulic Power Pack Spider Unit Interlock" → "Spider Unit Interlock"
- `NOT_BAF130PP01CB01_Hty` "Pump/Motor Group 1 Drive Circuit Breaker (Q103) Open" → "Circuit Breaker (Q103) Open"
- `NOT_BAF130PP02CB01_Hty` "Pump/Motor Group 2 Drive Circuit Breaker (Q103) Open" → "Circuit Breaker (Q103) Open"
- `NOT_BDU130FN01CB01_Hty` "Dust Collector Fan Drive Circuit Breaker (Q103) Open" → "Circuit Breaker (Q103) Open"
- `NOT_BDU130RV01CB01_Hty` "Dust Collector Rotary Valve Drive Circuit Breaker (Q103) Open" → "Circuit Breaker (Q103) Open"
- `NOT_BCV130BRS01_Hty` "Primary Crusher Discharge Conveyor Belt Rip Switch 1 Interlock" → "Rip Switch 1 Interlock"
- `NOT_BCV130BRS02_Hty` "Primary Crusher Discharge Conveyor Belt Rip Switch 2 Interlock" → "Rip Switch 2 Interlock"
- `NOT_BCV130BRS03_Hty` "Primary Crusher Discharge Conveyor Belt Rip Switch 3 Interlock" → "Rip Switch 3 Interlock"
- `NOT_BCV130BDS01_Hty` "Primary Crusher Discharge Conveyor Belt Drift Switch 1 Interlock" → "Drift Switch 1 Interlock"
- `NOT_BCV130BDS02_Hty` "Primary Crusher Discharge Conveyor Belt Drift Switch 2 Interlock" → "Drift Switch 2 Interlock"
- `NOT_BCV130BDS03_Hty` "Primary Crusher Discharge Conveyor Belt Drift Switch 3 Interlock" → "Drift Switch 3 Interlock"
- `NOT_BCV130BDS04_Hty` "Primary Crusher Discharge Conveyor Belt Drift Switch 4 Interlock" → "Drift Switch 4 Interlock"
- `NOT_BCV130BDS05_Hty` "Primary Crusher Discharge Conveyor Belt Drift Switch 5 Interlock" → "Drift Switch 5 Interlock"

## 4. SCADA Trends – Eng Units (I) / Format (J)
All trend rows except the header use VLOOKUP formulas into SCADA Tags; no hardcoded units/format were found.
- Cached results refreshed to match the updated SCADA Tags: Eng Units 1003, Format 996. Formulas unchanged, font unchanged.
- 2250 trend rows looked up an EXTERNAL workbook (`'[3]SCADA Tags'`). Their I, J, L and O formulas now point to this workbook's `'SCADA Tags'`, so they follow the updated tags (shown in red).
- workbook.xml calcPr set to fullCalcOnLoad="1", so Excel recalculates everything on open and no stale value can show.
