1000 A=100: GOTO 20: REM ## Fraksuch ##
1010 GOSUB 100: SR$="Fraktalsuche": H=HO:V=VE:VE=0
1020 HO=INT(HO/2)-10: GOSUB 110: GOSUB 150: PRINT: PRINT
1030 PRINT"x1";:INPUT X1: PRINT"x2";:INPUT X2
1040 PRINT"y1";:INPUT Y1: PRINT"y2";:INPUT Y2
1050 XD=(X2-X1)/H:YD=(Y2-Y1)/V:Y=Y1-YD
1060 FOR J=0 TO V:Y=Y+YD:X=X1-XD
1070   FOR I=0 TO H: X=X+XD:B=0:A=.5:Z=35
1080     FOR K=65 TO 90: E=A: F=B
1090      C=A*A: D=B*B: B=A*B: B=B+B-Y: A=C-D-X
1100      IF ABS(E-A)+ABS(F-B)<.01 THEN Z=K: K=90
1110      IF C+D>50 THEN Z=K+32: K=90
1120     NEXT K:VE=J:HO=I: GOSUB 110: PRINT CHR$(Z);
1130 NEXT I: NEXT J: GOSUB 250
1140 GOSUB 210: GOTO 950
30000 REM mit diesem Programm sind interessante Gebiete
30010 REM fuer Frakale schnell zu finden. Sie werden
30020 REM mit dem zeichen # dargestellt. Grosse Buchstaben
30030 REM Iterationstiefe bei Konvergenz, kleine bei
30040 REM Divergenz an. a bzw. A entspricht der Tiefe 1
30050 REM z bzw. Z der Tiefe 27
30060 REM Andere Formeln fuer Zeile 1090 in Zeitschrift
30070 REM Spectrum 8/88 Erklaerungen in rfe 2/89
32000 REM H.Voelz, 28.6.89, XT-Compatible
