1000 A=100: GOTO 20: REM ## Fraktale ##
1010 GOSUB 100: SR$="Fraktale": VE=0
1020 HO=INT(HO/2)-8: GOSUB 110: GOSUB 150: PRINT: PRINT
1030 PRINT"Zyklen ca.50=";:INPUT Z:CN=0
1040 PRINT"x1";:INPUT X1: PRINT"x2";:INPUT X2
1050 PRINT"y1";:INPUT Y1: PRINT"y2";:INPUT Y2
1060 PRINT"Beschleunigung 1-20";:INPUT F:H=F/HG:V=F/VG
1070 XD=(X2-X1)*H: YD=(Y2-Y1)*V: Y=Y1-YD: GOSUB 600
1080 FOR J=0 TO 1-V STEP V: Y=Y+YD: X=X1-XD
1090   FOR I=0 TO 1-H STEP H: X=X+XD:A=.5:B=0:L=1
1100     FOR K=0 TO Z
1110      C=A*A: D=B*B: B=A*B: B=B+B-Y: A=C-D-X
1120      IF C+D>100 THEN L=K/2: K=Z
1130     NEXT K:IF L=INT(L) THEN HO=I:VE=J:GOSUB 620
1140 NEXT I: NEXT J: GOSUB 250
1150 GOSUB 210: GOTO 950
30000 REM Die Zyklenzahl gibt die Iterationstiefe an.
30010 REM Bei grossen Werten wird lange Zeit benoetigt
30020 REM dafuer ist die Aufloesung hoch
30030 REM Grundwerte x= -1, 2.5; y= -1.5, 1.5
30040 REM Beschleunigung =1 gibt volle Dichte im Bild
30050 REM groessere Werte schneller, weniger dicht
30060 REM ###### Programm dauert sehr lange ######
30070 REM andere Formeln fuer Zeile 1110 in Zeitschrift
30080 REM Spectrum 8/88 Erklaerungen in rfe 2/89
32000 REM H.Voelz, 28.6.89, XT-Compatible
