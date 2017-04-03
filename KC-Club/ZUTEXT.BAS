1000 A=100:GOTO 20:REM ### ZUTEXT ###
1010 HT=HO:VT=VE
1020 FOR X=1 TO 200
1030 GOSUB 260:HO=RV*HT:GOSUB 260:VE=RV*VT
1040 GOSUB 110:GOSUB 260:PRINT CHR$(32+RV*95);
1050 NEXT X
1060 HO=0:VE=0:GOSUB 110
1070 INPUT"0=Ende 1=weiter";Z
1080 IF Z=1 THEN GOSUB 100:GOTO 1020
1090 GOTO 950
1100 REM ----Programm-Ende------
30000 REM Es werden Zufallszeichen an zufaellige
30010 REM Bildschirmpositionen gelegt. Beobachten
30020 REM Sie das entstehende Muster und
30030 REM eventuell sich ausbildende Texte.
32000 REM -----------------------
32010 REM H. Voelz; 9.5.89; 24.8.89 fuer Rundfunk
32020 REM XT-compatibler Rechner
