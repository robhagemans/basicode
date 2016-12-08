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
 1000 A=200:GOTO 20
 1010 REM
 1030 REM********************
 1040 REM* MAGNETRON WIJZER *
 1050 REM********************
 1060 REM
 1070 REM*** UITLEG ***
 1080 RESTORE:GOSUB 100
 1090 L1$="---------------------------------------"
 1100 L2$="======================================="
 1110 PRINT"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
 1120 PRINT"%%% MAGNETRON WIJZER      > MENU <  %%%"
 1130 PRINT"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
 1140 PRINT"#######################################"
 1150 PRINT"#:::::::::::::::::::::::::::::::::::::#"
 1160 PRINT"# Uitleg programma                  1 #"
 1170 PRINT"#:::::::::::::::::::::::::::::::::::::#"
 1180 PRINT"# Bereiden van vlees                2 #"
 1190 PRINT"#:::::::::::::::::::::::::::::::::::::#"
 1200 PRINT"# Bereiden van gevogelte            3 #"
 1210 PRINT"#:::::::::::::::::::::::::::::::::::::#"
 1220 PRINT"# Bereiden van vis                  4 #"
 1230 PRINT"#:::::::::::::::::::::::::::::::::::::#"
 1240 PRINT"# Bereiden van rijst en deegwaren   5 #"
 1250 PRINT"#:::::::::::::::::::::::::::::::::::::#"
 1260 PRINT"# Bereiden van verse groenten       6 #"
 1270 PRINT"#:::::::::::::::::::::::::::::::::::::#"
 1280 PRINT"# Alles achter elkaar printen       7 #"
 1290 PRINT"#:::::::::::::::::::::::::::::::::::::#"
 1300 PRINT"# Stoppen met dit programma         S #"
 1310 PRINT"#:::::::::::::::::::::::::::::::::::::#"
 1320 PRINT"#######################################"
 1330 GOSUB 210
 1340 IF IN$="1" THEN A$="UITLEG":GOTO 1430
 1350 IF IN$="2" THEN A$="VLEES":GOTO 1430
 1360 IF IN$="3" THEN A$="GEVOGELTE":GOTO 1430
 1370 IF IN$="4" THEN A$="VIS":GOTO 1430
 1380 IF IN$="5" THEN A$="RIJST":GOTO 1430
 1390 IF IN$="6" THEN A$="GROENTEN":GOTO 1430
 1400 IF IN$="7" THEN 1830
 1410 IF(IN$="S") OR(IN$="s") THEN 2090
 1420 GOTO 1330
 1430 PRINT:PRINT"  Op [P]apier of op [S]cherm";
 1440 GOSUB 210
 1450 IF(IN$="p") OR(IN$="P") THEN 1480
 1460 IF(IN$="s") OR(IN$="S") THEN 1480
 1470 GOTO 1440
 1480 READ B$:IF B$=A$ THEN 1500
 1490 GOTO 1480
 1500 IF(IN$="p") OR(IN$="P") THEN 1520
 1510 IF(IN$="s") OR(IN$="S") THEN 1720
 1520 REM
 1530 REM*** OP PAPIER ***
 1540 REM
 1550 GOSUB 100:PRINT"ALLES WORDT NU GEPRINT"
 1560 PRINT"======================================="
 1570 N=0
 1580 N=N+1:IF N<51 THEN 1650
 1590 PRINT"DRUK OP 'T' VOOR REGELTOEVOER"
 1600 PRINT"DRUK OP 'P' VOOR VERDER PRINTEN"
 1610 GOSUB 210
 1620 IF(IN$="t") OR(IN$="T") THEN GOSUB 360
 1630 IF(IN$="p") OR(IN$="P") THEN N=0:GOSUB 100:GOTO 1650
 1640 GOTO 1610
 1650 READ A$:IF A$="*" THEN GOSUB 360:GOTO 1070
 1660 SR$="I .................................. I "
 1670 GOSUB 350:SR$=A$
 1680 IF SR$="-" THEN SR$=L1$
 1690 IF SR$="=" THEN SR$=L2$
 1700 GOSUB 350:GOSUB 360
 1710 GOTO 1580
 1720 REM
 1730 REM*** OP BEELDSCHERM ***
 1740 REM
 1750 N=0:GOSUB 100
 1760 N=N+1
 1770 READ A$:IF A$="*" THEN GOSUB 2270:GOTO 1070
 1780 IF A$="-" THEN A$=L1$
 1790 IF A$="=" THEN A$=L2$
 1800 PRINT A$
 1810 IF N>20 THEN GOSUB 2270:GOTO 1750
 1820 GOTO 1760
 1830 REM
 1840 REM*** ALLES PRINTEN ***
 1850 REM
 1860 N=0
 1870 GOSUB 100:PRINT"ALLES WORDT GEPRINT"
 1880 PRINT"======================================="
 1890 N=N+1
 1900 READ A$
 1910 IF A$="UITLEG" THEN 1900
 1920 IF A$="VLEES" THEN 1900
 1930 IF A$="GEVOGELTE" THEN 1900
 1940 IF A$="VIS" THEN 1900
 1950 IF A$="RIJST" THEN 1900
 1960 IF A$="GROENTEN" THEN 1900
 1970 IF A$="*" THEN GOSUB 360:GOTO 1890
 1980 IF A$="**" THEN GOSUB 360:RUN
 1990 IF N<51 THEN 2060
 2000 PRINT"DRUK OP 'T' VOOR PAPIERTOEVOER"
 2010 PRINT"DRUK OP 'P' VOOR VERDER PRINTEN"
 2020 GOSUB 210
 2030 IF(IN$="t") OR(IN$="T") THEN GOSUB 360:GOTO 2020
 2040 IF(IN$="p") OR(IN$="P") THEN N=0:GOSUB 100:GOTO 2060
 2050 GOTO 2020
 2060 SR$="I .................................. I "
 2070 GOSUB 350:SR$=A$
 2072 IF SR$="-" THEN SR$=L1$
 2074 IF SR$="=" THEN SR$=L2$
 2076 GOSUB 350:GOSUB 360
 2080 GOTO 1890
 2090 REM
 2100 REM*** STOPPEN ***
 2110 REM
 2120 GOSUB 100
 2130 PRINT"* * ***** *******    ****"
 2140 PRINT"* * *   * *   *  *   *"
 2150 PRINT"* * *   * *   *  *===***"
 2160 PRINT"* * *   * *   *  *   *    SOFTWARE"
 2170 PRINT" * *     *    ***    *************"
 2180 PRINT"                          [C] 1988"
 2190 PRINT:PRINT:PRINT
 2200 PRINT"Nog meer magnetron-ideeen ???"
 2210 PRINT:PRINT"Stuur ze op naar:"
 2220 PRINT:PRINT:PRINT"Walther van den Elshout"
 2230 PRINT"Gen.Wicherslaan 14"
 2240 PRINT"5623 GS  EINDHOVEN"
 2250 PRINT"=================="
 2260 END
 2270 REM*** WACHT OP TOETS ***
 2280 VE=22:HO=32:GOSUB 110:PRINT"[TOETS]";
 2290 FOR WA=1 TO 100:NEXT WA
 2300 GOSUB 110:PRINT"[     ]";
 2310 FOR WA=1 TO 100:NEXT WA
 2320 GOSUB 200:IF IN$="" THEN 2270
 2330 RETURN
25000 DATA"UITLEG"
25010 DATA"#######################################"
25020 DATA"#    U I T L E G   MAGNETRONWIJZER    #"
25030 DATA"#######################################"
25040 DATA"","Met dit programma kunt u bekijken hoe u"
25050 DATA"allerlei gerechten in de magnetronoven"
25060 DATA"kunt klaarmaken. Deze gerechten kunt"
25070 DATA"u bepalen d.m.v. het hoofdmenu."
25080 DATA"Op deze manier kunt u complete maaltij-"
25090 DATA"den samenstellen. U kunt alles op pa-"
25100 DATA"pier krijgen zodat u het later nog eens"
25110 DATA"kunt gebruiken."
25120 DATA"","","                    EET SMAKELIJK !"
25130 DATA"","      Walther van den Elshout, [C]1988."
25140 DATA"*"
25150 DATA"VLEES"
25160 DATA"#######################################"
25170 DATA"#               V L E E S             #"
25180 DATA"#######################################"
25190 DATA"RUNDERROLLADE/ROSBIEF"
25200 DATA"Per 500 gr. op hoogste stand.","-"
25210 DATA"Rood: 5/6 min.  Halfgaar: 7/8 min."
25220 DATA"Gaar: 8/10 min.","-"
25230 DATA"Draai het vlees halverwege de berei-"
25240 DATA"dingstijd; Laat 10-15 min. staan,"
25250 DATA"afgedekt met aluminiumfolie.","="
25260 DATA"RUNDERRIBSTUK"
25270 DATA"Per 500 gr. op hoogste stand.","-"
25280 DATA"Rood: 5 min.  Halfgaar: 6 min."
25290 DATA"Gaar: 8 min.","-"
25300 DATA"Dek uitstekende dunne delen af met"
25310 DATA"aluminiumfolie tijdens de eerste"
25320 DATA"helft van de bereidingstijd, keer het"
25330 DATA"vlees halverwege; laat 10-15 min. staan"
25340 DATA"afgedekt met aluminiumfolie.","="
25350 DATA"ROLLADE/LAMSBOUT ZONDER BOT/FRICANDEAU"
25360 DATA"VAN LAMS- OF KALFSVLEES"
25370 DATA"Per 500 gr. Hoge stand.","-"
25380 DATA"Halfgaar: 7/8 min."
25390 DATA"Gaar: 8/10 min.","-"
25400 DATA"Draai het vlees halverwege de berei-"
25410 DATA"dingstijd om. Laat 10-15 min. staan"
25420 DATA"KARBONADES > LAMS- OF KALFSVLEES"
25430 DATA"Per 500 gr.","-"
25440 DATA"1.5 min. op hoogste stand, daarna"
25450 DATA"1.5 tot 2 min. op halfhoge stand.","-"
25460 DATA"Schroei het vlees dicht op een grill-"
25470 DATA"plateau of onder de grill. Leg de bot-"
25480 DATA"delen naar het midden.","="
25490 DATA"LAMSBOUT MET BOT / RIBSTUK"
25500 DATA"Per 500 gr. op hoogste stand.","-"
25510 DATA"Halfgaar: 6/7 min.  Gaar: 8/9 min.","-"
25520 DATA"Dek uitstekende delen af met aluminium-"
25530 DATA"folie. Leg eerst de kant met het vet"
25540 DATA"naar beneden, draai het vlees halver-"
25550 DATA"wege de bereidingstijd. Laat 10/15 min."
25560 DATA"afgedekt staan.","="
25570 DATA"GEVULDE LAMSRIB"
25580 DATA"Per 500 gr. op halfhoge stand.","-"
25590 DATA"Bij gevuld gewicht 9/10 min.","-"
25600 DATA"Dek botdelen af met aluminiumfolie en"
25610 DATA"pak ze in met doorzichtige folie."
25620 DATA"Verplaats het vlees halverwege de"
25630 DATA"bereidingstijd. Laat 20 min. afgedekt"
25640 DATA"staan.","="
25650 DATA"VARKENSROLLADE/FRICANDEAU"
25660 DATA"Per 500 gr. op hoogste stand.","-"
25670 DATA"8 tot 10 minuten","-"
25680 DATA"Draai het vlees halverwege de berei-"
25690 DATA"dingstijd. Laat 10/15 min. afgedekt"
25700 DATA"staan.","="
25710 DATA"VARKENSRIBSTUK"
25720 DATA"Per 500 gr. 8/9 min. op hoogste stand.","-"
25730 DATA"Zie varkensrollade.","="
25740 DATA"VARKENSKARBONADES"
25750 DATA"1 stuk: 4/4.5 min. op hoogste stand"
25760 DATA"2 stuks: 5/5.5 min. op hoogste stand"
25770 DATA"3 stuks: 6/7 min. op hoogste stand"
25780 DATA"4 stuks: 6.5/8 min. op hoogste stand","-"
25790 DATA"Schroei het vlees dicht op grillplateau"
25800 DATA"of grill. Leg de botdelen naar het"
25810 DATA"midden. Laat 2 min. staan voor 1 stuk."
25820 DATA"3/5 min. voor 2-4 stuks.","="
25830 DATA"VARKENSSAUCIJZEN"
25840 DATA"2 stuks: 2.5 min. op hoogste stand"
25850 DATA"4 stuks: 4 min. op hoogste stand","-"
25860 DATA"Prik de velletjes in. Bruin de saucij-"
25870 DATA"zen op het grillplateau en draai ze"
25880 DATA"regelmatig om.","="
25890 DATA"SPEK: GROOT STUK"
25900 DATA"per 500 gr. 12-14 min. op hoogste stand","-"
25910 DATA"Leg het spek in een braadzak en prik"
25920 DATA"in. Draai het spek halverwege de berei-"
25930 DATA"dingstijd. Laat 10 min. afgedekt staan.","="
25940 DATA"ONTBIJTSPEK"
25950 DATA"2 plakjes: 2.5 minuut op hoogste stand"
25960 DATA"4 plakjes: 4/4.5 min. op hoogste stand"
25970 DATA"6 plakjes: 5/6 min. op hoogste stand"
25980 DATA"per 500 gr. 12 min. op hoogste stand","-"
25990 DATA"Leg de plakjes naast elkaar. Dek af met"
26000 DATA"keukenpapier. Verwijder het papier"
26010 DATA"direkt na de bereidingstijd. Gebruik"
26020 DATA"eventueel het grillplateau, leg grote"
26030 DATA"hoeveelheden dakpansgewijs op het"
26040 DATA"afdruiprek. Verwissel de plakjes 3x van"
26050 DATA"plaats.","="
26060 DATA"LEVER"
26070 DATA"Per 500 gr.  8/10 min. op hoogste stand","-"
26080 DATA"Dek af met keukenpapier, tegen het"
26090 DATA"spatten.","="
26100 DATA"NIERTJES"
26110 DATA"Per 500 gr.  8 min. op hoogste stand","-"
26120 DATA"Leg ze in een cirkel, dek af tegen het"
26130 DATA"spatten. Verplaats de niertjes gedu-"
26140 DATA"rende de bereidingstijd.","="
26150 DATA"TONG"
26160 DATA"Per 500 gr. 20 min. op hoogste stand","-"
26170 DATA"Verplaats de tong gedurende de berei-"
26180 DATA"dingstijd.","=","*"
26190 DATA"GEVOGELTE"
26200 DATA"#######################################"
26210 DATA"#              GEVOGELTE              #"
26220 DATA"#######################################"
26230 DATA"HELE KIP"
26240 DATA"Per 500 gr.  8/10 min. op hoogste stand","-"
26250 DATA"Leg de kip in een braadzak, borst naar"
26260 DATA"onderen. Draai halverwege de berei-"
26270 DATA"dingstijd. Indien gewenst bruinen onder"
26280 DATA"een hete grill. Laat 10-15 min. staan.","="
26290 DATA"HEEL PIEPKUIKEN"
26300 DATA"5 min. op hoogste stand","-"
26310 DATA"Leg het kuiken in een braadzak en draai"
26320 DATA"halverwege de bereidingstijd.","="
26330 DATA"KIPDELEN"
26340 DATA"Per 500 gr. 7/10 min. op hoogste stand"
26350 DATA"of iets langer op een lagere stand.","-"
26360 DATA"Leg de velkant naar boven, dunne delen"
26370 DATA"naar het midden. Verplaats halverwege"
26380 DATA"de bereidingstijd. Laat 5-12 min. staan","="
26390 DATA"HELE EEND"
26400 DATA"Per 500 gr.  7/10 min. op hoogste stand","-"
26410 DATA"Draai halverwege de bereidingstijd."
26420 DATA"Laat 10/15 min. staan.","="
26430 DATA"EENDDELEN"
26440 DATA"4 stukken van 300 gr. 10 min. op de"
26450 DATA"halfhoge stand. Verder dezelfde werk-"
26460 DATA"wijze als bij kipdelen.","="
26470 DATA"HELE KALKOEN"
26480 DATA"Per 500 gr.  9-11 min. op hoogste stand","-"
26490 DATA"Draai de kalkoen 3-4 maal afhankelijk"
26500 DATA"van de grootte. Eerst de borstzijde"
26510 DATA"naar onderen. Laat 10-15 min. staan.","="
26520 DATA"KALKOENROLLADE"
26530 DATA"Per 500 gr.  10 min. op hoogste stand","-"
26540 DATA"Draai halverwege de bereidingstijd.","=","*"
26550 DATA"VIS"
26560 DATA"#######################################"
26570 DATA"#                 V I S               #"
26580 DATA"#######################################"
26590 DATA"HELE VIS ZOALS WIJTING, FOREL, KARPER"
26600 DATA"POON, BRASEM, SCHELVIS."
26610 DATA"per 500 gr.  3 min. op hoogste stand of"
26620 DATA"iets langer op een lagere stand.","-"
26630 DATA"Snijd het vel in en keer de vis halver-"
26640 DATA"wege de bereidingstijd. Scherm dunne"
26650 DATA"delen af met aluminiumfolie. Verplaats"
26660 DATA"meer dan 2 vissen regelmatig.","="
26670 DATA"HELE PLATVIS ZOALS TONG OF SCHOL"
26680 DATA"3 min. op hoogste stand, of iets langer"
26690 DATA"op een lagere stand.","-"
26700 DATA"Snijd het vel in, draai de schaal een"
26710 DATA"halve slag tijdens de bereidingstijd."
26720 DATA"Dek de staarten af.","="
26730 DATA"VISFILETS OF MOTEN VIS"
26740 DATA"Per 500 gr.  4 min. op hoogste stand"
26750 DATA"of langer op een lagere stand","-"
26760 DATA"Leg dikke delen naar buiten gericht"
26770 DATA"leg dunne delen over elkaar met een"
26780 DATA"velletje doorzichtige folie ertussen."
26790 DATA"Keer de filets en draai de schaal"
26800 DATA"gedurende de bereidingstijd 3 maal een"
26810 DATA"kwartslag om.","="
26820 DATA"GEROOKTE VIS"
26830 DATA"Zie bij visfilets.","=","*"
26840 DATA"RIJST"
26850 DATA"#######################################"
26860 DATA"#          RIJST EN DEEGWAREN         #"
26870 DATA"#######################################"
26880 DATA"WITTE RIJST, LANGE KORREL"
26890 DATA"Per 250 gr. 10-12 min. op hoogste stand"
26900 DATA"en doorkookstand.","-"
26910 DATA"Schep eenmaal om en laat 10 min. staan.","="
26920 DATA"BRUINE RIJST"
26930 DATA"Per 100 gr.: 30 min. op hoogste stand"
26940 DATA"en doorkookstand.","-"
26950 DATA"Schep eenmaal om en laat 10 min. staan.","="
26960 DATA"MACARONISOORTEN"
26970 DATA"Per 250 gr. 7 min. op hoogste stand en"
26980 DATA"doorkookstand.","-"
26990 DATA"Schep eenmaal om en laat 5 min staan.","="
27000 DATA"SPAGHETTI / TAGLIATELLE"
27010 DATA"Per 250 gr.  7/8 min. op hoogste stand"
27020 DATA"en doorkookstand.","-"
27030 DATA"Schep eenmaal om en laat 10 min. staan.","=","*"
27040 DATA"GROENTEN"
27050 DATA"#######################################"
27060 DATA"#   V E R S E       G R O E N T E N   #"
27070 DATA"#######################################"
27080 DATA"ARTISJOK"
27090 DATA"1 stuk: 5/6 min. op hoogste stand"
27100 DATA"2 stuks: 7/8 min. op hoogste stand"
27110 DATA"3 stuks: 11/12 min. op hoogste stand"
27120 DATA"en doorkookstand.","-"
27130 DATA"Zet ze rechtop in de schaal.","="
27140 DATA"AARDAPPELEN IN DE SCHIL"
27150 DATA"1 aardappel: 2 min. op hoogste stand"
27160 DATA"2 aardappelen:3/4 min. op hoogste stand"
27170 DATA"3 aardappelen:6/8 min. op hoogste stand","-"
27180 DATA"Prik ze in met een vork en leg ze in"
27190 DATA"een cirkel op absorberend papier."
27200 DATA"Keer ze halverwege de bereidingstijd."
27210 DATA"Laat 20 min. afgedekt nagaren.","="
27220 DATA"AARDAPPELEN GEKOOKT"
27230 DATA"500 gr.  5/8 min. op de hoogste stand","-"
27240 DATA"Schud of schep ze om gedurende de"
27250 DATA"bereidingstijd.","="
27260 DATA"KRIELTJES GEKOOKT"
27270 DATA"500 gr.  5/8 min. op hoogste stand","-"
27280 DATA"Vooral niet te gaar laten worden!","="
27290 DATA"ZOETE AARDAPPELEN","-"
27300 DATA"Prik ze in met een vork. Leg ze op ab-"
27310 DATA"sorberend papier en draai ze halverwege","="
27320 DATA"ASPERGES"
27330 DATA"350 gr. 5/7 min. op de hoogste stand.","-"
27340 DATA"Leg ze met de stelen naar buiten."
27350 DATA"Verplaats ze gedurende de bereidings-"
27360 DATA"tijd.","="
27370 DATA"AUBERGINES IN PLAKJES"
27380 DATA"500 gr.  4/6 min. op hoogste stand.","-"
27390 DATA"Schud de schaal na 3 min.","="
27400 DATA"HELE BIETEN"
27410 DATA"500 gr. (4)  10/12 min. hoogste stand","-"
27420 DATA"Prik ze in met een vork en verplaats"
27430 DATA"ze gedurende de bereidingstijd.","="
27440 DATA"BLEEKSELDERIJ IN STUKJES","-"
27450 DATA"Schud of schep ze om gedurende de be-"
27460 DATA"reidingstijd.","="
27470 DATA"BLOEMKOOL"
27480 DATA"Hele, 8/10 min. op de hoogste stand.","-"
27490 DATA"Schud of schep om gedurende de berei-"
27500 DATA"dingstijd.","="
27510 DATA"ROOSJES"
27520 DATA"250 gr. 5/6 min. op hoogste stand"
27530 DATA"500 gr. 8/10 min. op hoogste stand","-"
27540 DATA"Bereiding: zie bloemkool.","="
27550 DATA"BROCCOLI"
27560 DATA"500 gr.  5/8 min. op de hoogste stand.","-"
27570 DATA"Verplaats de broccoli gedurende de be-"
27580 DATA"reidingstijd. Leg de stelen naar het"
27590 DATA"midden.","="
27600 DATA"CHAMPIGNONS"
27610 DATA"250gr.  2/3 min. op hoogste stand.","-"
27620 DATA"Geen water, maar 25 gr. boter toevoegen"
27630 DATA"en citroensap. Schud om gedurende de"
27640 DATA"bereidingstijd.","="
27650 DATA"COURGETTES PLAKJES"
27660 DATA"500 gr.  5/6 min. op hoogste stand.","-"
27670 DATA"Voeg twee eetlepels water toe. Schud om"
27680 DATA"gedurende de bereidingstijd. Laat 2 min"
27690 DATA"staan alvorens uit te lekken.","="
27700 DATA"DOPERWTEN"
27710 DATA"500 gr.  5/6 min. op hoogste stand","-"
27720 DATA"Schud of schep om gedurende de berei-"
27730 DATA"dingstijd.","="
27740 DATA"KOOL GESCHAAFD"
27750 DATA"500 gr.  6/8 min. op hoogste stand.","-"
27760 DATA"Schud of schep om gedurende de berei-"
27770 DATA"dingstijd.","="
27780 DATA"KOOLRAAP PLAKJES"
27790 DATA"Zie kool geschaafd.","="
27800 DATA"MAISKOLVEN"
27810 DATA"2 stuks: 6/8 min. op de hoogste stand.","-"
27820 DATA"Verpak de kolven in ingevet vetvrij pa-"
27830 DATA"pier. Voeg geen water toe. Keer ze na"
27840 DATA"3 min.","="
27850 DATA"PASTINAKEN"
27860 DATA"500 gr.  8/10 min op hoogste stand.","-"
27870 DATA"Leg dunne einden naar het midden."
27880 DATA"Voeg klontje boter en 1 eetl. citroen-"
27890 DATA"sap toe met 1.5 dl. water. Draai de"
27900 DATA"schotel en verplaats de wortelen gedu-"
27910 DATA"rende de bereidingstijd.","="
27920 DATA"PREI IN RINGEN"
27930 DATA"500 gr.  4/6 min. op hoogste stand.","-"
27940 DATA"Schud of schep om gedurende de berei-"
27950 DATA"dingstijd.","="
27960 DATA"SPINAZIE"
27970 DATA"500 gr.  4/5 min. op hoogste stand.","-"
27980 DATA"Leg de spinazie zonder water in een"
27990 DATA"braadzak. Draai de schaal gedurende de"
28000 DATA"bereidingstijd.","="
28010 DATA"SPERZIEBONEN"
28020 DATA"500 gr.  8/10 min. op de hoogste stand.","-"
28030 DATA"Schud of schep om gedurende de berei-"
28040 DATA"dingstijd.","="
28050 DATA"SPRUITJES"
28060 DATA"250 gr.  2/4 min. op de hoogste stand."
28070 DATA"500 gr.  4/6 min. op de hoogste stand.","-"
28080 DATA"Schud of schep om gedurende de berei-"
28090 DATA"dingstijd.","="
28100 DATA"TUINBONEN"
28110 DATA"500 gr.  6/8 min. op de hoogste stand.","-"
28120 DATA"Schud of schep om gedurende de berei-"
28130 DATA"dingstijd.","="
28140 DATA"UIEN IN RINGEN"
28150 DATA"250 gr.  3/5 min. op de hoogste stand."
28160 DATA"Schud of schep de ringen om gedurende"
28170 DATA"de bereidingstijd.","="
28180 DATA"UIEN, HEEL"
28190 DATA"175 gr.  6/8 min. op de hoogste stand.","-"
28200 DATA"Voeg 4 eetl. water toe en verplaats"
28210 DATA"de uien gedurende de bereidingstijd.","="
28220 DATA"VENKEL IN STUKJES"
28230 DATA"500 gr.  6/8 min. op de hoogste stand.","-"
28240 DATA"Schud of schep om gedurende de berei-"
28250 DATA"dingstijd.","="
28260 DATA"WORTELEN"
28270 DATA"500 gr.  6/8 min. op de hoogste stand.","-"
28280 DATA"Schud of schep om gedurende de berei-"
28290 DATA"dingstijd.","=","*"
28300 DATA"**"
30000 REM
30010 REM***************************
30020 REM*     MAGNETRONWIJZER     *
30025 REM*                         *
30030 REM* GESCHREVEN DOOR:        *
30040 REM* WALTHER VAN DEN ELSHOUT *
30050 REM* GEN.WICHERSLAAN 14      *
30060 REM* 5623 GS  EINDHOVEN      *
30070 REM* TEL: 040-451098         *
30080 REM*                         *
30090 REM* COMMODORE 64            *
30100 REM* OKTOBER 1988            *
30110 REM*                         *
30120 REM* COPYRIGHT NOS HILVERSUM *
30130 REM***************************
