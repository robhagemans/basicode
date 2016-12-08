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
 1000 A=600:GOTO 20:REM Hobbyscoop-krant
 1010 REM eerst scherm opmeten
 1020 GOSUB 100:GOSUB 120
 1030 HP=HO+1:PRINT" ";:GOSUB 120:IF HP=HO THEN 1030
 1040 GOSUB 100:GOSUB 120
 1050 VP=VE+1:PRINT:GOSUB 120:IF VP=VE THEN 1050
 1060 REM begin programma
 1070 DIM K$(6)
 1080 GOSUB 100:PRINT"HOBBYSCOOPKRANT"
 1090 PRINT:PRINT"Naar P)rinter of S)cherm ?";
 1100 GOSUB 210:GOSUB 1800
 1110 IF(IN$<>"P") AND(IN$<>"S") THEN 1100
 1120 PRINT IN$:PRINT
 1130 PT=1:IF IN$="S" THEN PT=0:GOTO 1310
 1140 PRINT"Hoeveel letters per regel ";
 1150 INPUT HP
 1160 PRINT:PRINT"Kantlijnbreedte ";
 1170 INPUT SP:GOSUB 1900:KL$=SP$
 1180 HP=HP-SP:IF SP>1 THEN HP=HP-SP+2
 1190 PRINT:PRINT"Hoeveel regels tekst per pagina ";
 1200 INPUT VP
 1210 PRINT:PRINT"K)ettingformulieren of L)osse vellen ?";
 1220 GOSUB 210:GOSUB 1800
 1230 IF(IN$<>"K") AND(IN$<>"L") THEN 1220
 1240 PRINT IN$:PRINT
 1250 KF=1:IF IN$="L" THEN KF=0:GOTO 1280
 1260 PRINT"Hoeveel lege regels onderaan vel ";
 1270 INPUT LR:PRINT
 1280 PRINT"Zet de printer klaar"
 1290 PRINT"en druk op een toets"
 1300 GOSUB 210
 1310 RT=0:H=0:N=1:KL=0
 1320 REM print de kop
 1330 K$(0)="******************************"
 1340 K$(1)="*     N.O.S.- HOBBYSCOOP     *"
 1350 K$(2)="*        RADIOTEKST          *"
 1360 K$(3)="*                            *"
 1370 K$(4)="*     geschreven door:       *"
 1380 K$(5)="*       Pim van Tend         *"
 1390 K$(6)="******************************"
 1400 GOSUB 100
 1410 SP=INT((HP-30)/2):IF PT=1 THEN SP=SP-3
 1420 GOSUB 1900
 1430 SR$=" ":GOSUB 20000
 1440 FOR I=0 TO 6:SR$=SP$+K$(I):GOSUB 20000:NEXT I
 1450 RESTORE:READ DD$
 1460 SR$=" ":GOSUB 20000
 1480 SP=INT((HP-LEN(DD$))/2):IF PT=1 THEN SP=SP-3
 1490 GOSUB 1900
 1500 SR$=SP$+DD$:GOSUB 20000
 1510 SR$=" ":GOSUB 20000
 1520 SR$="Zend uw reacties op onze":GOSUB 20000
 1530 SR$="beeldkrant aan:":GOSUB 20000
 1540 SR$=" ":GOSUB 20000
 1550 SR$="N.O.S. Hobbyscoop Beeldkrant,":GOSUB 20000
 1560 SR$="Postbus 1200,":GOSUB 20000
 1570 SR$="1200 BE Hilversum.":GOSUB 20000
 1580 A$="":REM print de overige data
 1590 READ BB$
 1600 GOSUB 23000
 1610 GOSUB 24000
 1620 IF KL=0 THEN 1600
 1630 END
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
23000 IF BB$="$$$$$" THEN KL=1:H=1:RETURN
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
25000 DATA"Uitleg 'Waar staat de maan?'"
25010 DATA"#WAAR STAAT DE MAAN?"
25020 DATA"Met behulp van het Basicode-2 programma 'Waar"
25030 DATA"staat de maan?' kunnen we snel en nauwkeurig"
25040 DATA"nagaan, waar aan de hemel de maan te vinden"
25050 DATA"is."
25060 DATA". "
25070 DATA"Nadat het programma gestart is, krijgen we op"
25080 DATA"het scherm de volgende vragen te"
25090 DATA"beantwoorden:"
25100 DATA". "
25110 DATA".Geografische breedte (nu 52.1 )?"
25120 DATA".Geografische lengte (nu 5.12 )?"
25130 DATA".Tijdsinterval (nu 15 minuten)?"
25140 DATA"#NIET MOEILIJK DOEN"
25150 DATA"Wanneer we geen zin hebben om moeilijk te"
25160 DATA"doen, kunnen we hierop eenvoudig reageren"
25170 DATA"door steeds alleen op de return- of"
25180 DATA"entertoets te drukken. Het programma rekent"
25190 DATA"dan uit, waar de maan staat, bekeken vanuit"
25200 DATA"Utrecht (want dat is de plaats waarmee de"
25210 DATA"gegeven geografische lengte en breedte"
25220 DATA"corresponderen). Het tijdsinterval geeft aan,"
25230 DATA"met welke tussentijden we later de positie"
25240 DATA"van de maan willen zien. Het"
25250 DATA"standaardinterval van 15 minuten is vaak wel"
25260 DATA"goed."
25270 DATA"#VIJF VRAGEN"
25280 DATA"Nu komen er een vijftal vragen, waarop het"
25290 DATA"programma in ieder geval wel een serieus"
25300 DATA"antwoord moet krijgen. We willen weten, waar"
25310 DATA"we de maan kunnen vinden op Sinterklaasavond."
25320 DATA"We geven dus op: 5 december 1988 om 19 uur."
25330 DATA". "
25340 DATA".Invoer:"
25350 DATA". "
25360 DATA".Dag van de maand (1-31)? 5"
25370 DATA".Maand (1-12)? 12"
25380 DATA".Jaar? 88"
25390 DATA". "
25400 DATA".Tijd: uren (1-23)? 19"
25410 DATA".Tijd: minuten (0-59)? 0"
25420 DATA"#ZOMER- EN WINTERTIJD"
25430 DATA"We hoeven ons hierbij niet te bekommeren om"
25440 DATA"zomer- of wintertijd. Het programma zoekt dat"
25450 DATA"zelf uit. Haarklovers zullen opmerken dat er"
25460 DATA"ieder jaar op de laatste zondag van september"
25470 DATA"(bij de overgang van zomer- naar wintertijd)"
25480 DATA"een moment is, waarvoor het programma het"
25490 DATA"niet zelf kan uitzoeken. Er is dan namelijk"
25500 DATA"een uur dat tweemaal voorkomt. Die"
25510 DATA"haarklovers worden uitgenodigd zelf uit te"
25520 DATA"proberen, wat er daar gebeurt."
25530 DATA"#JAARTAL"
25540 DATA"Het jaartal kunnen we opgeven als 88, maar"
25550 DATA"ook voluit als 1988. Mensen die hun tijd"
25560 DATA"vooruit zijn, kunnen de getallen 0 tot en met"
25570 DATA"19 invoeren voor de jaren 2000 tot en met"
25580 DATA"2019."
25590 DATA"#RESULTAAT"
25600 DATA"Als antwoord op onze vraag over"
25610 DATA"Sinterklaasavond 1988, toont het programma"
25620 DATA"ons het volgende scherm:"
25630 DATA". "
25640 DATA".maandag 5 december 1988"
25650 DATA".19: 0 wintertijd"
25660 DATA". "
25670 DATA"In de kop van het scherm wordt opgemerkt dat"
25680 DATA"in Nederland de wintertijd geldt. Dat"
25690 DATA"verbaast ons niet, want wintermaand is nu"
25700 DATA"eenmaal de bijnaam van december."
25710 DATA"#TELEURSTELLING"
25720 DATA"Ten opzichte van de horizon:"
25730 DATA".Hoogte: -42.65 graden"
25740 DATA".Azimut: 304.60 graden"
25750 DATA". "
25760 DATA"Onder de kop zien we de hoogte en het"
25770 DATA"zogeheten azimut van de maan. Maar oh, wat is"
25780 DATA"dat een teleurstelling! De hoogte is"
25790 DATA"negatief: de maan staat onder de horizon en"
25800 DATA"zal dus niet door de bomen schijnen. Bij de"
25810 DATA"hoogte is +90 graden recht boven ons hoofd,"
25820 DATA"in het zogeheten zenit. Zo hoog komt de maan"
25830 DATA"echter nooit."
25840 DATA"#AZIMUT"
25850 DATA"Het azimut is een getal dat aangeeft, waar"
25860 DATA"langs de horizon de maan te vinden is."
25870 DATA"Hierbij is nul graden het noorden, 90 graden"
25880 DATA"het oosten, 180 graden het zuiden en 270"
25890 DATA"graden het westen. De 304 graden die hier"
25900 DATA"vermeld staan, wijzen dus naar het"
25910 DATA"noordwesten."
25920 DATA"#STERREN"
25930 DATA"Tussen de sterren:"
25940 DATA".Rechte klimming: 13 uur 55 minuten"
25950 DATA".Declinatie: -16 graden 9 minuten"
25960 DATA".Breedte: -4.01 graden"
25970 DATA". "
25980 DATA"Behalve de plaats van de maan ten opzichte"
25990 DATA"van de horizon, wordt ook de positie van de"
26000 DATA"maan op een sterrenkaart aangegeven. Op een"
26010 DATA"sterrenkaart kent men rechte klimming en"
26020 DATA"declinatie, zoals op een wereldkaart lengte"
26030 DATA"en breedte bestaan. De poolster heeft een"
26040 DATA"declinatie +90. De declinatie is nul op de"
26050 DATA"hemelekwator. Deze boog loopt van oost naar"
26060 DATA"west, en bereikt in ons land aan de zuidhemel"
26070 DATA"een maximale hoogte van 38 graden. Dat is 90"
26080 DATA"graden min onze geografische breedte (52)."
26090 DATA"#BREEDTE EN DECLINATIE"
26100 DATA"De declinatie moeten we niet verwarren met de"
26110 DATA"breedte aan de hemel. De nullijn van de"
26120 DATA"breedte is niet de hemelekwator, maar de"
26130 DATA"dierenriem. De dierenriem of ecliptica is een"
26140 DATA"boog, die een hoek maakt met de hemelekwator."
26150 DATA"De ecliptica is de weg die de Zon in de loop"
26160 DATA"van het jaar aflegt. De breedte van de Zon is"
26170 DATA"dus altijd nul. De breedte van de maan"
26180 DATA"varieert van -5 tot +5 graden."
26190 DATA"#VERDUISTERINGEN"
26200 DATA"De breedte van de maan is een belangrijk"
26210 DATA"gegeven, wanneer het om verduisteringen gaat."
26220 DATA"Bij een maansverduistering staan Zon, Aarde"
26230 DATA"en maan precies op een lijn. Bij een"
26240 DATA"zonsverduistering is de volgorde Zon, maan,"
26250 DATA"Aarde. De drie hemellichamen kunnen alleen op"
26260 DATA"een lijn komen als vanaf de Aarde gezien"
26270 DATA"zowel de Zon als de maan op de ecliptica"
26280 DATA"staan. Met andere woorden, als ook de maan"
26290 DATA"een breedte nul heeft. Dat gebeurt twee maal"
26300 DATA"per maand. De plaatsen waar het gebeurt, zijn"
26310 DATA"de zogeheten knopen. Er is een klimmende en"
26320 DATA"een dalende knoop, bij toenemende"
26330 DATA"respectievelijk afnemende breedte van de"
26340 DATA"maan."
26350 DATA"#VOLLE EN NIEUWE MAAN"
26360 DATA"Niet alleen gaat de maan tweemaal per maand"
26370 DATA"door een knoop, ook staan Zon, maan en Aarde"
26380 DATA"tweemaal per maand ongeveer op een lijn: bij"
26390 DATA"volle en bij nieuwe maan. Meestal vallen deze"
26400 DATA"tijdstippen niet samen en meestal is er dus"
26410 DATA"geen verduistering. Is het volle maan in een"
26420 DATA"knoop, dan treedt een maansverduistering op."
26430 DATA"Valt de nieuwe maan in een knoop, dan is er"
26440 DATA"plaatselijk een zonsverduistering zichtbaar."
26450 DATA"Het is geen toeval dat het woord eclips voor"
26460 DATA"verduistering lijkt op het woord ecliptica,"
26470 DATA"de boog waarop de knopen liggen."
26480 DATA"#STERRETIJD"
26490 DATA"Na rechte klimming, declinatie en breedte"
26500 DATA"meldt ons programma nog:"
26510 DATA". "
26520 DATA".Plaatselijke sterretijd:"
26530 DATA".23 uur 19 minuten"
26540 DATA". "
26550 DATA"Dit gegeven heeft eigenlijk niets met de maan"
26560 DATA"te maken; het is een bijprodukt van het"
26570 DATA"programma. De sterretijd geeft aan, welke"
26580 DATA"rechte klimming op het moment in het zuiden"
26590 DATA"staat. Met andere woorden, aan de sterretijd"
26600 DATA"is de stand van de hemelbol af te lezen."
26610 DATA". "
26620 DATA"#VERVOLG KIEZEN"
26630 DATA"Het programma biedt nu een aantal"
26640 DATA"keuzemogelijkheden:"
26650 DATA". "
26660 DATA".     'S':     andere tijd opgeven"
26670 DATA".     'D':     andere datum opgeven"
26680 DATA".     'E':     programma stoppen"
26690 DATA".Andere toets: volgende tijdstip"
26700 DATA"#DE TIJD DOORLOPEN"
26710 DATA"Hierbij valt op te merken dat de kleine"
26720 DATA"letters s, d en e dezelfde uitwerking hebben"
26730 DATA"als de hoofdletters. Wanneer we een andere"
26740 DATA"toets kiezen, presenteert het programma ons"
26750 DATA"de positie van de maan een kwartier later."
26760 DATA"Als we bij de vraag tijdsinterval in het"
26770 DATA"begin een nieuwe waarde hadden ingevoerd, dan"
26780 DATA"is de tijdstap niet een kwartier, maar het"
26790 DATA"opgegeven aantal minuten. Het is mogelijk"
26800 DATA"achteruit te lopen. Willen we steeds een dag"
26810 DATA"terug bijvoorbeeld, dan geven we aan het"
26820 DATA"begin van het programma een tijdsinterval van"
26830 DATA"-1440 minuten op."
26840 DATA"#OPKOMST"
26850 DATA"Door geduldig stapsgewijs verder te gaan"
26860 DATA"kunnen we in ons voorbeeld uitvinden, wanneer"
26870 DATA"de maan weer opkomt. De uitkomst kunnen we"
26880 DATA"vergelijken met de tijd die iedere dag bij"
26890 DATA"het weerbericht in de krant wordt vermeld."
26900 DATA"Het verschil zal niet meer bedragen dan een"
26910 DATA"paar minuten."
26920 DATA"#WANNEER WEL?"
26930 DATA"In dit voorbeeld vonden we het toch wel"
26940 DATA"jammer dat we de maan 's avonds niet konden"
26950 DATA"zien. Wanneer zou de maan die dag wel te zien"
26960 DATA"zijn? Met de gegevens op het scherm kunnen we"
26970 DATA"dat ongeveer afschatten."
26980 DATA"#RECHTE KLIMMING EN STERRETIJD"
26990 DATA"We moeten dan de sterretijd en de rechte"
27000 DATA"klimming met elkaar vergelijken. Op het"
27010 DATA"moment dat de sterretijd gelijk is aan de"
27020 DATA"rechte klimming, staat de maan in het zuiden."
27030 DATA"Nu was de rechte klimming 13 uur 55 minuten,"
27040 DATA"de sterretijd 23 uur 19 minuten. De"
27050 DATA"sterretijd is dus te laat, en wel 9 uur en 24"
27060 DATA"minuten. (Immers 13 uur 55 plus 9 uur 24 is"
27070 DATA"23 uur 19.) De sterretijd verloopt ongeveer"
27080 DATA"(maar niet precies) even snel als de gewone"
27090 DATA"tijd. Wat we dus moeten doen, is 9 uur en 24"
27100 DATA"minuten terug gaan in de tijd. Het was nu 19"
27110 DATA"uur, gaan we zover terug, dan is het 9 uur 36"
27120 DATA"in de ochtend, iets over half tien dus."
27130 DATA"#NIEUWE TIJD OPGEVEN"
27140 DATA"Wat we doen, is de s indrukken voor een"
27150 DATA"nieuwe tijd, en dan geven we op:"
27160 DATA". "
27170 DATA".Tijd: uren (1-23)? 9"
27180 DATA".Tijd: minuten (0-59)? 36"
27190 DATA". "
27200 DATA"#RESULTAAT"
27210 DATA"Er komt:"
27220 DATA". "
27230 DATA".maandag 5 december 1988"
27240 DATA".9:36 wintertijd"
27250 DATA". "
27260 DATA".Ten opzichte van de horizon:"
27270 DATA".Hoogte:  23.61 graden"
27280 DATA".Azimut: 184.36 graden"
27290 DATA"#IN HET ZUIDEN"
27300 DATA"Het zuiden heeft een azimut van 180 graden,"
27310 DATA"184 is iets voorbij het zuiden. We zijn dus"
27320 DATA"inderdaad uitgekomen, waar we wezen wilden."
27330 DATA"De hoogte van de maan is bijna 24 graden,"
27340 DATA"niet erg hoog, maar in ieder geval boven de"
27350 DATA"horizon."
27360 DATA"#STERREN"
27370 DATA"Tussen de sterren:"
27380 DATA".Rechte klimming: 13 uur 37 minuten"
27390 DATA".Declinatie: -14 graden 12 minuten"
27400 DATA".Breedte: -3.75 graden"
27410 DATA". "
27420 DATA"Vergelijken we de positie tussen de sterren,"
27430 DATA"dan zien we dat die niet zo heel veel"
27440 DATA"verschilt van de waarden later om 19 uur."
27450 DATA"Terwijl de maan ten opzichte van de horizon"
27460 DATA"iedere dag een complete omloop maakt, neemt"
27470 DATA"de tocht tussen de sterren door bijna een"
27480 DATA"maand."
27490 DATA"#BIJNA RAAK"
27500 DATA"Plaatselijke sterretijd:"
27510 DATA".13 uur 54 minuten"
27520 DATA". "
27530 DATA"De sterretijd ligt aardig in de buurt van de"
27540 DATA"rechte klimming, zoals we het ook bedoeld"
27550 DATA"hadden. Desgewenst kunnen we de sterretijd"
27560 DATA"gebruiken om de tijd van doorgang door het"
27570 DATA"zuiden nauwkeuriger te schatten. In dit geval"
27580 DATA"moeten we voor de volgende benadering 17"
27590 DATA"minuten terug (van 54 naar 37 in de"
27600 DATA"sterretijd)."
27610 DATA"#ENSCHEDE"
27620 DATA"Hoeveel verschil is er in de stand van de"
27630 DATA"maan tussen verschillende plaatsen in"
27640 DATA"Nederland? Stel eens dat we niet de gegevens"
27650 DATA"willen weten voor Utrecht, maar voor"
27660 DATA"Enschede. In de atlas vinden we dat Enschede"
27670 DATA"ligt op 52 graden 38 minuten noorderbreedte"
27680 DATA"en 5 graden 49 minuten oosterlengte. Die"
27690 DATA"minuten moeten we even omrekenen naar delen"
27700 DATA"van een graad. Een graad is 60 minuten, we"
27710 DATA"rekenen dus uit: 38/60=0.63 en 49/60=0.82."
27720 DATA"#OPNIEUW STARTEN"
27730 DATA"Het programma moet nu even opnieuw gestart"
27740 DATA"worden. Sla de e van Einde aan, en run het"
27750 DATA"programma opnieuw. Nu voeren we wel wat in"
27760 DATA"bij de beginvragen:"
27770 DATA". "
27780 DATA".Geografische breedte (nu 52.1 )? 52.63"
27790 DATA".Geografische lengte (nu 5.12 )? 5.82"
27800 DATA".Tijdsinterval (nu 15 minuten)?"
27810 DATA"#HALF TIEN IN ENSCHEDE"
27820 DATA"Het resultaat voor 9 uur 36 komt er nu zo uit"
27830 DATA"te zien:"
27840 DATA". "
27850 DATA".maandag 5 december 1988"
27860 DATA".9:36 wintertijd"
27870 DATA". "
27880 DATA".Ten opzichte van de horizon:"
27890 DATA".Hoogte:  23.05 graden"
27900 DATA".Azimut: 185.09 graden"
27910 DATA"#LAGER EN WESTELIJKER"
27920 DATA"De maan staat iets lager, omdat we"
27930 DATA"noordelijker zitten. Hij staat ook iets meer"
27940 DATA"naar het westen (dichter bij zijn ondergang),"
27950 DATA"omdat we zelf oostelijker zitten. Veel maakt"
27960 DATA"het allemaal niet uit. Het is dus best in"
27970 DATA"orde om steeds gewoon met de gegevens voor"
27980 DATA"Utrecht te werken. Wat de sterretijd aangaat,"
27990 DATA"is het in het oostelijke Enschede drie"
28000 DATA"minuten later dan in Utrecht."
28010 DATA". "
28020 DATA".Plaatselijke sterretijd:"
28030 DATA".13 uur 57 minuten"
28040 DATA"#VAST TEN OPZICHTE VAN STERREN"
28050 DATA"De plaats van de maan tussen de sterren is"
28060 DATA"precies gelijk aan de waarden gevonden voor"
28070 DATA"Utrecht. Dat is logisch, want om die waarden"
28080 DATA"uit te rekenen gebruikt het programma de"
28090 DATA"geografische positie helemaal niet. Dat is"
28100 DATA"niet helemaal terecht en we zien hier de"
28110 DATA"beperkingen van de rekenmethode."
28120 DATA"#MIDDELPUNT AARDE"
28130 DATA"De gegeven positie tussen de sterren geldt"
28140 DATA"strikt genomen voor een waarnemer in het"
28150 DATA"middelpunt van een doorzichtige Aarde."
28160 DATA"Wanneer we staan op de lijn middelpunt Aarde"
28170 DATA"middelpunt maan, dan geldt die positie ook"
28180 DATA"voor ons. Staan we iets opzij van die lijn,"
28190 DATA"dan zien we de maan ook op een iets andere"
28200 DATA"plaats ten opzichte van de sterren. Daarmee"
28210 DATA"houdt het programma geen rekening. Voor"
28220 DATA"normaal gebruik is dat helemaal niet erg,"
28230 DATA"maar het programma is zo niet geschikt om"
28240 DATA"bedekkingen van een ster door de maan"
28250 DATA"nauwkeurig te voorspellen."
28260 DATA"#SCHIJNGESTALTE"
28270 DATA"Iets anders wat het programma ons niet kan"
28280 DATA"vertellen, is de schijngestalte van de maan."
28290 DATA"Daarvoor, en voor verduisteringen, is er het"
28300 DATA"eerdere programma 'Maneschijn' (zie Aarde en"
28310 DATA"Kosmos, 3/87, bladzijde 312-316, ook door"
28320 DATA"Hobbyscoop uitgezonden). Met een beetje"
28330 DATA"nadenken kunnen we echter ook 'Waar staat de"
28340 DATA"maan' gebruiken om te zien, hoe de maan"
28350 DATA"verlicht is."
28360 DATA"#TEN OPZICHTE VAN ZON"
28370 DATA"In ons voorbeeld ging de maan door het zuiden"
28380 DATA"om ongeveer half tien 's morgens. De zon gaat"
28390 DATA"door het zuiden iets voor een uur 's middags,"
28400 DATA"bij zomertijd iets voor twee uur. De maan is"
28410 DATA"eerder, en staat dus rechts van de zon. Dat"
28420 DATA"betekent dat de maan aan de linkerkant"
28430 DATA"beschenen wordt. Een tijdsverschil tussen zon"
28440 DATA"en maan van zes uur komt overeen met een half"
28450 DATA"verlichte maan. In ons geval is het"
28460 DATA"tijdsverschil iets meer dan drie uur. De maan"
28470 DATA"is dus voor minder dan de helft aan de"
28480 DATA"linkerkant verlicht."
28490 DATA"#VERSMADEN"
28500 DATA"De formules in het programma zijn nauwkeurig"
28510 DATA"genoeg om het programma heel dicht in de"
28520 DATA"buurt te laten komen van de posities, zoals"
28530 DATA"die zijn opgegeven in de Sterrengids. Sommige"
28540 DATA"computers versmaden echter die"
28550 DATA"nauwkeurigheid: ze rekenen met te weinig"
28560 DATA"decimalen. Gevolg is dat de maan of de tijd"
28570 DATA"met schokjes lijken te bewegen. De maan kan"
28580 DATA"daarbij een halve graad (zijn eigen"
28590 DATA"middellijn) afraken van zijn ware positie."
28600 DATA"Soms is er wat aan te doen. In de voorloper"
28610 DATA"voor de MSX bijvoorbeeld staat in regel 21"
28620 DATA"DEFSNG, waardoor de computer met enkele"
28630 DATA"nauwkeurigheid gaat rekenen. Veranderen we"
28640 DATA"dit in DEFDBL (dubbele nauwkeurigheid), dan"
28650 DATA"kunnen we het onderste uit de kan halen. Wat"
28660 DATA"rekentijd betreft is er nauwelijks verschil."
28670 DATA"#NOG KLACHTEN?"
28680 DATA"Mocht iemand nog onvolkomenheden vinden in de"
28690 DATA"werking van het programma, dan horen we dat"
28700 DATA"graag."
28710 DATA"$$$$$"
30000 REM
30010 REM Pim van Tend
30020 REM Veldheimwg 8
30030 REM 6871 CD  RENKUM
30040 REM 08373 - 15358
30050 REM
30060 REM COPYRIGHT 1988 NOS HILVERSUM
