10 GOTO 1000:REM Basicode-2 subroutines
20 CLEAR:IN$=" ":SR=0:SR$="":CT=0:CN=0:OHT%=80:OVT%=24
22 KEY OFF:SCREEN 0:WIDTH OHT%:COLOR 7,0,0:CLS:RANDOMIZE TIMER*100
29 GOTO 1010
100 CLS:RETURN
110 GOSUB 111:LOCATE OVE%+1,OHO%+1:RETURN
111 OVE%=INT(VE):OHO%=INT(HO)
112 IF OVE%<0 THEN OVE%=0 ELSE IF OVE%>=OVT% THEN OVE%=OVT%-1
113 IF OHO%<0 THEN OHO%=0 ELSE IF OHO%>=OHT% THEN OHO%=OHT%-1
114 RETURN
120 HO=POS(0)-1:VE=CSRLIN-1:RETURN
200 IN$=INKEY$:RETURN
210 IN$=INPUT$(1):RETURN
250 BEEP:RETURN
260 RV=RND:RETURN
270 FR=FRE(""):RETURN
300 SR$=MID$(STR$(ABS(SR)),2):IF LEFT$(SR$,1)="." THEN SR$="0"+SR$
301 IF SR<0 THEN SR$="-"+SR$
302 RETURN
310 O#=ABS(SR)+.5*10^-CN:O!=INT(O#):O#=1+O#-O!:O$=""
311 IF CN THEN O$="."+STRING$(CN,48):IF O#>1 THEN MID$(O$,1)=MID$(STR$(O#),3)
312 O$=MID$(STR$(O!),2)+O$:IF VAL(O$)>0 AND SR<0 THEN O$="-"+O$
313 IF LEN(O$)<=CT THEN SR$=SPACE$(CT-LEN(O$))+O$:RETURN
314 SR$=STRING$(CT,42):RETURN
350 LPRINT SR$;:RETURN
360 LPRINT:RETURN
 1000 A=600:GOTO 20
 1010 GOSUB 100
 1020 REM eerst scherm opmeten
 1030 VE=0:FOR I=0 TO 80:HO=I:GOSUB 110
 1040 GOSUB 120:IF HO<>I THEN HP=I:I=80
 1050 NEXT I:FOR I=0 TO 40:HO=0:VE=I:GOSUB 110
 1060 GOSUB 120:IF VE<>I THEN VP=I:I=40
 1070 NEXT I
 1080 REM begin programma
 1090 DIM K$(6)
 1100 KL$="":N=1
 1110 GOSUB 100:PRINT"HOBBYSCOOPKRANT"
 1120 PRINT:PRINT"Naar P)rinter of S)cherm ?";
 1130 GOSUB 210:GOSUB 1800
 1140 IF(IN$<>"P") AND(IN$<>"S") THEN 1130
 1150 PRINT IN$:PRINT
 1160 PT=1:IF IN$="S" THEN PT=0:GOTO 1340
 1170 PRINT"Hoeveel letters per regel ";
 1180 INPUT HP
 1190 PRINT:PRINT"Kantlijnbreedte ";
 1200 INPUT SP:GOSUB 1900:KL$=SP$
 1210 HP=HP-SP:IF SP>1 THEN HP=HP-SP+2
 1220 PRINT:PRINT"Hoeveel regels tekst per pagina ";
 1230 INPUT VP
 1240 PRINT:PRINT"K)ettingformulieren of L)osse vellen ?";
 1250 GOSUB 210:GOSUB 1800
 1260 IF(IN$<>"K") AND(IN$<>"L") THEN 1250
 1270 PRINT IN$:PRINT
 1280 KF=1:IF IN$="L" THEN KF=0:GOTO 1310
 1290 PRINT"Hoeveel lege regels onderaan vel ";
 1300 INPUT LR:PRINT
 1310 PRINT"Zet de printer klaar"
 1320 PRINT"en druk op een toets."
 1330 GOSUB 210
 1340 RT=0:H=0
 1350 REM print de kop
 1360 K$(0)="*******************************"
 1370 K$(1)="*     N.O.S.- HOBBYSCOOP      *"
 1380 K$(2)="*        RADIOTEKST           *"
 1390 K$(3)="* EXTRA BEELDKRANT MET UITLEG *"
 1400 K$(4)="*     OVER HET PROGRAMMA      *"
 1410 K$(5)="*       SPORTUITSLAGEN        *"
 1420 K$(6)="*******************************"
 1430 GOSUB 100
 1440 SP=INT((HP-31)/2):IF PT=1 THEN SP=SP-3
 1450 GOSUB 1900
 1460 SR$=" ":GOSUB 20000
 1470 FOR I=0 TO 6:SR$=SP$+K$(I):GOSUB 20000:NEXT I
 1480 RESTORE:READ DD$
 1490 SR$=" ":GOSUB 20000
 1540 SR$=" ":GOSUB 20000
 1550 SR$="Zend uw bijdragen voor onze":GOSUB 20000
 1560 SR$="beeldkrant aan:":GOSUB 20000
 1570 SR$=" ":GOSUB 20000
 1580 SR$="N.O.S. Hobbyscoop Beeldkrant":GOSUB 20000
 1590 SR$="Postbus 1200":GOSUB 20000
 1600 SR$="1200 BE  Hilversum":GOSUB 20000
 1610 A$="":REM print de overige data
 1620 READ BB$
 1630 GOSUB 23000
 1640 GOSUB 24000
 1650 GOTO 1630
 1660 END
 1800 IF(IN$<"a") OR(IN$>"z") THEN RETURN
 1810 IN$=CHR$(ASC(IN$)-ASC("a")+ASC("A"))
 1820 RETURN
 1900 SP$="":IF SP<1 THEN RETURN
 1910 FOR I=1 TO SP:SP$=SP$+" ":NEXT I
 1920 RETURN
20000 REM afdruk subroutine
20010 IF SR$="" THEN RETURN
20020 IF PT=1 THEN 20060
20030 PRINT SR$
20040 RT=RT+1:IF RT=VP-4 THEN GOSUB 21000
20050 RETURN
20060 SR$=KL$+SR$:GOSUB 350:GOSUB 360:RT=RT+1
20070 IF RT=VP THEN GOSUB 22000
20080 RETURN
21000 REM scherm vol
21010 IF RT=0 THEN RETURN
21020 HO=0:VE=VP-1:GOSUB 110
21030 PRINT"<Toets voor verder>";
21040 GOSUB 210:GOSUB 100:RT=0:RETURN
22000 REM papier vol
22010 IF KF=1 THEN FOR I=1 TO LR:GOSUB 360:NEXT I:GOTO 22050
22020 PRINT"Zet de printer bovenaan nieuwe pagina"
22030 PRINT"en druk daarna op een toets."
22040 GOSUB 210:GOSUB 100
22050 RT=0:N=N+1:SR=N:GOSUB 300:N$=SR$
22060 SR$=DD$+", pag. "+N$
22070 RL=LEN(SR$):GOSUB 20060:SR$=""
22080 FOR I=1 TO RL:SR$=SR$+"-":NEXT I
22090 GOSUB 20060:SR$=" ":GOSUB 20060:RETURN
23000 IF BB$="$$$$$" THEN H=1:GOSUB 24000:END
23010 IF A$<>"" THEN A$=A$+" "
23020 A$=A$+BB$:READ BB$
23030 IF LEFT$(BB$,1)="#" THEN H=1:RETURN
23040 IF LEFT$(BB$,1)="." THEN H=1:RETURN
23050 IF A$=". " THEN RETURN
23060 IF LEFT$(A$,1)="#" THEN RETURN
23070 IF LEN(A$)<HP THEN 23000
23080 RETURN
24000 REM print met aangepaste regellengte
24010 IF LEFT$(A$,1)="#" THEN H=2
24020 IF(LEFT$(A$,1)<>".") AND(H<2) THEN 24070
24030 A$=RIGHT$(A$,LEN(A$)-1)
24040 IF H<2 THEN 24070
24050 IF PT=0 THEN GOSUB 21000
24060 IF PT=1 THEN SR$=" ":GOSUB 20000
24070 IF A$=" " THEN SR$=A$:A$="":GOSUB 20000:GOTO 24160
24080 L=LEN(A$):IF(H=0) AND(L<HP) THEN RETURN
24090 IF L<HP THEN SR$=A$:A$="":GOSUB 20000:GOTO 24150
24100 J=0:FOR I=HP TO 1 STEP-1
24110 IF MID$(A$,I,1)=" " THEN J=I:I=1
24120 NEXT I:IF J=0 THEN J=HP:L=L+1
24130 SR$=LEFT$(A$,J-1):A$=RIGHT$(A$,L-J)
24140 GOSUB 20000:GOTO 24080
24150 IF H=2 THEN SR$=" ":GOSUB 20000
24160 H=0:RETURN
25000 DATA"Uitleg 'Sportuitslagen'"
25010 DATA"#UITLEG SPORTUITSLAGEN"
25030 DATA"Met het programma sportuitslagen kunt u de"
25040 DATA"resultaten van uw favoriete sportclub"
25050 DATA"registreren en bekijken."
25060 DATA".De competitiestand wordt netjes voor u op het"
25070 DATA"scherm en/of de printer getoond."
25080 DATA".Ook is het mogelijk de uitslagen van een"
25090 DATA"competitieronde te voorspellen en een uitdraai"
25100 DATA"hiervan op de printer te maken."
25110 DATA". "
25120 DATA"Voordat het programma zinvol gebruikt kan"
25130 DATA"worden, zult u eerst zelf aan het werk moeten."
25140 DATA"U hebt namelijk machine-afhankelijke lees- en"
25150 DATA"schrijfroutines voor tekstbestanden nodig."
25160 DATA"Ga daarom als volgt te werk:"
25170 DATA"#1. MAAK SCHRIJFROUTINE"
25190 DATA"Het betreft de manier waarop uw computer"
25200 DATA"gegevens naar cassette of diskette wegschrijft."
25210 DATA".Gebruik in het programma de regels 7030 t/m"
25220 DATA"7280. Deze zijn voor de schrijfroutine bedoeld."
25230 DATA"Hierna volgt een voorbeeld-schrijfroutine."
25240 DATA"#VOORBEELD SCHRIJFROUTINE"
25260 DATA".7030 Open bestand NF$ om te schrijven"
25270 DATA".7040 SR=AV: GOSUB 300: PRINT SR$"
25280 DATA".7050 PRINT SB$"
25290 DATA".7060 PRINT KL$"
25300 DATA".7070 PRINT JR$"
25310 DATA".7080 FOR I=1 TO AV"
25320 DATA".7090 PRINT TM$(I)"
25330 DATA".7100 SR=TW(I): GOSUB 300: PRINT SR$"
25340 DATA".7110 IF TW(I)=0 THEN 7170"
25350 DATA".7120 FOR J=1 TO TW(I): T2=WN(I,J)"
25360 DATA".7130 SR=T2: GOSUB 300: PRINT SR$"
25370 DATA".7140 SR=DV(I,T2): GOSUB 300: PRINT SR$"
25380 DATA".7150 SR=DT(I,T2): GOSUB 300: PRINT SR$"
25390 DATA".7160 NEXT J"
25400 DATA".7170 NEXT I"
25410 DATA".7180 Sluit bestand NF$ af"
25420 DATA"#2. MAAK INLEESROUTINE"
25440 DATA"Het betreft de manier waarop uw computer"
25450 DATA"gegevens van cassette of diskette inleest."
25460 DATA".Gebruik in het programma de regels 6340 t/m"
25470 DATA"6570. Deze zijn voor de inleesroutine bedoeld."
25480 DATA"Hierna volgt een voorbeeld-inleesroutine."
25490 DATA"#VOORBEELD INLEESROUTINE"
25510 DATA".6340 Open bestand NF$ om in te lezen"
25520 DATA".6350 INPUT IN$: AV=VAL(IN$)"
25530 DATA".6360 INPUT SB$"
25540 DATA".6370 INPUT KL$"
25550 DATA".6380 INPUT JR$"
25560 DATA".6390 FOR I=1 TO AV"
25570 DATA".6400 INPUT TM$(I)"
25580 DATA".6410 INPUT IN$: TW(I)=VAL(IN$)"
25590 DATA".6420 IF TW(I)=0 THEN 6490"
25600 DATA".6430 FOR J=1 TO TW(I)"
25610 DATA".6440 INPUT IN$: WN(I,J)=VAL(IN$)"
25620 DATA".6450 T2=WN(I,J)"
25630 DATA".6460 INPUT IN$: DV(I,T2)=VAL(IN$)"
25640 DATA".6470 INPUT IN$: DT(I,T2)=VAL(IN$)"
25650 DATA".6480 NEXT J"
25660 DATA".6490 NEXT I"
25670 DATA".6500 Sluit bestand NF$ af"
25680 DATA"#3. KORREKTIETOETS"
25700 DATA"Wanneer u tijdens het invoeren van cijfers"
25710 DATA"fouten maakt, dan kunt u de spatiebalk als"
25720 DATA"korrektietoets gebruiken."
25730 DATA".Gebruikt u liever een andere toets, dan moet u"
25740 DATA"regel 1630 veranderen:"
25750 DATA". "
25760 DATA"1630 IF IN$=CHR$(32) THEN 1740"
25770 DATA". "
25780 DATA"Zoek in uw handleiding de ASCII-waarde op van"
25790 DATA"de toets die u wilt gebruiken en vervang de"
25800 DATA"waarde 32 in regel 1630 door de gevonden"
25810 DATA"ASCII-waarde."
25820 DATA"#4. DATAREGELS"
25840 DATA"Wanneer u het programma wilt gebruiken voor de"
25850 DATA"voetbalcompetitie in de eredivisie, dan hoeft"
25860 DATA"u niets te veranderen in de regels vanaf 25000."
25870 DATA"RUN het programma en kies alleen de eerste keer"
25880 DATA"voor het inlezen van gegevens uit DATAregels."
25890 DATA"(Alle volgende keren kiest u natuurlijk voor"
25900 DATA"het inlezen van gegevens van cassette of"
25910 DATA"diskette.) Voer de uitslagen in, enz., enz.,"
25920 DATA"maar... "
25930 DATA"wilt u stoppen, vergeet dan niet om uw aktuele"
25940 DATA"gegevens weg te schrijven naar cassette of"
25950 DATA"diskette. Doet u dit niet, dan gaan alle"
25960 DATA"ingevoerde gegevens verloren en moet u bij een"
25970 DATA"nieuwe RUN weer alle gegevens met de hand"
25980 DATA"invoeren!!!"
25990 DATA".Verander de DATAregels wanneer een nieuw"
26000 DATA"sportseizoen begint of wanneer u het programma"
26010 DATA"voor een andere tak van sport wilt gebruiken."
26020 DATA".Gebruik deze volgorde:"
26030 DATA". "
26040 DATA".AV     - Aantal verenigingen - max. 20"
26050 DATA".SB$    - Naam van de sportbond"
26060 DATA".KL$    - Naam van de klasse waarin"
26070 DATA".         gespeeld wordt."
26080 DATA".JR$    - Laatste 2 cijfers van het"
26090 DATA".         jaar, waarin competitie begint"
26100 DATA".TM$(1) - Naam van team 1 - max. 12 kar."
26110 DATA".0      - Aantal gespeelde wedstrijden"
26120 DATA".TM$(2) - Naam van team 2 - max. 12 kar."
26130 DATA".0      - Aantal gespeelde wedstrijden"
26140 DATA". "
26150 DATA"Enzovoorts"
26160 DATA"#STANDAARDINSTELLINGEN"
26180 DATA"Wilt u de standaard-instellingen van het"
26190 DATA"programma wijzigen, dan moet u tevens regel"
26200 DATA"6030 wijzigen:"
26210 DATA". "
26220 DATA".6030 SB$='KNVB':KL$='EREDIVISIE':"
26230 DATA".     JR$='88'"
26240 DATA"#5. UITSLAGEN VOORSPELLEN"
26260 DATA"Deze optie uit het hoofdmenu wordt pas"
26270 DATA"zichtbaar nadat de competitiestand berekend"
26280 DATA"is, omdat de voorspellingen gebaseerd zijn op"
26290 DATA"de meest aktuele competitiegegevens. Voor elke"
26300 DATA"wedstrijd worden vijf prognoses gegeven, op de"
26310 DATA"bekende wijze weergegeven door een 1 (winst"
26320 DATA"thuisclub), een 2 (winst bezoekende club) of"
26330 DATA"een 3 (gelijkspel). Overigens moet u niet"
26340 DATA"denken, dat u met deze voorspellingen de toto"
26350 DATA"kunt winnen, want de computer gaat uit van"
26360 DATA"feiten, terwijl sportwedstrijden hun eigen"
26370 DATA"wetmatigheden volgen."
26380 DATA". "
26390 DATA"De formule die het programma hanteert voor het"
26400 DATA"berekenen van de voorspellingen is beslist"
26410 DATA"voor verbetering vatbaar. Mogelijk een leuke"
26420 DATA"opgave voor de puzzelaars onder u."
26430 DATA".In regel 4820 en 4830 worden R1 en R2"
26440 DATA"berekend. R1 is het rekenkundig gemiddelde van"
26450 DATA"de winstpercentages die de thuisclub heeft"
26460 DATA"behaald in 1. alle gespeelde wedstrijden en 2."
26470 DATA"alle thuiswedstrijden."
26480 DATA".Een voorbeeld:"
26490 DATA".Team X heeft 8 wedstrijden gespeeld en 10"
26500 DATA"punten behaald, waarvan 6 punten in 4"
26510 DATA"thuiswedstrijden. Het winstpercentage over"
26520 DATA"alle gespeelde wedstrijden is 0.625 (10 van de"
26530 DATA"mogelijke 16 punten) en het winstpercentage"
26540 DATA"van de thuiswedstrijden bedraagt 0.75 (6 van"
26550 DATA"de mogelijke 8 punten)."
26560 DATA".R1 is dus (0.625 + 0.75) : 2 = 0.6875"
26570 DATA". "
26580 DATA"Op ongeveer dezelfde wijze wordt het resultaat"
26590 DATA"voor de bezoekende club berekend. R2 is het"
26600 DATA"rekenkundig gemiddelde van de winstpercentages"
26610 DATA"die de bezoekende vereniging heeft behaald in"
26620 DATA"1. alle gespeelde wedstrijden en 2. alle"
26630 DATA"uitwedstrijden."
26640 DATA".Vervolgens wordt in regel 4850 het verschil"
26650 DATA"berekend van R1 en R2 en opgeslagen in de"
26660 DATA"variabele SR. Is het verschil groter dan of"
26670 DATA"gelijk aan 0.05 dan is de prognose in de"
26680 DATA"eerste kolom een 1. Is het verschil kleiner"
26690 DATA"dan of gelijk aan -0.05 dan is de prognose in"
26700 DATA"de eerste kolom een 2. Ligt het verschil"
26710 DATA"tussen 0.05 en -0.05 dan is de prognose een 3."
26720 DATA"Voor de volgende kolommen wordt het verschil"
26730 DATA"van R1 en R2 telkens vergeleken met een getal,"
26740 DATA"dat 0.05 hoger en 0.05 kleiner is dan de vorige"
26750 DATA"waarde."
26760 DATA"#TOT SLOT"
26780 DATA"Schriftelijke vragen over het programma worden"
26790 DATA"uitsluitend beantwoord, indien u een aan"
26800 DATA"uzelf geadresseerde en voldoende"
26810 DATA"gefrankeerde enveloppe bijsluit."
26820 DATA". "
26830 DATA".      Harry Engel"
26840 DATA".      Jan Amentstraat 30"
26850 DATA".      6041 BE  Roermond"
26860 DATA".      Tel. 04750-19943"
29990 DATA"$$$$$"
30000 REM COPYRIGHT NOS HILVERSUM
