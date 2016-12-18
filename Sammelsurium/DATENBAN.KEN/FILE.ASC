1000 A=5000:GOTO 20:REM ### FILE ###
1010 M=99:SR$="File-Arbeit":VE=0:DIM A$(M)
1020 HO=INT((HO-LEN(SR$)-6)/2):GOSUB 110:GOSUB 150:PRINT
1030 INPUT"1:File erzeugen 2:File lesen";B
1040 IF B=1 THEN 1070
1050 IF B=2 THEN 1170
1060 PRINT"falsche Eingabe":GOTO 1030
1070 PRINT"Eingabe von Namen: Telefon-Nr."
1080 PRINT"Beenden mit: END"
1090 FOR I=0 TO M
1100 PRINT"Nummer:";I+1;" ";
1110 INPUT A$(I):IF A$(I)="END" THEN N=I:I=M
1120 NEXT I
1130 GOSUB 250:PRINT"speichern des File"
1140 INPUT"Name =";NF$:NF=1:GOSUB 500
1150 FOR I=0 TO N:SR$=A$(I):GOSUB 560:NEXT I
1160 GOSUB 580:GOTO 1210
1170 PRINT"Name =";:NF=0:INPUT NF$:GOSUB 500
1180 FOR I=0 TO M
1190 GOSUB 540:A$(I)=IN$:IF IN$="END" THEN I=M
1200 NEXT I
1210 GOSUB 580:PRINT"Das File kann genutzt werden"
1220 PRINT"gesuchter Anfang des Namens; 0=Ende"
1230 INPUT A$:L=LEN(A$):N=-1:IF A$="0" THEN 950
1240 FOR I=0 TO M
1250 IF LEFT$(A$(I),L)=A$ THEN N=I:I=M
1260 NEXT I
1270 IF N<0 THEN PRINT"nicht vorhanden":GOTO 1220
1280 PRINT A$(N):GOTO 1220
30000 REM ---- Programm-Ende-----
30010 REM Es wird ein Datenfile erzeugt, in welchem
30020 REM gesucht werden kann. Es kann gerettet und
30030 REM geladen werden. Als Beispiel koennen hier
30040 REM Namen und Telefon-Nr. eingegeben werden.
30050 REM Beispiel: "Meyer 27 508 35"
30060 REM Gesucht wird nach dem Anfang der Zeichenkette.
30070 REM z.B. "Mey" oder "M" usw.
32000 REM -----------------------
32010 REM H. Voelz; 11.5.89; 24.8.89 fuer Rundfunk
32020 REM XT-compatibler Rechner
