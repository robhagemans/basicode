1000 A=100: GOTO 20: REM ### TEXTUM ###
1010 HT=HO: VT=VE: RESTORE
1020 FOR I=1 TO 4: READ A$: PRINT A$: NEXT I
1030 INPUT"Taste druecken"; A: GOSUB 100
1040 FOR X=1 TO 200
1050   GOSUB 260: HO=RV*HT: GOSUB 260: VE=RV*VT
1060   GOSUB 110: GOSUB 260: PRINT CHR$(32+RV*95);
1070 NEXT X
1080 HO=0: VE=0: GOSUB 110
1090 GOSUB 250: PRINT "Text zusammenfassen": BH=0: BE=1
1100 FOR VE=1 TO VT
1110   FOR HO=0 TO HT
1120      GOSUB 220: IF IN=32 THEN 1170
1130      BO=HO: HO=BH: BV=VE: VE=BE: GOSUB 110
1140      PRINT CHR$(IN);
1150      HO=BO: VE=BV: GOSUB 110
1160      BH=BH+1: IF BH=HT THEN BH=0: BE=BE+1
1170    NEXT HO
1180 NEXT VE
1190 GOSUB 250: HO=0: VE=BV+1
1200 GOSUB 110: PRINT "Ich bin fertig";
1210 GOSUB 210: GOTO 950
1220 REM ----Programm-Ende------
25000 DATA "Der Commodore verfuegt ueber einen"
25010 DATA "vom ASCII-Code abweichenden Zeichen-"
25020 DATA "satz. Daher funktioniert dieses "
25030 DATA "Programm bei ihm abweichend !"
30000 REM -----------------------
30010 REM Es werden Zufallsbuchstaben an zufaellige
30020 REM Bildschirmpositionen gelegt. Dann werden
30030 REM sie vom Bildschirm zurueckgelesen und
30040 REM hintereinander ausgegeben. Dabei werden
30050 REM Klein- in Grossbuchstaben gewandelt.
32000 REM -----------------------
32010 REM H. Voelz; 9.5.89; fuer Rundfunk
32020 REM XT-compatibler Rechner
