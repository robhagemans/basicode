1000 A=5000:GOTO 20:REM ### BUBBLE ###
1010 SR$="Einfacher Bubble-Sort":VE=0:M=21
1020 HO=INT((HO-LEN(SR$)-6)/2):GOSUB 110:GOSUB 150:PRINT
1030 PRINT:PRINT"bitte etwas warten"
1040 DIM A$(M),B$(M),A(M)
1050 FOR I=0 TO M
1060 GOSUB 260:N=INT(10*RV)+3:SR$=""
1070 FOR J=0 TO N
1080 GOSUB 260:IF RV<.5 THEN X=ASC("A")+RV*52
1090 IF RV>=.5 THEN X=ASC("a")+(RV-.5)*52
1100 SR$=SR$+CHR$(X)
1110 NEXT J
1120 A(I)=I:A$(I)=SR$:GOSUB 330:B$(I)=SR$
1130 NEXT I
1140 GOSUB 250:PRINT "Dies sind die Woerter:"
1150 FOR I=0 TO M:PRINT A$(I),B$(I):NEXT I
1160 PRINT"Nun wird sortiert :";
1170 FOR I=0 TO M:F=0
1180 FOR J=0 TO M-1-I
1190 IF B$(A(J))<=B$(A(J+1)) THEN 1210
1200 B=A(J):A(J)=A(J+1):A(J+1)=B:F=1
1210 NEXT J
1220 PRINT I;:IF F=0 THEN I=M
1230 NEXT I
1240 PRINT:GOSUB 250:PRINT "sortierte Woerter"
1250 FOR I=0 TO M:PRINT A$(A(I)):NEXT I
1260 GOSUB 210:GOTO 950
30000 REM -------------------------------------------
30010 REM Es wird der indirekte Bubble-Sort verwendet.
30020 REM Zur Vermeidung von garbage collection wird
30030 REM der Vergleich und Austausch ueber das Feld
30040 REM A(I) realisiert. Weiter werden die Woerter
30050 REM mit Grossbuchstaben in B$(I) abgelegt.
30060 REM Nach der Erzeugung werden beide Worttypen
30070 REM nebeneinander angezeigt.
32000 REM -------------------------------------------
32010 REM H. Voelz; 11.5.89; 24.8.89
32020 REM XT-compatibler Rechner
