1000 A=5000: GOTO 20: REM ## POEME ##
1010 SR$="POEME": HO=INT((HO-LEN(SR$)-6)/2): VE=0
1020 GOSUB 110: GOSUB 150: PRINT: A=50
1030 DIM A$(16),B$(3,5),C$(A),D$(A),E$(53),F$(3),G$(3),D(A)
1040 Z=0: U=0: RESTORE
1050 FOR I=0 TO 16: READ A$(I): NEXT I: A=16.4
1060 FOR J=0 TO 5: FOR I=0 TO 3
1070  READ B$(I,J)
1080 NEXT I:NEXT J: B=5.4
1090 FOR I=0 TO 3: READ F$(I): NEXT I
1100 E$(0)="!": E$(1)="?": E$(2)="-"
1110 REM ---- Haupt-Menu -----------
1120 PRINT: PRINT"Auswahl der Moeglichkeiten": PRINT
1130 PRINT"1 Text eingeben"
1140 PRINT"2 Text einlesen"
1150 PRINT"3 Text speichern"
1160 PRINT"4 Gedichte erzeugen"
1170 INPUT"5 Programm beenden";C: IF C=5 THEN 950 
1180 IF (C<1) OR (C>4) THEN PRINT"## Fehler ##": GOTO 1120
1190 ON C GOSUB 1220, 1920, 1830, 1510: GOTO 1120
1200 REM
1210 REM============= Eingaben ================
1220 PRINT:PRINT"Texteigabe wie folgt:": PRINT
1230 PRINT"ein junges Pferd springt"
1240 PRINT"eine treue Frau liebte"
1250 PRINT"ein alter Mann raucht"
1260 PRINT"die bunten Blueten duften"
1270 PRINT"mit <ENTER> beenden": PRINT
1280 A$="": INPUT A$: IF A$="" THEN Z=Z-1: RETURN
1290 A$=A$+"    ": REM Bestimmung des Geschlechts
1300 FOR J=0 TO 3: L=LEN(A$)
1310   FOR I=1 TO L
1320    IF MID$(A$,I,1)=" " THEN K=I:I=L
1330   NEXT I
1340   G$(J)=LEFT$(A$,K-1):A$=RIGHT$(A$,L-K)
1350 NEXT J
1360 IF(G$(0)="ein")AND(RIGHT$(G$(1),2)="es")THEN 1410
1370 IF(G$(0)="eine")AND(RIGHT$(G$(1),1)="e")THEN 1420
1380 IF(G$(0)="ein")AND(RIGHT$(G$(1),2)="er")THEN 1430
1390 IF(G$(0)="die")AND(RIGHT$(G$(1),2)="en")THEN 1440
1400 PRINT"falsche Eingabe": GOTO 1280
1410 X=2: D(Z)=0: GOTO 1460: REM saechlich
1420 X=1: D(Z)=2: GOTO 1460: REM weiblich
1430 X=2: D(Z)=1: GOTO 1460: REM maennlich
1440 X=2: D(Z)=3: REM           plural
1450 IF LEFT$(G$(3),1)=" " THEN 1400 
1460 C$(Z)=LEFT$(G$(1),LEN(G$(1))-X)
1470 D$(Z)=G$(2): E$(Z+3)=G$(3)
1480 Z=Z+1: IF Z<51 THEN 1280 
1490 Z=Z+1: PRINT"Speicher voll": RETURN
1500 REM========= Generierung ==============
1510 SR$="POEM Nr."
1520 U=U+1:PRINT: GOSUB 150 :PRINT U: V=0: F=-1
1530 GOSUB 260:F=F+1: ZZ=INT(Z*RV): X=D(ZZ)
1540 GOSUB 260:IF RV<.6 THEN 1560
1550 GOSUB 260:PRINT A$(A*RV)" ";: REM Hilfswort
1560 GOSUB 260:IF RV<.5 THEN 1580
1570 GOSUB 260:PRINT B$(X,B*RV)" ";: REM Artikel
1580 GOSUB 260:IF RV<.35 THEN 1600
1590 GOSUB 260:PRINT C$(Z*RV);F$(X)" ";: REM Adjektiv
1600 GOSUB 260:IF RV<.1 THEN 1660
1610 IF (RV<.7) OR (F>1) THEN 1650
1620 IF RV<.85 THEN F=F+1: GOTO 1540
1630 IF RV<.9 THEN F=F+1: GOTO 1580
1640 GOSUB 260:PRINT D$(Z*RV);"-";: REM Teil-Substantiv
1650 PRINT D$(ZZ)" ";
1660 GOSUB 260:IF RV<.2 THEN 1720
1670 IF (RV<.35) AND (F<1) THEN PRINT", ";:GOTO 1530
1680 GOSUB 260:T=INT((Z+3)*RV): IF T<3 THEN 1710
1690 IF (X<3) AND (D(T-3)=3) THEN 1680
1700 IF (X=3) AND (D(T-3)<3) THEN 1680
1710 PRINT E$(T)" ";
1720 GOSUB 260:IF RV<.6 THEN 1750
1730 IF (RV<.7) AND (F<2) THEN 1530
1740 GOSUB 260:PRINT C$(Z*RV)" ";
1750 PRINT:F=-1: V=V+1: IF V>21 THEN 1780
1760 GOSUB 260:IF RV<.25 THEN F=-1: V=V+1: PRINT
1770 IF (RV<.95) AND (F<2) AND (V<20) THEN 1530
1780 PRINT: INPUT "0=weiter 1=Ende ";C
1790 IF C=0 THEN 1520
1800 RETURN
1810 REM
1820 REM ======= Retten der Daten =======
1830 INPUT"Name des File =";NF$: NF=1: GOSUB 500
1840 SR=Z: GOSUB 300: GOSUB 560
1850 FOR I=0 TO Z
1860  SR$=C$(I): GOSUB 560: SR$=D$(I): GOSUB 560
1870  SR$=E$(I+3): GOSUB 560: SR=A(I): GOSUB 300: GOSUB 560
1880 NEXT I
1890 GOSUB 580: RETURN 
1900 REM
1910 REM ======= Lesen von Daten =======
1920 INPUT"Name des File =";NF$: NF=0: GOSUB 500
1930 GOSUB 540 Z=VAL(IN$)
1940 FOR I=0 TO Z
1950  GOSUB 540: C$(I)=IN$: GOSUB 540: D$(I)=IN$
1960  GOSUB 540: E$(I+3)=IN$: GOSUB 540: A(I)=VAL(IN$)
1970 NEXT I
1980 GOSUB 580: RETURN 
25000 REM ====== Zusatzdaten =========
25010 DATA "also","und","als","oder","auch","sogar"
25020 DATA "dann","bald","heute","gestern","so"
25030 DATA "weil","dennoch","aber","doch","noch"
25040 DATA "morgen","ein","sehr","die","die","kein"
25050 DATA "ein","eine","an","ohne","kein","keine"
25060 DATA "mit","durch","manch","jene","unter"
25070 DATA "dieses","solch","diese","diese","fuer"
25080 DATA "mein","ohne","keine","es","er","e","en"
30000 REM ----- Anmerkungen --------
30010 REM Es werden Zufallsgedichte in freier Prosa
30020 REM erzeugt. Dabei wird eine kleine Grammatik
30030 REM verwendet. Deshalb ist die streng definierte
30040 REM Eingabe notwendig: Bei Singular ist mit
30050 REM "eine" "eine" bzw. "ein" und bei Plural
30060 REM mit "die" zu beginnen. Nur ein Space!
30070 REM Die Felder bedeuten:
30080 REM A$(16) Sonderwoerter wie also, und, als ..
30090 REM B$(3,5) Artikel und aehnliches
30100 REM C$(50) Adjektive ohne Endung
30110 REM D$(50) Substantive, D(50) Geschlecht
30120 REM = 0 saechl.; 1 maennl.; 2 weibl.; 3 plural
30130 REM E$(53) Verben und 0="!"; 1="?"; 2="-"
30140 REM F$(3) Endungen es, er, e, en
30150 REM A$ und G$(3) Eingabewandlungen
30160 REM U=Gedicht-Nr.; V=Zeilenzaehler
30170 REM Z=Satzzaehler: A=16.5; B=5.5
30180 REM ZZ fuer Substantiv, X= Geschlecht
32000 REM ------ Autorschaft ---------
32010 REM H. Voelz; 22.7.89; fuer Buch BASICODE
32020 REM Auf IBM-compatiblem
