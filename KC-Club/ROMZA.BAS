1000 A=250: GOTO 20: REM ## ROMZA ##
1010 SR$="ROMZA": HO=INT((HO-LEN(SR$)-6)/2): VE= 0
1020 GOSUB 110: GOSUB 150: PRINT
1030 DIM Z(12), Z$(12): F$="Falsche Eingabe"
1040 FOR I=0 TO 12: READ Z(I), Z$(I): NEXT I
1050 GOTO 1310
1060 REM-----------------------
1070 N$="": INPUT"Arabische Zahl "; N$:IF N$="" THEN RETURN
1080 I=0: N=VAL(N$): N$=""
1090 IF (N<1) OR (N<>INT(N)) THEN PRINT F$: GOTO 1070
1100 IF N>6000 THEN PRINT F$: GOTO 1070
1110 R=N-Z(I): IF R<0 THEN I=I+1: GOTO 1110
1120 IF I>12 THEN PRINT F$: GOTO 1070
1130 N$=N$+Z$(I): N=R
1140 IF R=0 THEN PRINT"roemische Zahl = ";N$: GOTO 1070
1150 GOTO 1110
1160 REM----------------------
1170 SR$="": INPUT"Roemische Zahl ";SR$
1180 IF SR$="" THEN RETURN
1190 A=0: B=1: GOSUB 330
1200 FOR X=LEN(SR$) TO 1 STEP -1: I=0
1210   FOR Y=1 TO 7
1220    IF MID$(SR$,X,1)=MID$("MDCLXVI",Y,1) THEN I=Y:Y=7
1230   NEXT Y
1240  IF I=0 THEN PRINT F$:X=-1: GOTO 1270
1250  C=Z(I+I-2): IF C<B THEN A=A-C: GOTO 1270
1260  A=A+C: B=C
1270 NEXT X
1280 IF X=0 THEN PRINT"arabische Zahl =";A
1290 GOTO 1170
1300 REM------- Main ---------
1310 PRINT:INPUT"1 arabisch <-> roemisch 2 =";A: PRINT
1320 IF (A<1) OR (A>2) THEN PRINT F$:GOTO 1310
1330 ON A GOSUB 1070, 1170: GOTO 1310
25000 REM------------Daten---------------------
25010 DATA 1000,"M",900,"CM",500,"D",400,"CD",100
25020 DATA "C",90,"XC",50,"L",40,"XL",10,"X",9,"IX"
25030 DATA 5,"V",4,"IV",1,"I"
30000 REM ---------Anmerkungen------------------
30010 REM Es erfolgt eine Umrechnung zwischen
30020 REM arabischen und roemischen Zahlen.
30030 REM Dabei werden die wesentlichen Regeln
30040 REM beruecksichtigt. Es sind aber infolge
30050 REM von Vereinfachungen auch einige
30060 REM ungebraeuchliche Bildungen, insbeson-
30070 REM dere fuer die Eingabe roemischer Zahlen
30080 REM moeglich.
32000 REM ---------Autorschaft------------------
32010 REM H.Voelz; 19.7.89 fuer Buch BASICODE
32020 REM Auf IBM-compatiblem Rechner.
