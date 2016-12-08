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
 1010 GOSUB 100:REM Hobbyscoop-krant
 1020 REM Eerst scherm opmeten
 1030 I=0:J=I:VE=I:IP=64:JP=IP:FOR A=1 TO 7
 1040 I=I+IP:HO=I:GOSUB 110:GOSUB 120:IF HO<>I THEN I=I-IP
 1050 J=J+JP:VE=J:GOSUB 110:GOSUB 120:IF VE<>J THEN J=J-JP
 1060 IP=IP/2:JP=JP/2:NEXT A:HP=I+1:VP=J+1
 1070 REM Begin programma
 1080 DIM K$(6):KL$="":N=1:GOSUB 100
 1090 PRINT"HOBBYSCOOPKRANT":PRINT:PRINT
 1100 PRINT"Naar P)rinter of S)cherm ?";
 1110 GOSUB 1490:IF(IN$<>"P") AND(IN$<>"S") THEN 1110
 1120 PRINT IN$:PRINT:PT=1:IF IN$="S" THEN PT=0:GOTO 1250
 1130 PRINT"Hoeveel letters per regel ";:INPUT HP
 1140 PRINT:PRINT"Kantlijnbreedte ";:INPUT SP:GOSUB 1510
 1150 KL$=SP$:HP=HP-SP:IF SP>1 THEN HP=HP-SP+2
 1160 PRINT:PRINT"Hoeveel regels tekst per pagina ";
 1170 INPUT VP
 1180 PRINT:PRINT"K)ettingformulieren of L)osse vellen ?";
 1190 GOSUB 1490:IF(IN$<>"K") AND(IN$<>"L") THEN 1190
 1200 PRINT IN$:PRINT:KF=1:IF IN$="L" THEN KF=0:GOTO 1230
 1220 PRINT"Hoeveel lege regels onderaan vel ";:INPUT LR
 1230 PRINT:PRINT"Zet de printer klaar"
 1240 PRINT"en druk op een toets":GOSUB 210
 1250 RT=0:H=0:REM print de kop
 1260 K$(0)="******************************"
 1270 K$(1)="*     N.O.S.- HOBBYSCOOP     *"
 1280 K$(2)="*         BEELDKRANT         *"
 1290 K$(3)="*   ======================   *"
 1300 K$(4)="*      DE UITLEG VAN DE      *"
 1310 K$(5)="* PROGRAMMEERBARE CALCULATOR *"
 1320 K$(6)="******************************"
 1330 GOSUB 100:SP=INT((HP-30)/2):IF PT=1 THEN SP=SP-3
 1340 GOSUB 1510:SR$=" ":GOSUB 20000
 1350 FOR I=0 TO 6:SR$=SP$+K$(I):GOSUB 20000:NEXT I
 1360 RESTORE:SR$=" ":GOSUB 20000:SR$=" "
 1370 GOSUB 20000
 1380 SR$="Zend uw bijdragen voor onze":GOSUB 20000
 1390 SR$="beeldkrant aan:":GOSUB 20000
 1400 SR$=" ":GOSUB 20000
 1410 SR$="N.O.S. Hobbyscoop Beeldkrant,":GOSUB 20000
 1420 SR$="Postbus 1200,":GOSUB 20000
 1430 SR$="1200 BE Hilversum.":GOSUB 20000
 1440 A$="":REM print de overige data
 1450 READ BB$
 1460 GOSUB 23000
 1470 GOSUB 24000
 1480 GOTO 1460
 1490 GOSUB 210:IF(IN$<"a") OR(IN$>"z") THEN RETURN
 1500 IN$=CHR$(ASC(IN$)-ASC("a")+ASC("A")):RETURN
 1510 SP$="":IF SP<1 THEN RETURN
 1520 FOR I=1 TO SP:SP$=SP$+" ":NEXT I
 1530 RETURN
20000 REM afdruk subroutine
20010 IF SR$="" THEN RETURN
20020 IF PT=1 THEN 20060
20030 PRINT SR$
20040 RT=RT+1:IF RT=VP-4 THEN 21000
20050 RETURN
20060 SR$=KL$+SR$:GOSUB 350:GOSUB 360:RT=RT+1
20070 IF RT=VP THEN 22000
20080 RETURN
21000 REM scherm vol
21010 IF RT=0 THEN RETURN
21020 HO=0:VE=VP-1:GOSUB 110
21030 PRINT"<Toets voor verder>";
21040 RT=0:GOSUB 210:GOSUB 100:RETURN
22000 REM papier vol
22010 IF KF=1 THEN FOR I=1 TO LR:GOSUB 360:NEXT I:GOTO 22050
22020 PRINT"Zet de printer bovenaan nieuwe pagina"
22030 PRINT"en druk daarna op een toets."
22040 GOSUB 210:GOSUB 100
22050 RT=0:N=N+1:SR=N:GOSUB 300:N$=SR$
22060 SR$="Uitleg Programmeerbare Calculator....."+N$
22070 RL=LEN(SR$):GOSUB 20060:SR$=""
22080 FOR I=1 TO RL:SR$=SR$+"-":NEXT I
22090 GOSUB 20060:SR$=" ":GOSUB 20060:RETURN
23000 IF BB$="$" THEN H=1:GOSUB 24000:END
23010 IF RIGHT$(A$,1)<>"%" THEN 23030
23020 A$=LEFT$(A$,LEN(A$)-1):GOTO 23040
23030 IF A$<>"" THEN A$=A$+" "
23040 A$=A$+BB$:READ BB$
23050 IF LEFT$(BB$,1)="#" THEN H=1:RETURN
23060 IF LEFT$(BB$,1)="." THEN H=1:RETURN
23070 IF A$=". " THEN RETURN
23080 IF LEFT$(A$,1)="#" THEN RETURN
23090 IF(LEN(A$)<HP) OR(RIGHT$(A$,1)="%") THEN 23000
23100 RETURN
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
25000 DATA"#UITLEG 'PROGRAMMEERBARE CALCULATOR'"
25010 DATA"Normaal rekenen computers met een eindige"
25020 DATA"precisie. Hierdoor kunnen cijfers wegvallen"
25030 DATA"bij erg grote getallen. Ook kun je niet"
25040 DATA"zomaar eventjes pi benaderen in bijvoorbeeld"
25050 DATA"50 decimalen: de meeste computers geven het"
25060 DATA"al op na acht decimalen. Sommigen komen tot"
25070 DATA"15, maar veel meer dan dat zit er bij gewone"
25080 DATA"microcomputers niet in.",". ",".Deze"
25090 DATA"'programmeerbare calculator' kan met meer"
25100 DATA"dan 8 cijfers achter de komma rekenen. De"
25110 DATA"getallen worden dan ook niet in gewone,"
25120 DATA"numerieke variabelen opgeslagen, maar in"
25130 DATA"stringvariabelen. Hierdoor kunnen veel"
25140 DATA"grotere getallen gebruikt worden. Sommige"
25150 DATA"computers kunnen echter ook strings niet"
25160 DATA"onbeperkt lang maken. Vaak is 255 tekens de"
25170 DATA"limiet. Op deze computers kan het programma"
25180 DATA"dus ook geen langere getallen verwerken."
25190 DATA"#NADEEL","Helaas schuilt er ook nog een"
25200 DATA"adder onder het gras. De normale"
25210 DATA"rekenroutines in de computer zijn geschreven"
25220 DATA"in machinecode, en zijn dus zeer snel. De"
25230 DATA"rekenroutines in het programma zijn"
25240 DATA"geschreven in BASICODE, BASIC dus, en dit is"
25250 DATA"vele malen trager. Twee getallen van 10"
25260 DATA"cijfers vermenigvuldigen kost al gauw 10 tot"
25270 DATA"15 seconden. Maar, dit programma is ook niet"
25280 DATA"bedoeld om simpele berekeningen uit te"
25290 DATA"voeren, maar juist erg lange. Geen computer"
25300 DATA"zal je bijvoorbeeld zomaar kunnen vertellen"
25310 DATA"of 3^1988 + 6^1988 deelbaar is door 17! Dit"
25320 DATA"programma kan het voor je uitrekenen.... Als"
25330 DATA"je geduld hebt!","#PROGRAMMEREN","Om het"
25340 DATA"maken van kettingberekeningen, nodig voor"
25350 DATA"bijvoorbeeld het benaderen van pi,"
25360 DATA"gemakkelijk te maken, is de calculator te"
25370 DATA"programmeren in een eenvoudige taal, met"
25380 DATA"enkele simpele commando's. Deze 'taal' is"
25390 DATA"echter geenszins volledig, het is alleen"
25400 DATA"geschikt om relatief eenvoudige berekeningen"
25410 DATA"uit te voeren. Er bestaat bijvoorbeeld geen"
25420 DATA"'IF' commando, zodat het programma altijd"
25430 DATA"een vast bepaalde loop heeft. Er zijn echter"
25440 DATA"wel herhalingsfuncties. (Vergelijkbaar met"
25450 DATA"FOR/NEXT in basic).","#DE INSTRUCTIES","De"
25460 DATA"calculator heeft 10 geheugens voor getallen,"
25470 DATA"genummerd van M0 tot en met M9. Alle"
25480 DATA"bewerkingen hebben betrekking op geheugens."
25490 DATA"Een voorbeeld van een bewerking is:",". "
25500 DATA".M0 = M0 * M1",". ",".Deze instructie"
25510 DATA"berekent het produkt van M0 en M1, en zet"
25520 DATA"het resultaat in M0 terug. Zo zien de"
25530 DATA"instructies voor optellen, aftrekken en"
25540 DATA"delen er ook uit.",". ",".Machtsverheffen"
25550 DATA"werkt iets anders. Zo'n bewerking ziet er"
25560 DATA"bijvoorbeeld als volgt uit:",". ",".M0 = M1"
25570 DATA"^ 16",". ",".De exponent (In het voorbeeld"
25580 DATA"dus 16) wordt niet uit een geheugen gehaald."
25590 DATA"Dit kan namelijk een gebroken getal zijn, en"
25600 DATA"de routine voor het machtsverheffen moet een"
25610 DATA"integer getal als exponent hebben. Dit"
25620 DATA"betekent echter niet, dat je alleen getallen"
25630 DATA"tot een vaste macht kunt verheffen: er"
25640 DATA"bestaat een aparte groep integer variabelen."
25650 DATA"#PRECISIE","Bij bepaalde commando's, zoals"
25660 DATA"het delen van 2 getallen op elkaar, kan het"
25670 DATA"voorkomen dat er oneindig veel cijfers"
25680 DATA"achter de komma ontstaan. Om dit te"
25690 DATA"voorkomen is er het commando PRECISIE,"
25700 DATA"waarachter een integer getal moet staan. Het"
25710 DATA"programma rondt de getallen af op het"
25720 DATA"aangegeven aantal cijfers achter de komma,"
25730 DATA"eventueel naar boven. Getallen die al in een"
25740 DATA"geheugen zitten, worden niet veranderd door"
25750 DATA"dit commando; alleen uitkomsten van"
25760 DATA"bewerkingen worden afgerond, en getallen die"
25770 DATA"je invoert.","#INTEGER VARIABELEN","Zoals"
25780 DATA"gezegd bestaat er ook een herhaal"
25790 DATA"instructie. Deze instructie is vergelijkbaar"
25800 DATA"met de FOR/NEXT in BASIC. Voorbeeld:",". "
25810 DATA".HERHAAL #0;12","...andere instructies.."
25820 DATA".TERUG #0",". ",".De #0 in de herhaal"
25830 DATA"instructie is de variabele. Deze hoef je"
25840 DATA"niet zelf op te geven. De eerste herhaal"
25850 DATA"instructie krijgt variabele #0, de tweede #1"
25860 DATA"enz. De 'andere instructies' in het"
25870 DATA"voorbeeld worden 12 keer uitgevoerd, met"
25880 DATA"resp. de waarden 1,2,3 etc t/m 12 in #0."
25890 DATA"Deze variabele #0 kan gebruikt worden in"
25900 DATA"andere instructies, overal waar een integer"
25910 DATA"getal verwacht wordt.","#ANDERE INSTRUCTIES"
25920 DATA"De berekeningen werken dus met geheugens, en"
25930 DATA"niet direct met getallen. Om met getallen te"
25940 DATA"werken, moet eerst een geheugen 'geladen'"
25950 DATA"worden met een getal. Hiervoor is de Invoer"
25960 DATA"instructie. De vorm van deze instructie is:"
25970 DATA". ",".M0 = +12",".of",".M1 = -3.14159",".of"
25980 DATA".M0 = #0",". ",".Het plusteken bij de eerste"
25990 DATA"hoef je niet in te tikken, het mag wel."
26000 DATA".Je kunt ook geheugeninhouden verplaatsen"
26010 DATA"met de invoer instructie. De vorm is dan:"
26020 DATA". ",".M3 = M4",". ",".De invoer instructie"
26030 DATA"moet je niet verwarren met bewerkingen: bij"
26040 DATA"bewerkingen worden berekeningen uitgevoerd,"
26050 DATA"bij de invoer instructie worden alleen"
26060 DATA"waarden verplaatst."
26070 DATA"#GEHEUGENINHOUD AFDRUKKEN","De laatste 5"
26080 DATA"instructies zijn voor het afdrukken van een"
26090 DATA"geheugen. Het eigenlijke afdrukken gebeurt"
26100 DATA"met het BEKIJK commando:",". ",".BEKIJK M0"
26110 DATA". ",".Je kunt kiezen tussen normale en"
26120 DATA"wetenschappelijke notatie. Dit wordt"
26130 DATA"ingesteld dmv de instructies NORMAAL en"
26140 DATA"WETENS. Verder kun je nog instellen of een"
26150 DATA"getal op het scherm of op de printer moet"
26160 DATA"komen: hiervoor zijn de instructies PRINTER"
26170 DATA"AAN en PRINTER UIT.","#DE EDITOR","De"
26180 DATA"editor, waarmee je het programma kunt"
26190 DATA"invoeren en veranderen, is erg eenvoudig"
26200 DATA"gehouden. Alle editorcommando's staan in een"
26210 DATA"hulpschermpje, en er staat ook bij wat ze"
26220 DATA"doen; ik zal daarover hier dus niet"
26230 DATA"uitwijden.","#HET INVOEREN VAN INSTRUCTIES"
26240 DATA"De instructies hoeven niet helemaal te"
26250 DATA"worden ingetikt. Onderaan het invoerscherm"
26260 DATA"staan de letters die je kunt gebruiken. Dit"
26270 DATA"is meestal de eerste letter van de"
26280 DATA"instructie, behalve bij de rekeninstructies,"
26290 DATA"die allemaal worden aangeroepen met de B"
26300 DATA"(van Bewerking), Printer Aan/Uit (met resp A"
26310 DATA"en U), en Bekijk (met de K)."
26320 DATA"#HET UITVOEREN VAN EEN PROGRAMMA","Het"
26330 DATA"uitvoeren van een programma gaat door in het"
26340 DATA"hoofdmenu op S (start) te drukken. Er"
26350 DATA"verschijnt een scherm, waarop af te lezen is"
26360 DATA"welke waarden in de integervariabelen"
26370 DATA"zitten, en uit hoeveel cijfers de getallen"
26380 DATA"in de geheugens bestaan. (Je ziet dus niet"
26390 DATA"het getal zelf!). Op deze manier kun je de"
26400 DATA"loop van het programma volgen, en eventuele"
26410 DATA"fouten ontdekken. Als er een getal afgedrukt"
26420 DATA"wordt, verdwijnt dit scherm. Het programma"
26430 DATA"kan voortijdig gestopt worden met de 'Q'"
26440 DATA"toets.","#VOORBEELDPROGRAMMA'S","Hier volgen"
26450 DATA"enkele kant-en-klare programma's. De"
26460 DATA"programma's zijn als listing, maar ook in"
26470 DATA"code opgeschreven. Deze code kan in het"
26480 DATA"hoofdmenu ingevoerd worden, en is een snel"
26490 DATA"alternatief voor het intikken van de"
26500 DATA"programma's.",".De rekentijd die erbij staat"
26510 DATA"aangegeven, is natuurlijk sterk afhankelijk"
26520 DATA"van de computer waar het programma op"
26530 DATA"draait. Op een erg langzame computer, zoals"
26540 DATA"b.v. de ZX Spectrum (waar het programma op"
26550 DATA"gemaakt is) kunnen de tijden wel met 2"
26560 DATA"vermenigvuldigd worden; op snelle machines"
26570 DATA"zoals de BBC kan het wat vlugger lopen dan"
26580 DATA"staat aangegeven.","#HET GRAANKORRELPROBLEEM"
26590 DATA"Het verhaal gaat, dat de ontdekker van het"
26600 DATA"schaakspel als beloning aan de keizer vroeg,"
26610 DATA"op het eerste veld van het schaakbord 1"
26620 DATA"graankorrel te leggen, op de tweede 2, de"
26630 DATA"derde 4, en zo telkens verdubbelend tot en"
26640 DATA"met vlak 64. Het aantal graankorrels is dan"
26650 DATA"2^64-1. Hier volgt een programma om dat"
26660 DATA"getal te berekenen; de rekentijd is ong. 30"
26670 DATA"seconden.",". ",".1 M0 = +2",".2 M1 = +1"
26680 DATA".3 M0 = M0 ^ 64",".4 M0 = M0 - M1",".5"
26690 DATA"WETENS.",".6 BEKIJK M0",". ",".Code:"
26700 DATA"I0+2#I1+1#M0064A001WK0*","#HET GETAL E","Het"
26710 DATA"getal e is een bekend getal uit de"
26720 DATA"wiskunde. Het volgende programma benadert"
26730 DATA"dat getal. Het programma heeft ong. 5"
26740 DATA"minuten rekentijd nodig.",". ",". 1 M0 = +2"
26750 DATA". 2 M1 = +1",". 3 M2 = +1",". 4 M3 = +1"
26760 DATA". 5 PRECISIE 20",". 6 HERHAAL #0;22"
26770 DATA". 7 M3 = M3 + M2",". 8 M1 = M1 / M3"
26780 DATA". 9 M0 = M0 + M1",".10 TERUG #0"
26790 DATA".11 BEKIJK M0",". ",".Code:"
26800 DATA"I0+2#I1+1#I2+1#I3+1#P20H022O332D113O001T0K0*"
26810 DATA"#PI","Pi is een zo mogelijk nog bekender"
26820 DATA"getal uit de wiskunde: het geeft de"
26830 DATA"verhouding aan tussen de diameter en de"
26840 DATA"omtrek van een cirkel. Er zijn verschillende"
26850 DATA"methoden bedacht om pi te benaderen; deze"
26860 DATA"versie is het eenvoudigst te programmeren en"
26870 DATA"tegelijkertijd relatief snel. Rekentijd:"
26880 DATA"ongeveer een kwartier. Als je pi in meer"
26890 DATA"getallen wilt benaderen, moet je de PRECISIE"
26900 DATA"instructie veranderen, en ook de HERHAAL"
26910 DATA"instructie. Vuistregel:1 cijfer preciezer; 3"
26920 DATA"stappen meer. Als je pi in erg veel"
26930 DATA"decimalen wilt benaderen, moet je per cijfer"
26940 DATA"meer wortel 10 (=ong. 3.16) extra stappen"
26950 DATA"doen.",". ",". 1 M0 = +2",". 2 M1 = +2",". 3"
26960 DATA"M2 = +2",". 4 M3 = +1",". 5 PRECISIE 20"
26970 DATA". 6 HERHAAL #0;64",". 7 M4 = #0",". 8 M1 ="
26980 DATA"M1 * M4",". 9 M4 = M4 * M2",".10 M4 = M4 +"
26990 DATA"M3",".11 M1 = M1 / M4",".12 M0 = M0 + M1"
27000 DATA".13 TERUG #0",".14 BEKIJK M0",". ",".Code:"
27010 DATA"I0+2#I1+2#I2+2#I3+1#P20H064I4#0%"
27020 DATA"V114V442O443D114O001T0K0*","#DE WORTEL VAN 2"
27030 DATA"Hieronder staat een programma om wortels te"
27040 DATA"berekenen. Zoals het er staat, berekent het"
27050 DATA"de wortel van twee, maar door het getal in"
27060 DATA"regel 3 te veranderen kun je er elke wortel"
27070 DATA"mee berekenen. Om de wortel van 10 te"
27080 DATA"berekenen moet je er 5 neerzetten, etc. Bij"
27090 DATA"erg grote getallen is het mogelijk dat je,"
27100 DATA"om voldoende precisie te krijgen, de"
27110 DATA"HERHAAL-opdracht moet veranderen. Het"
27120 DATA"gebruikte algoritme is zeer krachtig: er"
27130 DATA"zijn maar 4 stappen nodig om een"
27140 DATA"20-cijferige precisie te behalen. Elke stap"
27150 DATA"meer geeft bijna verdubbeling van het aantal"
27160 DATA"significante cijfers! Dat het programma toch"
27170 DATA"vrij veel tijd nodig heeft om die vier"
27180 DATA"stappen uit te voeren, is te wijten aan het"
27190 DATA"feit dat er in regel 6 gedeeld wordt door"
27200 DATA"een getal met veel cijfers. Dit is bijzonder"
27210 DATA"tijdrovend. Rekentijd: plusminus 5 minuten."
27220 DATA". ",". 1 PRECISIE 20",". 2 M0 = +1.5",". 3"
27230 DATA"M1 = +1",". 4 M2 = +.5",". 5 HERHAAL #0;4"
27240 DATA". 6 M3 = M1 / M0",". 7 M0 = M0 * M2",". 8 M0"
27250 DATA"= M0 + M3",". 9 TERUG #0",".10 BEKIJK M0"
27260 DATA". ",".Code:"
27270 DATA"P20I0+1.5#I1+1#I2+.5#H04D310V002O003T0K0*"
27280 DATA"$"
30000 REM****************************
30010 REM
30020 REM UITLEG BIJ DE
30030 REM PROGRAMMEERBARE CALCULATOR
30040 REM
30050 REM
30060 REM DOOR G.A. LUNTER
30070 REM BORDINE 44
30080 REM 8604 AD  SNEEK
30090 REM
30100 REM****************************
30110 REM COPYRIGHT NOS HILVERSUM
