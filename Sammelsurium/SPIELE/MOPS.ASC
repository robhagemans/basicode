1000 A=1000:GOTO 20:REM ## MOPS ##
1010 SR$="MOPS":HO=INT((HO-LEN(SR$)-6)/2):VE=0
1020 GOSUB 110:GOSUB 150:PRINT
1030 F$="falsche Eingabe"
1040 DIM A(8),B(8),C$(8),D$(2),E$(2),F$(2)
1050 D$(0)="DER":D$(1)="DAS":D$(2)="DIE"
1060 E$(0)="DEM":E$(1)="DEM":E$(2)="DER"
1070 F$(0)="DEN":F$(1)="DAS":F$(2)="DIE"
1080 FOR I=0 TO 8
1090 INPUT"Wort mit Artikel";S$
1100 IF MID$(S$,4,1)<>" " THEN PRINT F$:GOTO 1090
1110 SR$=LEFT$(S$,3):GOSUB 330
1120 IF SR$="DER" THEN A(I)=0:GOTO 1160
1130 IF SR$="DAS" THEN A(I)=1:GOTO 1160
1140 IF SR$="DIE" THEN A(I)=2:GOTO 1160
1150 PRINT F$:GOTO 1090
1160 SR$=MID$(S$,4):GOSUB 330:C$(I)=SR$
1170 NEXT I:GOSUB 100
1180 FOR I=0 TO 8
1190 GOSUB 260:X=INT(8*RV+.5)
1200 C=0:IF I=0 THEN B(I)=X:GOTO 1250
1210 FOR J=0 TO I-1
1220 IF B(J)=X THEN C=1:J=I
1230 NEXT J:IF C=1 THEN 1190
1240 B(I)=X
1250 NEXT I
1260 PRINT"WENN ";D$(A(B(0)));C$(B(0));
1270 PRINT" MIT ";E$(A(B(1)));C$(B(1))
1280 PRINT"  UEBER ";F$(A(B(2)));C$(B(2));" SPRINGT"
1290 PRINT"UND ";D$(A(B(3)));C$(B(3));
1300 PRINT" IN ";E$(A(B(4)));C$(B(4))
1310 PRINT"  ";F$(A(B(5)));C$(B(5));" VERSCHLINGT"
1320 PRINT"DANN ";D$(A(B(6)));C$(B(6));
1330 PRINT" AUS ";E$(A(B(7)));C$(B(7))
1340 PRINT"  ALS";C$(B(8));" ERKLINGT"
1350 INPUT"0 weiter 1 Ende ";A$:IF A$="0" THEN 1180
1360 GOTO 950
30000 REM -----------Anmerkungen------------
30010 REM Dieses Programm wurde fuer den Rundfunk
30020 REM zum Lehrgang "BASIC 1*1 des Programmierens"
30030 REM auf der Grundlage des Gedichts von Carl
30040 REM Reinhardt "Wenn der Mops mit der Wurst
30050 REM uebern Spucknapf springt" entwickelt.
30060 REM Da es viel Freunde gefunden hat, wurde
30070 REM hier auf BASICODE angepasst.
30080 REM Beispiel einer Eingabe "der Hund"
32000 REM ----------Autorschaft-------------
32010 REM H.Voelz; 11.7.89; 24.8.89; fuer Buch BASICODE
32020 REM Auf IBM-compatiblem Rechner
