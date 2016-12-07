1000 A=1000:GOTO 20:REM "INVUL-2"
1010 DIM NR(201),DT(201),ZI$(10),ZL(10),IV$(10),TG(10):N=0
1020 N=N+1:READ A$
1030 IF A$<>"*" THEN 1020
1040 MX=N
1050 GOSUB 100:HO=2:VE=7:GOSUB 110
1060 PRINT "VUL IN: ";:GOSUB 1860
1070 HO=2:VE=9:GOSUB 110
1080 PRINT "(na 1 letter een spatie meetikken)"
1090 HZ=0:VZ=12:HG=7:VG=16:HF=24
1100 HO=0:VE=VG:GOSUB 110
1110 PRINT "  GOED 0           FOUT 0    ";
1120 RESTORE :FO=0:GO=0:TT=0:GOSUB 1590
1130 REM --- een zin uit DATA halen --
1140 TT=TT+1:IF TT=MX THEN GOSUB 1780:GOTO 1050
1150 RESTORE :FOR N=1 TO NR(TT):READ A$:NEXT N
1160 REM --- de zin ontleden ---
1170 LA=LEN(A$):N=0:S=0:B=1
1180 N=N+1:IF N=LA+1 THEN 1260
1190 E$=MID$(A$,N,1):IF (E$<>"-") AND(E$<>"=") THEN 1180
1200 E=1:TG(S)=1:IF E$="=" THEN E=2:TG(S)=0
1210 ZL(S)=N-B:IV$(S)=MID$(A$,N+1,E)
1211 IV$(S)=LEFT$(IV$(S)+"  ",2)
1220 ZI$(S)=MID$(A$,B,N-B)
1230 B=N+E+1
1240 S=S+1
1250 GOTO 1180
1260 ZI$(S)=MID$(A$,B,N-B):ZL(S)=(N-B)
1270 REM --- ontleden klaar! ---
1280 :
1290 HZ=0
1300 REM --- invulroutine ---
1310 FOR M=0 TO S-1
1320 REM --- vorige zin wissen ---
1330 HO=HZ:VE=VZ:GOSUB 110
1340 PRINT "                                       ";
1350 GOSUB 110
1360 REM --- nieuwe zin printen ---
1370 PRINT ZI$(M);:HZ=HZ+ZL(M):HO=HZ:GOSUB 110
1380 FOR N=M+1 TO S:PRINT "--";ZI$(N);
1390 NEXT N:PRINT " ";:GOSUB 110
1400 REM --- invulletters intoetsen --
1410 GOSUB 210:IF ASC(IN$)<33 THEN 1410
1420 PRINT IN$;:D$=IN$
1430 GOSUB 210:IF ASC(IN$)<32 THEN 1430
1440 PRINT IN$;:D$=D$+IN$
1450 REM --- vergelijken ---
1460 IF D$=IV$(M) THEN HZ=HZ+2-TG(M):GOTO 1510
1470 REM --- invoer was fout ---
1480 FO=FO+1:GOSUB 1720:GOSUB 110
1490 PRINT "--";:GOSUB 110:GOTO 1410
1500 REM --- invoer was goed ---
1510 GO=GO+1
1520 GOSUB 1720
1530 NEXT M
1540 HO=HZ:VE=VZ:GOSUB 110
1550 PRINT ZI$(M);" ";
1560 GOSUB 1680
1570 GOTO 1140
1575 :
1580 REM === DATA NRS SCHUDDEN ===
1590 FOR N=1 TO MX:DT(N)=N:NEXT N
1600 FOR N=MX-1 TO 2 STEP -1
1610 GOSUB 260:X=1+INT(RV*N)
1620 NR(N)=DT(X)
1630 FOR M=X TO N-1:DT(M)=DT(M+1)
1640 NEXT M:NEXT N
1650 NR(1)=DT(1)
1660 RETURN
1670 :
1680 REM === WACHTLUS NA DE ZIN ===
1690 FOR W=1 TO 1000:NEXT W
1700 RETURN
1710 :
1720 REM === PRINT DE SCORE ===
1730 HO=HG:VE=VG:GOSUB 110:PRINT ;GO
1740 HO=HF:GOSUB 110:PRINT ;FO
1750 HO=HZ:VE=VZ:GOSUB 110
1760 RETURN
1770 :
1780 REM === EINDE VAN EEN SERIE ===
1790 HO=2:VE=20:GOSUB 110:IF FO=0 THEN PRINT "GOED GEDAAN! ";
1800 PRINT " - NOG 'N KEER?";
1810 GOSUB 210:IF (IN$="N") OR(IN$="n") THEN END
1820 IF (IN$<>"J") AND(IN$<>"j") THEN 1810
1830 GOSUB 110:PRINT "                          ";:HO=0:VE=VZ
1832 GOSUB 110
1835 PRINT "  EVEN GEDULD                           ";
1840 RETURN
1850 REM ================================
1860 REM === DATA KOPREGEL === <<<<<<
1870 PRINT "d , t , dd of tt"
1880 RETURN
1890 REM >> AANPASSEN AAN DE OPGAVE <<
1900 REM ================================
25000 DATA "Het verbran-de huis wor=dt herbouw-d."
25010 DATA "De man verbran=dde de dode takken."
25020 DATA "De bal belan=dde in de sloo-t."
25030 DATA "Wor=dt de tekst nu verander-d?"
25040 DATA "De ingevul-de lijsten zijn verzamel-d."
25050 DATA "De voetbalwedstrijd wor=dt afgelas-t."
25060 DATA "De fiscus belas=tte alle inkomens."
25070 DATA "Wor-d jij daar kwaa-d over?"
25080 DATA "Hij wor=dt nooit kwaad."
25090 DATA "Kom onmi=ddellijk van dat dak af."
29999 DATA "*"
30000 REM Voor groepen van 1 of 2
30010 REM letters in elke positie
30020 REM '-' VOOR enkele letters
30030 REM '=' VOOR tweelettergroepen
30040 REM Altijd 2 letters OF
30050 REM 1 letter + spatie intikken
30060 REM Aantal DATA-regels MAX 200
30070 REM LAATSTE DATA MOET "*" ZIJN
30080 REM ---> tempo REGEL 1690 <---
30090 REM 
32000 REM GEMAAKT 7 JANUARI 1987
32010 REM OP EEN  BBC B COMPUTER
32020 REM 
32030 REM door Ch.W. Brederode
32040 REM Von Bonninghausenlaan
32050 REM 2161 ES  LISSE
32060 REM 
32070 REM COPYRIGHT NOS HILVERSUM
