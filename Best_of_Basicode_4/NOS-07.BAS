1000 A=1000:GOTO 20:REM "INVUL-1"
1010 DIM IV$(10),IV(10),DT(201),NR(201):GOSUB 100:MX=0
1020 GOSUB 100:PRINT "   EVEN GEDULD A.U.B"
1030 REM ---DATA regels tellen ---
1040 MX=MX+1:READ A$:IF A$<>"*" THEN NR(MX)=MX:GOTO 1040
1050 GOSUB 100
1060 REM --- scherm klaarzetten ---
1070 HO=2:VE=7:GOSUB 110:PRINT "VUL IN:  a  of  o"
1080 HZ=0:VZ=12:HG=7:VG=16:HF=24
1085 HO=HZ:VE=VZ:GOSUB 110:PRINT "  EVEN GEDULD"
1090 HO=0:VE=VG:GOSUB 110
1100 PRINT "  GOED 0           FOUT 0    ";
1110 REM --- DATA volgorde schudden
1120 GOSUB 1390
1130 FO=0:GO=0:TT=0
1140 REM --- zin ophalen uit DATA ---
1150 TT=TT+1:IF TT=MX THEN GOSUB 1590:GOTO 1050
1160 RESTORE :FOR N=1 TO NR(TT):READ A$:NEXT N
1170 LA=LEN(A$):N=0:S=0
1180 N=N+1:IF N=LA+1 THEN 1240
1190 IF MID$(A$,N,1)<>"-" THEN 1180
1200 IV(S)=N-1:IV$(S)=MID$(A$,N+1,1)
1210 B$=LEFT$(A$,N):C$=RIGHT$(A$,LA-N-1):A$=B$+C$
1220 LA=LA-1:S=S+1
1230 GOTO 1180
1240 REM --- analyse klaar! ---
1250 HO=HZ:VE=VZ:GOSUB 110
1260 PRINT A$;
1270 FOR M=0 TO S-1
1280 HO=IV(M):VE=VZ:GOSUB 110
1290 GOSUB 210:
1300 IF IN$<>IV$(M) THEN FO=FO+1:GOSUB 1530:GOTO 1290
1310 PRINT IN$:GO=GO+1
1320 GOSUB 1530
1330 GOSUB 1490
1340 NEXT M
1350 HO=HZ:VE=VZ:GOSUB 110
1360 PRINT "                                          "
1370 GOTO 1150
1380 :
1390 REM === DATA NRS SCHUDDEN ===
1400 FOR N=1 TO MX:DT(N)=N:NEXT N
1410 FOR N=MX-1 TO 2 STEP -1
1420 GOSUB 260:X=1+INT(RV*N)
1430 NR(N)=DT(X)
1440 FOR M=X TO N-1:DT(M)=DT(M+1)
1450 NEXT M:NEXT N
1460 NR(1)=DT(1)
1470 RETURN
1480 :
1490 REM === VETRAGINGSLUS ===
1500 FOR W=1 TO 1000:NEXT W
1510 RETURN
1515 REM Aanpassen aan uw computer
1520 :
1530 REM === PRINT DE SCORE ===
1540 HO=HG:VE=VG:GOSUB 110:PRINT ;GO
1550 HO=HF:GOSUB 110:PRINT ;FO
1560 HO=IV(M):VE=VZ:GOSUB 110
1570 RETURN
1580 :
1590 REM === EINDE VAN EEN SERIE ===
1600 HO=2:VE=20:GOSUB 110
1610 IF FO=0 THEN PRINT "GOED GEDAAN!";
1620 PRINT " - NOG 'N KEER?";
1630 GOSUB 210:IF (IN$="N") OR(IN$="n") THEN END
1640 IF (IN$<>"J") AND(IN$<>"j") THEN 1630
1650 GOSUB 110:PRINT "                         "
1660 RETURN
1690 REM ==============================
25000 DATA "Jan heeft een bl-auwe jas."
25010 DATA "Dat is een heel -oud geb-ouw."
25020 DATA "De p-auw heeft bl-auwe veren."
25030 DATA "Die bl-auwe -auto is van mijn oom."
25040 DATA "Doe niet zo fl-auw, geef g-auw hier!"
25050 DATA "Je moet niet zo doord-ouwen."
25060 DATA "Wil je dat bl-auwe papier opv-ouwen?"
25070 DATA "Deze -oude hond vertr-ouwt niemand."
25080 DATA "De boekh-ouder keek heel ben-auwd."
25090 DATA "Zijn g-ouden ring was er niet meer."
25100 DATA "De bierbr-ouwerij is verb-ouwd."
25110 DATA "Geef mij het z-out eens aan."
25120 DATA "Die m-ouwen zijn veel te n-auw."
25130 DATA "Die -oude mevr-ouw heeft het k-oud."
25140 DATA "Gr-auwe ganzen zijn mooie vogels."
25150 DATA "Ik h-oud niet zo van haverm-out."
25160 DATA "G-auw en goed zijn twee dingen!"
25170 DATA "Z-ou ik nu g-auw klaar zijn?"
25180 DATA "Piet zag bl-auw van de k-ou!"
25190 DATA "Wat loopt die poes toch te mi-auwen!"
25200 DATA "Koeien en geiten zijn herk-auwers."
25210 DATA "Je hoeft niet zo te sn-auwen."
25999 DATA "*"
30000 REM Geschikt voor 1 letter-invul
30010 REM invullen met 1 toetsaanslag
30020 REM zonder RETURN
30030 REM Ook geschikt voor D of T
30040 REM F of V en dergelijke
30050 REM '-' VOOR in te vullen letter
30060 REM MAX 200 DATAREGELS
30070 REM LAATSTE DATA MOET "*" ZIJN
30080 REM Regel 1500 aanpassen (tempo!)
30090 REM 
30100 REM GEMAAKT 7 JANUARI 1987
30110 REM OP EEN  BBC B COMPUTER
30120 REM 
30130 REM door Ch.W. Brederode
30140 REM Von Bonninghausenlaan 33
30150 REM 2161 ES  LISSE
30160 REM 
30170 REM COPYRIGHT NOS HILVERSUM
