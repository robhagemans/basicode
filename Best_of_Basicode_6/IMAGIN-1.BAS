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
 1010 GOSUB 100:REM OOIT VAN I GEHOORD?
 1020 REM EERST SCHERM OPMETEN
 1030 VE=0:FOR I=0 TO 80:HO=I:GOSUB 110
 1040 GOSUB 120:IF HO<>I THEN HP=I:I=80
 1050 NEXT I:FOR I=0 TO 40:HO=0:VE=I:GOSUB 110
 1060 GOSUB 120:IF VE<>I THEN VP=I:I=40
 1070 NEXT I
 1080 REM BEGIN PROGRAMMA
 1090 DIM K$(6)
 1100 KL$="":N=1
 1110 GOSUB 100:VE=4:HO=6:GOSUB 110
 1115 PRINT"Ooit van i gehoord ?":VE=8:GOSUB 110
 1120 PRINT"naar p)rinter of s)cherm ?";
 1130 GOSUB 210:GOSUB 1800
 1140 IF(IN$<>"p") AND(IN$<>"s") THEN 1130
 1150 PRINT IN$:PRINT
 1160 PT=1:IF IN$="s" THEN PT=0:GOTO 1340
 1170 PRINT"hoeveel letters per regel ";
 1180 INPUT HP
 1190 PRINT:PRINT"kantlijnbreedte ";
 1200 INPUT SP:GOSUB 1900:KL$=SP$
 1210 HP=HP-SP:IF SP>1 THEN HP=HP-SP+2
 1220 PRINT:PRINT"hoeveel regels tekst per pagina ";
 1230 INPUT VP
 1240 PRINT:PRINT"k)ettingformulieren of l)osse vellen ?";
 1250 GOSUB 210:GOSUB 1800
 1260 IF(IN$<>"k") AND(IN$<>"l") THEN 1250
 1270 PRINT IN$:PRINT
 1280 KF=1:IF IN$="l" THEN KF=0:GOTO 1310
 1290 PRINT"hoeveel lege regels onderaan vel ";
 1300 INPUT LR:PRINT
 1310 PRINT"zet de printer klaar"
 1320 PRINT"en druk op een toets"
 1330 GOSUB 210
 1340 RT=0:H=0
 1350 REM PRINT DE KOP
 1360 K$(0)="******************************"
 1370 K$(1)="*  Ooit van 'i' gehoord ?  1 *"
 1380 K$(2)="*         Harry Eyck         *"
 1390 K$(3)="*            Neer            *"
 1400 K$(4)="*        februari 1989       *"
 1410 K$(5)="*      op commodore c.64     *"
 1420 K$(6)="******************************"
 1430 GOSUB 100
 1440 SP=INT((HP-30)/2):IF PT=1 THEN SP=SP-3
 1450 GOSUB 1900
 1460 SR$=" ":GOSUB 20000
 1465 FOR I=1 TO 7:PRINT:NEXT I
 1470 FOR I=0 TO 6:SR$=SP$+K$(I):GOSUB 20000:NEXT I
 1475 RT=1:GOSUB 21000:FOR I=1 TO 5:PRINT:NEXT I
 1480 RESTORE:READ DD$
 1490 SR$=" ":GOSUB 20000
 1500 A$=DD$
 1510 SP=INT((HP-LEN(A$))/2):IF PT=1 THEN SP=SP-3
 1520 GOSUB 1900
 1530 SR$=SP$+A$:GOSUB 20000:PRINT
 1540 SR$=" ":GOSUB 20000
 1550 SR$=" INHOUD deel 1":GOSUB 20000
 1560 SR$=" -------------":GOSUB 20000:PRINT
 1570 SR$="   De plaats van 'i' tussen de":GOSUB 20000
 1575 SR$="   getallen en enig inzicht in'i'":GOSUB 20000
 1580 SR$="   en de imaginaire getallen.":GOSUB 20000:PRINT
 1710 A$="":REM PRINT OVERIGE DATA
 1720 READ BB$
 1730 GOSUB 23000
 1740 GOSUB 24000
 1750 GOTO 1730
 1760 END
 1800 IF(IN$<"A") OR(IN$>"Z") THEN RETURN
 1810 IN$=CHR$(ASC(IN$)-ASC("A")+ASC("a"))
 1820 RETURN
 1900 SP$="":IF SP<1 THEN RETURN
 1910 FOR I=1 TO SP:SP$=SP$+" ":NEXT I
 1920 RETURN
20000 REM AFDRUK SUBROUTINE
20010 IF SR$="" THEN RETURN
20020 IF PT=1 THEN 20060
20030 PRINT SR$
20040 RT=RT+1:IF RT=VP-4 THEN GOSUB 21000
20050 RETURN
20060 SR$=KL$+SR$:GOSUB 350:GOSUB 360:RT=RT+1
20070 IF RT=VP THEN GOSUB 22000
20080 RETURN
21000 REM SCHERM VOL
21010 IF RT=0 THEN RETURN
21020 HO=0:VE=VP-1:GOSUB 110
21030 PRINT"<toets voor verder>";
21040 GOSUB 210:GOSUB 100:RT=0:RETURN
22000 REM PAPIER VOL
22010 IF KF=1 THEN FOR I=1 TO LR:GOSUB 360:NEXT I:GOTO 22050
22020 PRINT"zet de printer bovenaan nieuwe pagina"
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
24000 REM PRINT MET AANGEPASTE REGELLENGTE
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
25000 DATA"Ooit van 'i' gehoord ?"
25010 DATA"#Inleiding."
25020 DATA"In de wiskunde spelen 3 bijzondere getallen"
25030 DATA"een grote rol,n.l.",". "
25040 DATA".         1. pi"
25050 DATA".         2. e"
25060 DATA".         3. i",". "
25070 DATA". De bekende wiskundige EULER vond reeds"
25080 DATA"in 1748 de onderlinge betrekking tussen deze"
25090 DATA"3 getallen n.l.",". "
25100 DATA".   2*i*pi            i*pi"
25110 DATA".  e      = 1   en   e    = -1",". "
25120 DATA". Dit programma wil enige aanwijzingen geven"
25130 DATA"omtrent de plaats van i tussen de getallen"
25140 DATA"in het algemeen en wat nadere gegevens over"
25150 DATA"dat vreemde getal i bij elkaar zetten.",". "
25160 DATA"Verwacht geen knappe wiskunde-les met"
25170 DATA"sluitende bewijzen,maar wat 'brain-storming'"
25180 DATA"rond dat wonderlijke fenomeen i."
25190 DATA". Is de belangstelling gewekt,dan zijn er"
25200 DATA"genoeg goede wiskunde- boeken in elke"
25210 DATA"bibliotheek beschikbaar."
25220 DATA". Het programma bestaat uit 3 delen:",". "
25230 DATA". 1.De plaats van i tussen de getallen,"
25240 DATA".   enig inzicht in i en de imaginaire"
25250 DATA".   getallen.",". "
25260 DATA". 2.Enige oefenstof.(in deel 2)",". "
25270 DATA". 3.Historische notities(in deel 2).",". "
25280 DATA".                     VEEL PLEZIER !"
25290 DATA"#Iets over getallen in het algemeen."
25300 DATA"Is het niet handig,dat de cijfers in vele"
25310 DATA"landen van de wereld hetzelfde geschreven"
25320 DATA"worden,ook al noemt men het teken steeds"
25330 DATA"anders in de verschillende talen.",". "
25340 DATA". 8 = .... ....",". "
25350 DATA". Nederland/Duitsland : acht"
25360 DATA". Frankrijk           : huit"
25370 DATA". Engeland            : eight"
25380 DATA". Hongarije           : nyolc"
25390 DATA". Indonesie           : delapan"
25400 DATA". Spanje              : ocho"
25410 DATA". enz."
25420 DATA"#TALSTELSELS."
25430 DATA"Een talstelsel is weer iets heel anders"
25440 DATA"dan getallen."
25450 DATA". Hier stuiten we op beroemde namen als:"
25460 DATA"Gauss,Dirichlet,Dedekind en Legendre."
25470 DATA"Gottfried Wilhelm Leibniz (1646-1716)"
25480 DATA"noemde zijn algemene leer der symbolen (zeg:"
25490 DATA"zinvolle tekens) een"
25500 DATA". 'caballa vera'"
25510 DATA". (= een ware kaballa.Kaballa = Joodse"
25520 DATA"geheim- leer en wat daarmee in verband"
25530 DATA"staat.)"
25540 DATA". Kaballistische tekens zijn dus alleen"
25550 DATA"begrijpelijk voor ingewijden.",". "
25560 DATA"Ons tientallig-stelsel heeft de grote"
25570 DATA"verdienste, gemakkelijk te leren te"
25580 DATA"zijn.",". "
25590 DATA"De tegenwoordige cijferkunst werd hier"
25600 DATA"pas gemeengoed rond de 12e eeuw n. chr."
25610 DATA"Destijds streden twee rekenscholen om"
25620 DATA"de voorrang:",". "
25630 DATA". - de school der Abacisten en"
25640 DATA". - de school der Algorithmici."
25650 DATA"#De school der Abacisten."
25660 DATA"Abacus was de in de oudheid gebruikte"
25670 DATA"rekenplank."
25680 DATA". Een houten bord (ongeveer een dambord),"
25690 DATA"door vertikale lijnen in kolommen"
25700 DATA"verdeeld. De op een volgende kolommen"
25710 DATA"bevatten de z.g. termen van de schaal,"
25720 DATA"van rechts naar links:",". "
25730 DATA". eenheden"
25740 DATA". tientallen"
25750 DATA". honderdtallen"
25760 DATA". duizendtallen enz.",". "
25770 DATA"Om met de abacus te werken, legt men"
25780 DATA"in elke kolom de daarmee overeen komende"
25790 DATA"aantallen 'dam-schijven'.","# "
25800 DATA"voorbeeld:  1 3 4"
25810 DATA".         ---------"
25820 DATA".            O O O"
25830 DATA".              O O"
25840 DATA".              O O"
25850 DATA".                O",". "
25860 DATA"Moet men optellen, dan legt men het"
25870 DATA"tweede getal ook op die wijze op het"
25880 DATA"bord. Maar per kolom nooit meer dan"
25890 DATA"9 schijven.Overschrijdt men de 9 dan"
25900 DATA"neemt men 9 schijven weg en legt"
25910 DATA"1 schijf extra bij de kolom links"
25920 DATA"daarvan.",". "
25930 DATA"De Abacisten hebben de strijd verloren."
25940 DATA"#De Algorithmici winnaar !"
25950 DATA"Het woord 'Algorithmus' is een verbastering"
25960 DATA"van een naam, n.l. van:",". "
25970 DATA"'Abu Abd Allah Muhammad B. Musa"
25980 DATA"al-Huwarizmi' ook wel genoemd:"
25990 DATA". 'Mohammed ibn Musa Alchwarizmi' uit"
26000 DATA"Khorassan, die onder kalief Al Mamum"
26010 DATA"(814 - 833) te Bagdad leefde.",". "
26020 DATA". Mohammed ben Musa schreef in opdracht"
26030 DATA"van de Kalief een boek over rekenen"
26040 DATA"met Indische (z.g. Arabische) getal-"
26050 DATA"tekens, dus cijfers. Hij kende reeds"
26060 DATA"de NUL en schreef die als een klein"
26070 DATA"cirkeltje.",". "
26080 DATA"Mohammed ben Musa voerde het positie-"
26090 DATA"of plaatswaarde- stelsel in.Door de"
26100 DATA"Kruistochten en de Arabische hogescholen"
26110 DATA"in Toledo,Sevilla en Granada werden de"
26120 DATA"Arabische boeken in het latijn"
26130 DATA"vertaald en kwamen zo ter beschikking"
26140 DATA"van de westerse geleerden.Ook het boek"
26150 DATA"van Alchwarizmi over de Indische cijfers"
26160 DATA"behoorde daartoe."
26170 DATA". Het toverschrift van de Arabier had"
26180 DATA"de abacus verdreven !",". "
26190 DATA"Met de cijfers van 0 tot en met 9 en"
26200 DATA"de kennis van de tafeltjes van"
26210 DATA"vermenigvuldiging kon men de grootste"
26220 DATA"berekeningen foutloos uitvoeren."
26230 DATA". Het woord 'algorithmus' is dus zoveel"
26240 DATA"als een rekenmethode, die berust op een"
26250 DATA"bepaald tekenschrift.Tot in de 18e eeuw"
26260 DATA"noemde men elke tot regel geworden"
26270 DATA"bewerking: ALGORITHMUS."
26280 DATA"#Het TIENTALLIG stelsel."
26290 DATA"De sleutel van het geheim is het"
26300 DATA"PLAATS-WAARDE stelsel.",". "
26310 DATA".  (Het Romeinse cijfer-schrift is een"
26320 DATA".   voorbeeld van een schrijfwijze"
26330 DATA".   zonder plaatswaarde.",". "
26340 DATA".   MCMLX = 1960, want",". "
26350 DATA".    M = 1000"
26360 DATA".    C =  100 )hier klopt de volgorde"
26370 DATA".    M = 1000 )niet, dus - i.p.v.+"
26380 DATA".    L =   50         CM= 900"
26390 DATA".    X =   10         MC=1100",". "
26400 DATA".   Er is wel een verplichte volgorde"
26410 DATA".   van groot naar klein.)"
26420 DATA"#Een PLAATS-WAARDE stelsel."
26430 DATA"Een plaats-waarde stelsel is een"
26440 DATA"schrijfwijze van getallen, waarbij een"
26450 DATA"cijfer een andere waarde vertegenwoordigt,"
26460 DATA"als het op een andere plaats in het"
26470 DATA"getal staat.In het tientallig stelsel"
26480 DATA"is elke plaats links van de vorige 10x"
26490 DATA"zoveel waard. Bijvoorbeeld:",". "
26500 DATA".      7777 ="
26510 DATA".      ...."
26520 DATA".      .  ....   7"
26530 DATA".      .        70"
26540 DATA".      .       700"
26550 DATA".      .......7000"
26560 DATA".             ----"
26570 DATA".             7777"
26580 DATA"# ","In het 10-tallig stelsel is de waarde"
26590 DATA"van de plaatsen gebonden aan de machten"
26600 DATA"van 10.Van rechts naar links:",". "
26610 DATA".  10^0 =    1 , dus eenheden"
26620 DATA".  10^1 =   10 , dus 10-tallen"
26630 DATA".  10^2 =  100 , dus 100-tallen"
26640 DATA".  10^3 = 1000 , dus 1000-tallen"
26650 DATA".  enz.",". "
26660 DATA"In het 10-tallig stelsel gebruiken we"
26670 DATA"10 cijfersymbolen n.l.",". "
26680 DATA"0, 1, 2, 3, 4, 5, 6, 7, 8, 9."
26690 DATA"#      CIJFERS."
26700 DATA"Over de herkomst van het woord cijfer"
26710 DATA"en de cijfers zelf, leest men vele"
26720 DATA"verhalen:",". "
26730 DATA"-A. Rond de 2e en 3e eeuw n. chr kwamen"
26740 DATA"de Hindoes tot een belangrijke ontdekking:"
26750 DATA"n.l. het toekennen van betrekkelijke"
26760 DATA"waarde aan getaltekens en de uitvinding"
26770 DATA"van een teken voor NIETS, n.l. de NUL."
26780 DATA"De naam van dit teken: TZIPHRA vormt"
26790 DATA"de oorsprong van ons woord cijfer."
26800 DATA"De cijfers, die thans gebruikt worden,"
26810 DATA"zijn van Indische oorsprong. Zij waren"
26820 DATA"aanvankelijk de beginletters van de"
26830 DATA"namen der gehele getallen van 1 tot 9."
26840 DATA"Bij de Hindoes was dat mogelijk, omdat"
26850 DATA"die telwoorden met 9 verschillende letters"
26860 DATA"begonnen. De nul komt pas sinds de 4e"
26870 DATA"eeuw voor.",". "
26880 DATA"-B. Het Arabische woord al-sifr is de"
26890 DATA"vertaling van het Indische sunya= de lege,"
26900 DATA"(plek op het bord).In het Latijn volgens"
26910 DATA"Fibonacci (1202): zephirum of cephirum."
26920 DATA"Via het Italiaanse zevero en zepiro werd"
26930 DATA"dit verbasterd tot ZERO en CIFRA.Uit"
26940 DATA"cifra ontstond ons woord cijfer (dus"
26950 DATA"eigenlijk NUL.Het Frans hield zero voor"
26960 DATA"nul, evenals het Engels.)",". "
26970 DATA"Brahmegupta, een Hindoe uit 598, paste"
26980 DATA"de nul reeds consequent toe.",". "
26990 DATA"De nul is eigenlijk geen getal, maar"
27000 DATA"een op zichzelf staand grensbegrip en"
27010 DATA"tegelijk de oorsprong van alle getallen."
27020 DATA"De o kan dus ook als 'O' gelezen worden."
27030 DATA"De 'O' van origo = oorsprong."
27040 DATA"#Het TWEE-TALLIG stelsel."
27050 DATA"De computer kent maar twee toestanden:"
27060 DATA"AAN of UIT.Die zijn in cijfers weer te"
27070 DATA"geven:",". "
27080 DATA".  AAN = 1"
27090 DATA".  UIT = 0",". "
27100 DATA"Dat wordt dus het TWEE-TALLIG stelsel."
27110 DATA"De waarden van RECHTS naar LINKS:",". "
27120 DATA".     2^0 =  1"
27130 DATA".     2^1 =  2"
27140 DATA".     2^2 =  4"
27150 DATA".     2^3 =  8"
27160 DATA".     2^4 = 16, enz."
27170 DATA"# ","Het getal 1101 uit het 2-tallig"
27180 DATA"stelsel wordt in het 10-tallig stelsel:",". "
27190 DATA".      1101"
27200 DATA".     -------"
27210 DATA".         ."
27220 DATA".         ...1 * 2^0 = 1*1 = 1"
27230 DATA".        ....0 * 2^1 = 0*2 = 0"
27240 DATA".       .....1 * 2^2 = 1*4 = 4"
27250 DATA".      ......1 * 2^3 = 1*8 = 8"
27260 DATA".                          ---"
27270 DATA".          1101 (2-tallig) =13 (10-t.)",". "
27280 DATA"Het 2-tallig stelsel werd door Leibniz"
27290 DATA"in Rome opgesteld. Hij noemde het"
27300 DATA"dyadiek. Wij spreken van BINAIR."
27310 DATA"#GETALLEN-RECHTE."
27320 DATA"We kunnen de 'normale' getallen"
27330 DATA"aangeven op een lijn: de getallen-rechte:",". "
27340 DATA"..0..1..2..3..4..5..6..7..8..9..10..",". "
27350 DATA"Nul komt van: NULLA FIGURA= geen gedaante"
27360 DATA"(= cijfer).","# "
27370 DATA"..0..1..2..3..4..5..6..7..8..9..10..",". "
27380 DATA"De getallen op de rechte noemen we:",". "
27390 DATA".GEHELE getallen      ="
27400 DATA".    niet gebroken    = (3/4)"
27410 DATA".REELE getallen       ="
27420 DATA".    niet imaginair   = sqr(-1)"
27430 DATA".RATIONALE getallen   ="
27440 DATA".    niet irrationaal = e, sqr(2)"
27450 DATA".NATUURLIJKE getallen ="
27460 DATA".    niet gebroken    = (3/4) of"
27470 DATA".    gequalificeerd   = (-5 of +3)"
27480 DATA".POSITIEVE getallen   ="
27490 DATA".    niet negatief    = (-7)"
27500 DATA"# ","Bij de Hindoes (600 n.Chr.) treffen"
27510 DATA"we voor het eerst het onderscheid aan"
27520 DATA"tussen positieve en negatieve getallen."
27530 DATA"Zij verduidelijkten het begrip m.b.v."
27540 DATA". bezitting (+) en schuld (-)"
27550 DATA".en m.b.v. twee tegengestelde richtingen."
27560 DATA". ","In basicode kunnen we een negatief"
27570 DATA"getal van zijn teken ontdoen met de"
27580 DATA"opdracht: ABS(...)",". "
27590 DATA"Voorbeeld:"
27600 DATA".A=-20 : B=ABS(A) -> B=20"
27610 DATA"#BREUKEN"
27620 DATA". ..0.......1.......2......."
27630 DATA".     ^         ^"
27640 DATA".    1/4     1 1/2",". "
27650 DATA"Bij de breuk 1/4 is 1 de teller en"
27660 DATA"4 de noemer of 1 is het deeltal en 4"
27670 DATA"is de deler.",". "
27680 DATA"We kunnen dit ook schrijven als een"
27690 DATA"opdracht tot delen  1:7."
27700 DATA". (Leibniz 1684 in 'De maximis et de"
27710 DATA"minimis')",". "
27720 DATA"3/7 of 5/8 noemen we BREUKEN of GEBROKEN"
27730 DATA"GETALLEN."
27740 DATA"#BREUKEN, GEBROKEN GETALLEN."
27750 DATA"Tussen 2000 en 1700 voor Chr. schrijft"
27760 DATA"een Egyptenaar AHMES een leerboek over"
27770 DATA"breuken.",". "
27780 DATA"In 598 na Chr.wordt de Hindoe BRAHMEGUPTA"
27790 DATA"geboren,die later in een leerboek over"
27800 DATA"sterrenkunde twee hoofdstukken over"
27810 DATA"wiskunde schrijft.O.m.over het rekenen"
27820 DATA"met breuken:"
27830 DATA". - gelijknamig maken,"
27840 DATA". - gemengde getallen herleiden,"
27850 DATA". - breuken vermenigvuldigen,"
27860 DATA". - breuken op elkaar delen."
27870 DATA"#TIENDELIGE BREUKEN."
27880 DATA"Als we het breuk bevel uitvoeren, wordt"
27890 DATA"de uitkomst een tiendelige breuk. Bijv."
27900 DATA". 1/2 = 0.5 en 4/125 = 0.0312",". "
27910 DATA"Er zijn 3 gevallen mogelijk:",". "
27920 DATA" 1.De deling gaat 'op'."
27930 DATA". d.w.z.Na een aantal cijfers achter de"
27940 DATA"komma, is de deling klaar.Dit blijkt te"
27950 DATA"gebeuren, als de noemer uitsluitend"
27960 DATA"factoren 2 en 5 bevat.We hebben dan te"
27970 DATA"doen met een"
27980 DATA". -- EINDIGE 10-delige breuk. --",". "
27990 DATA" 2.De deling gaat NIET 'op'."
28000 DATA". Er blijken weer twee mogelijkheden:"
28010 DATA". A.er treedt tot in het oneindige een"
28020 DATA"herhaling op van een cijfer of cijfergroep,"
28030 DATA"die we periode noemen. Bijv."
28040 DATA".  1/3 = 0.333333...."
28050 DATA".  1/7 = 0.142857 142857 142857 ..."
28060 DATA". Dit zijn ZUIVER repeterende breuken."
28070 DATA". "," B.Eerst volgen een paar wisselende"
28080 DATA"cijfers, gevolgd door een vaste, zich"
28090 DATA"steeds herhalende groep. Bijv."
28100 DATA". 2929/11100 = 0.26 387 387 387 ..."
28110 DATA". Dit is een GEMENGD repeterende breuk."
28120 DATA"#IRRATIONALE GETALLEN."
28130 DATA".  --"
28140 DATA". V 5 = 2.2360679...."
28150 DATA". (In basicode: sqr(5) =square root)"
28160 DATA". Dit getal, met 'n niet eindigende reeks"
28170 DATA"cijfers achter de komma, blijkt niet uit"
28180 DATA"te drukken in een gewone breuk."
28190 DATA". Deze uitkomst is, zoals de Grieken sinds"
28200 DATA"Pythagoras zeiden: 'ALOGOS', niet uit"
28210 DATA"te spreken, onzinnig. Zij is in tegenspraak"
28220 DATA"met ons verstand, onze ratio. Daar vandaan:"
28230 DATA".  IRRATIONALE GETALLEN.",". "
28240 DATA"Er zijn 2 manieren om irrationale getallen"
28250 DATA"uit te drukken:",". "
28260 DATA". a.Als 10-delige breuk met niet eindigende"
28270 DATA"reeks cijfers achter de komma."
28280 DATA".  ---"
28290 DATA". V 2  = 1.4142135......",". "
28300 DATA"  b.Als een oneindig voort lopende reeks"
28310 DATA"breuken.Bekende voorbeelden:"
28320 DATA".            pi    1 1 1 1  1  1"
28330 DATA". Leibniz:   -- =1--+---+----+--....."
28340 DATA".             4    3 5 7 9 11 13",". "
28350 DATA". pi = 3.141 59 26 53 58 97 93 ...",". "
28360 DATA". Euler:     1  1  1  1  1"
28370 DATA".      e = 1+--+--+--+--+--+......"
28380 DATA".            1! 2! 3! 4! 5!",". "
28390 DATA". e = 2.718 28 18 28 45 90 45 23 53..."
28400 DATA"#IMAGINAIRE GETALLEN."
28410 DATA"a^2 kan ontstaan zijn uit:"
28420 DATA".   (+a)*(+a)      of uit:"
28430 DATA".   (-a)*(-a).",". "
28440 DATA"De wortel uit (a^2) kan dus zijn:"
28450 DATA". (+a) of (-a). Dat kan beide !",". "
28460 DATA"Bij de derde-machts-wortel speelt dit"
28470 DATA"NIET, want: (+a)^3 = +(a^3) en"
28480 DATA"(-a)^3 = -(a^3).Daardoor is",". "
28490 DATA" 3-------            3-----"
28500 DATA". V+(a^3)  = +a en    V-(a^3) = -a",". "
28510 DATA"Als we de tweede-machts wortel uit -6"
28520 DATA"willen weten,staan we voor een onoplosbaar"
28530 DATA"probleem. We kennen geen getal, dat tot"
28540 DATA"een EVEN MACHT gebracht, een NEGATIEF getal"
28550 DATA"als uitkomst heeft."
28560 DATA"#HET GETAL i."
28570 DATA"Euler voerde het teken 'i' in voor de"
28580 DATA"IMAGINAIRE eenheid in 1794.",". "
28590 DATA".        2----"
28600 DATA".    i = V (-1)",". "
28610 DATA"Het woord 'imaginair' komt het eerst"
28620 DATA"voor bij Descartes (Geometrie , 1637),"
28630 DATA"maar Bombelli (1572) had reeds de"
28640 DATA"vierkants- wortel uit negatieve getallen"
28650 DATA"ingevoerd.Hij noemde ze 'onmogelijke"
28660 DATA"getallen' en 'onbestaanbare getallen'.",". "
28670 DATA"De IMAGINAIRE getallen staan dus"
28680 DATA"tegenover de REELE, bestaanbare, getallen."
28690 DATA". ","Als imaginaire eenheid nemen we i."
28700 DATA". ","Bij definitie stellen we:"
28710 DATA".   i^2 = -1.",". "
28720 DATA"Deze eigenschap heeft het met geen enkel"
28730 DATA"reeel getal gemeen, daar het kwadraat van"
28740 DATA"een reeel getal slechts 0 of positief kan"
28750 DATA"zijn.",". "
28760 DATA"(a+b*i) noemen we een complex getal."
28770 DATA"Gauss (1831).",". "
28780 DATA"Terwijl men +1 kan beschouwen als een"
28790 DATA"lengte- eenheid, van een bepaald punt uit"
28800 DATA"in een bepaalde richting uitgezet, kan men"
28810 DATA"-1 beschouwen als een lengte- eenheid van"
28820 DATA"het zelfde punt af in tegen gestelde"
28830 DATA"richting uit gezet.Een draai van 180 graden"
28840 DATA"blijkt een vermenigvuldiging met -1. Stel"
28850 DATA"een draai van 90 gr. = * x, dan wordt 180"
28860 DATA"gr. x^2. En dat was -1. Hier uit volgt:"
28870 DATA".    x^2 = -1   en   x = sqr(-1) = i",". "
28880 DATA".   ---"
28890 DATA".  V(-1) stelt dus een rechte lijn voor,"
28900 DATA"die even lang is, van het zelfde punt"
28910 DATA"uit gaat, maar RECHTHOEKIG staat op de"
28920 DATA"eerste twee. (Argand, 1806).",". "
28930 DATA". Deze voorstelling heeft geleid tot een"
28940 DATA"verbinding van het begrip RICHTING met"
28950 DATA"het begrip RECHTE LIJN.Deze verbinding van"
28960 DATA"richting met rechte lijn wordt aan"
28970 DATA"geduid met de term VECTOR. (Hamilton"
28980 DATA"1801 - 1865)."
28990 DATA"#Werken met imaginaire getallen."
29000 DATA".  --   --      --      --        ---"
29010 DATA". V-9 *V-4 = i*V 9 * i*V 4 = i^2*V 36",". "
29020 DATA".Dat wordt dus: (-1)* 6 = -6",". "
29030 DATA"Leibniz legde Christiaan Huygens de"
29040 DATA"volgende vraag voor:",". "
29050 DATA"Bereken:sqr(1+sqr(-3)) + sqr(1-sqr(-3))",". "
29060 DATA".Leibniz beweerde,dat uit de som van de"
29070 DATA"2 wortels, die onder het wortel- teken"
29080 DATA"de SOM en het VERSCHIL van 1 met een"
29090 DATA"imaginaire wortel bevatten, een positief"
29100 DATA"reeel getal te voorschijn komt.Hier is"
29110 DATA"dat sqr(6) = 2,4494897."
29120 DATA". De oplossing schuilt in het product:"
29130 DATA". (a+b)^2 = a^2 + 2ab + b^2  Hier dus:"
29140 DATA". (sqr(1+sqr(-3)) + sqr(1-sqr(-3)))^2 ="
29150 DATA". 1+sqr(-3)+ 2*sqr(1-(-3))+ 1-sqr(-3) ="
29160 DATA". 1 + 2*sqr(4) + 1 ="
29170 DATA". 1 + 4        + 1 = 6",". "
29180 DATA"Dus sqr(1+sqr(-3)) + sqr(1-sqr(-3)) ="
29190 DATA".   sqr(6) = 2.4494897...."
29200 DATA"#TOEGEVOEGD COMPLEX."
29210 DATA"Hebben we te doen met 2 complexe getallen"
29220 DATA"in de vorm a+b*i en a-b*i, zoals die voor"
29230 DATA"kwamen in het probleem van Huygens-"
29240 DATA"Leibniz, dan noemt men die getallen:"
29250 DATA".  --- TOEGEVOEGD COMPLEX ---",". "
29260 DATA"Vermenigvuldiging van toegevoegd complexe"
29270 DATA"getallen, doet reele getallen ontstaan:"
29280 DATA". (a+b*i) * (a-b*i) ="
29290 DATA". a^2 - b^2 * i^2   ="
29300 DATA". a^2 + b^2"
29310 DATA". De i is er uit verdwenen !"
29320 DATA"#Het COMPLEXE VLAK"
29330 DATA"Men kan een vlak ook beschouwen als het"
29340 DATA"complexe vlak, zodat elk punt van dat"
29350 DATA"vlak beeldpunt is van een complex getal."
29360 DATA"Omgekeerd is elk beeldpunt van een"
29370 DATA"complex getal in dat vlak aan te geven."
29380 DATA". ","Gauss stelde, dat i de DRAAIINGS-"
29390 DATA"FACTOR van de getallenrechte is.De"
29400 DATA"imaginaire getallen- rechte staat"
29410 DATA"loodrecht op de reele."
29420 DATA"#Het COMPLEXE VLAK."
29430 DATA".              :"
29440 DATA".              :"
29450 DATA".              2........x (3+2*i)"
29460 DATA".              :        :"
29470 DATA".  (-2+i) x....1        :"
29480 DATA".         :    :        :"
29490 DATA"......-3.-2.-1.O..1..2..3..4.(reele as)"
29500 DATA".         :    :  :"
29510 DATA".  (-2-i) x...-1  :"
29520 DATA".              :  :"
29530 DATA".             -2  x  (1-2*i)"
29540 DATA".              :"
29550 DATA".              :"
29560 DATA".              :"
29570 DATA".              : (imaginaire as)"
29580 DATA"#De VOERSTRAAL."
29590 DATA".         :"
29600 DATA".         :"
29610 DATA".      b  :.......Q  (a+b*i)"
29620 DATA".         :      .:"
29630 DATA".         :     . :"
29640 DATA".         :  r .  :"
29650 DATA".         :   .   :"
29660 DATA".         :  .    :"
29670 DATA".         : . >A  :"
29680 DATA". ........O............."
29690 DATA".         :"
29700 DATA".         :       a"
29710 DATA".         :"
29720 DATA".         :",". "
29730 DATA". r=sqr(a^2+b^2)"
29740 DATA". cos A = a/r   dus a = r * cos A"
29750 DATA". sin A = b/r   dus b = r * sin A",". "
29760 DATA". a + b*i ="
29770 DATA". r* cos A + i * r * sin a"
29780 DATA"# "," ***********************************"
29790 DATA". * a + b*i =                       *"
29800 DATA". *           r * (cos A + i*sin A) *"
29810 DATA". ***********************************"
29820 DATA". 1. r=sqr(a^2+b^2) noemt men de modulus"
29830 DATA"of volstrekte waarde van a+b*i.",". "
29840 DATA". 2. A = het argument van a+b*i.",". "
29850 DATA". 3. OQ noemt men de voerstraal."
29860 DATA"#SCHEMA der GETALLEN."
29865 DATA"      -                     -"
29870 DATA".      :imaginair            :algebr."
29880 DATA".      :sqr(-1)  -           :sqr(2)"
29890 DATA". getal:         :irrationaal:"
29900 DATA".      :         :           :transc."
29910 DATA".      :         :           : e,pi"
29920 DATA".      :reeel    :           -"
29930 DATA".      -         :           -"
29940 DATA".                :           :nat.get."
29950 DATA".                :rationaal  :gebr.get."
29960 DATA".                -           :gequal.g."
29970 DATA".                            -"
29980 DATA"$$$$$"
30000 REM*****************************
30010 REM* HARRY EYCK / NEER         *
30020 REM* OP C.64 --- MAART 1989    *
30030 REM*****************************
30040 REM* COPYRIGHT NOS HILVERSUM   *
30050 REM*****************************
