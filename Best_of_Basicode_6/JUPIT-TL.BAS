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
25000 DATA"Toelichting programma Jupitermanen"
25010 DATA"#JUPITER"
25020 DATA"De komende winter (1988/89) wordt een"
25030 DATA"bijzonder goede tijd om eens naar de planeet"
25040 DATA"Jupiter te kijken. De reuzenplaneet is een"
25050 DATA"van de helderste objecten aan de zuidelijke"
25060 DATA"avondhemel. Met een eenvoudige kijker kunnen"
25070 DATA"we avond aan avond getuige zijn van het"
25080 DATA"steeds wisselende schouwspel van de maantjes,"
25090 DATA"die in cirkelbanen rondom de planeet bewegen."
25100 DATA"De baancirkels liggen allemaal in hetzelfde"
25110 DATA"vlak, waar wij aan de zijkant tegenaan"
25120 DATA"kijken. Wij zien de maantjes daarom niet echt"
25130 DATA"in cirkels bewegen, maar enkel heen en weer"
25140 DATA"schuiven."
25150 DATA"#OPPOSITIE"
25160 DATA"Op 23 november 1988 stond Jupiter pal"
25170 DATA"tegenover de zon. 'In oppositie' heet dat."
25180 DATA"De planeet stond in het oosten op het moment"
25190 DATA"dat de zon in het westen onderging. Toen"
25200 DATA"'s morgens vroeg de zon in het oosten weer"
25210 DATA"opkwam, had Jupiter zijn boog langs de"
25220 DATA"zuidelijke hemel voltooid; de planeet ging"
25230 DATA"toen net in het westen onder. Toen de zon"
25240 DATA"zich midden in de nacht diep onder de"
25250 DATA"noordelijke horizon bevond, stond Jupiter"
25260 DATA"juist hoog in het zuiden."
25270 DATA"#VOORJAAR 1989"
25280 DATA"In de maanden na de oppositie bereikt Jupiter"
25290 DATA"dat hoogste punt in het zuiden steeds"
25300 DATA"vroeger. Het tijdstip van doorgang schuift"
25310 DATA"per maand ongeveer twee uur naar voren."
25320 DATA"Aangezien de meeste mensen het liefst 's"
25330 DATA"avonds kijken, bieden de maanden na de"
25340 DATA"oppositie de beste gelegenheid."
25350 DATA"#ZEVENGESTERNTE"
25360 DATA"Jupiter staat dit jaar in het sterrenbeeld"
25370 DATA"Stier. Rechtsbovenin dat sterrenbeeld staat"
25380 DATA"een kluitje sterren, dat het Zevengesternte"
25390 DATA"of -in het Grieks- de Pleijaden wordt"
25400 DATA"genoemd. Met het blote oog is het"
25410 DATA"Zevengesternte voor veel mensen een wat vaag"
25420 DATA"vlekje; met een kijker is het een fraaie"
25430 DATA"stergroep, die overigens heel wat meer dan"
25440 DATA"zeven leden telt."
25450 DATA"#ALDEBARAN"
25460 DATA"Het hart van het sterrenbeeld Stier -of beter"
25470 DATA"gezegd het oog van de Stier- is de heldere"
25480 DATA"rode ster Aldebaran. Jupiter staat tussen"
25490 DATA"Aldebaran en het Zevengesternte. Zeker ten"
25500 DATA"opzichte van Aldebaran is de planeet"
25510 DATA"duidelijk wit. Wanneer we op een of andere"
25520 DATA"manier Jupiter gevonden hebben, kunnen we"
25530 DATA"onze kijker tevoorschijn halen. Een gewone"
25540 DATA"prismakijker, zoals die bijvoorbeeld gebruikt"
25550 DATA"wordt om vogels te bespieden, is ruimschoots"
25560 DATA"voldoende."
25570 DATA"#KIJKER"
25580 DATA"De kijker richten we om te beginnen NIET op"
25590 DATA"Jupiter. Eerst nemen we een willekeurige ster"
25600 DATA"en stellen daarop goed scherp. De ster moet"
25610 DATA"werkelijk tot een punt ineenschrompelen. Let"
25620 DATA"erop dat de ster echt voor beide ogen scherp"
25630 DATA"is. Nu kijken we naar Jupiter. Als alles goed"
25640 DATA"is, zien we die nu duidelijk wel als een"
25650 DATA"schijfje. Aan beide kanten van de planeet, of"
25660 DATA"misschien aan een kant, zien we nu een rijtje"
25670 DATA"puntjes, in principe vier. Dat zijn de vier"
25680 DATA"helderste maantjes. Het is vaak moeilijk de"
25690 DATA"kijker goed stil te houden. Een statief is"
25700 DATA"het beste, maar het helpt ook al de kijker te"
25710 DATA"laten ondersteunen door bijvoorbeeld een"
25720 DATA"paaltje."
25730 DATA"#KINDEREN"
25740 DATA"Sommige kinderen schijnen zulke goede ogen te"
25750 DATA"hebben, dat ze de Jupitermanen zonder kijker"
25760 DATA"kunnen zien. Wie kinderen bij de hand heeft,"
25770 DATA"kan dat eens controleren."
25780 DATA"#NAAR DE COMPUTER"
25790 DATA"Teken de posities van de maantjes op, ga naar"
25800 DATA"binnen, start de computer en draai het"
25810 DATA"computerprogramma voor de Jupitermaantjes,"
25820 DATA"dat hoort bij deze uitleg. Het is beter niet"
25830 DATA"vooraf het programma te draaien, omdat de"
25840 DATA"eerlijkheid van de waarneming dan wel eens"
25850 DATA"aangetast zou kunnen worden. Het programma"
25860 DATA"vraagt eerst, wat voor kijker we gebruikt"
25870 DATA"hebben. Sla een P aan voor een gewone"
25880 DATA"prismakijker, of een letter O voor een"
25890 DATA"omkerende telescoop (een echte"
25900 DATA"sterrenkijker). De returntoets is hier niet"
25910 DATA"nodig."
25920 DATA"#TIJDSINTERVAL"
25930 DATA"Vervolgens vraagt de computer om het"
25940 DATA"tijdsinterval. Later rekent de computer de"
25950 DATA"posities van de maantjes uit om de zoveel"
25960 DATA"tijd. Wanneer u tussenpozen van een kwartier"
25970 DATA"wilt houden, druk dan enkel op de return- of"
25980 DATA"entertoets. Voor een interval van een uur het"
25990 DATA"getal 60 invoeren, voor een dag 1440"
26000 DATA"(minuten), gevolgd door een druk op return."
26010 DATA"#DATUM, TIJD EN POSITIES"
26020 DATA"Op een nieuw scherm vraagt de computer om"
26030 DATA"datum en tijd. Een jaartal kunnen we invoeren"
26040 DATA"als 1989 of kortweg als 89 met hetzelfde"
26050 DATA"resultaat. Het programma houdt verder zelf"
26060 DATA"rekening met zomer- en wintertijd. Nadat het"
26070 DATA"tijdstip is opgegeven, verschijnt het"
26080 DATA"resultaat, als lijstje, maar ook als plaatje."
26090 DATA"De vier maantjes zijn aangegeven met de"
26100 DATA"eerste letter van hun naam. De grote J heeft"
26110 DATA"een vaste plaats middenop het scherm en"
26120 DATA"markeert de planeet. Wanneer twee maantjes op"
26130 DATA"(bijna) dezelfde plaats staan, wisselen hun"
26140 DATA"letters elkaar knipperend af. We kunnen nu de"
26150 DATA"maantjes die we gezien hebben, echt"
26160 DATA"identificeren. Aan de hemel stonden de namen"
26170 DATA"er immers niet bij. Onder de tekening is"
26180 DATA"aangegeven, hoe we het programma verder"
26190 DATA"kunnen laten gaan."
26200 DATA"#VLAKBIJ JUPITER"
26210 DATA"Wanneer een maantje zich op minder dan een"
26220 DATA"Jupiterstraal van het middelpunt van de"
26230 DATA"planeet bevindt, wordt in het lijstje"
26240 DATA"aangegeven, of het maantje voor of achter de"
26250 DATA"planeet langsgaat. Wanneer een maantje voor"
26260 DATA"de planeet passeert, kan het zijn, dat het"
26270 DATA"een schaduw op het planeetoppervlak werpt."
26280 DATA"Bij een passage achter de planeet kan het"
26290 DATA"maantje voor of na de bedekking een paar uur"
26300 DATA"verdwijnen in de schaduw van de planeet. Het"
26310 DATA"programma is niet nauwkeurig genoeg om de"
26320 DATA"tijdstippen van die verschijnselen te"
26330 DATA"voorspellen. Voor de oppositie van Jupiter"
26340 DATA"gaat de verduistering in de schaduw vooraf"
26350 DATA"aan de bedekking door de planeet. Na de"
26360 DATA"oppositie komt de bedekking eerst."
26370 DATA"#VER VAN JUPITER"
26380 DATA"Sommige maantjes hebben een baan dichtbij"
26390 DATA"Jupiter, andere doorlopen een ruimere baan."
26400 DATA"Io (maantje I) bevindt zich het dichtst bij"
26410 DATA"Jupiter, dan komt Europa (II), dan Ganymedes"
26420 DATA"(III), terwijl Callisto (IV) de meest wijde"
26430 DATA"baan heeft. De straal van de baan van"
26440 DATA"Callisto is 26,6 Jupiterstralen. De breedte"
26450 DATA"van ons scherm correspondeert met tweemaal"
26460 DATA"die afstand. De straal van Jupiter is"
26470 DATA"overigens 71000 kilometer, ruim elf maal de"
26480 DATA"straal van de aarde."
26490 DATA"#NOG MEER MANEN"
26500 DATA"De vier maantjes die we zelf met een kleine"
26510 DATA"kijker kunnen zien, werden in januari 1610"
26520 DATA"door Galilei ontdekt met de toen pas"
26530 DATA"uitgevonden telescoop. In 1892 ontdekte de"
26540 DATA"Amerikaanse astronoom E. E. Bernard een"
26550 DATA"vijfde maantje en inmiddels is de lijst nog"
26560 DATA"veel langer geworden."
26570 DATA"# "
26580 DATA".NAAM, NUMMER, BAANSTRAAL (JUPITERSTRALEN),"
26590 DATA".OMLOOPTIJD (DAGEN), JAAR ONTDEKT"
26600 DATA". "
26610 DATA".Adrastea  XIV  1.76  0.30  1979"
26620 DATA".Amalthea  V    2.55  0.49  1892"
26630 DATA".1979J2    XV   3.11  0.67  1980"
26640 DATA".Io        I    5.95  1.77  1610"
26650 DATA".Europa    II   9.47  3.55  1610"
26660 DATA".Ganymedes III  15.1  7.15  1610"
26670 DATA".Callisto  IV   26.6  16.7  1610"
26680 DATA".Leda      XIII  156   240  1974"
26690 DATA".Himalia   VI    161   251  1904"
26700 DATA".Lysithea  X     164   260  1938"
26710 DATA".Elara     VII   165   260  1904"
26720 DATA".Ananke    XII   291   617  1951"
26730 DATA".Carme     XI    314   692  1938"
26740 DATA".Pasiphae  VIII  327   735  1908"
26750 DATA".Sinope    IX    333   758  1914"
26760 DATA"#MINNARESSEN"
26770 DATA"Zelden bevatte een beeldkrant zulke mooie"
26780 DATA"namen! Amalthea is de geit die de pasgeboren"
26790 DATA"god Jupiter gezoogd heeft. De buitenste acht"
26800 DATA"zijn allemaal minnaressen die Jupiter in zijn"
26810 DATA"latere leven heeft gehad. De Internationale"
26820 DATA"Astronomische Unie, die de meeste namen in"
26830 DATA"1975 officieel toewees, verborg er nog een"
26840 DATA"betekenis in. De manen die eindigen op een a,"
26850 DATA"doorlopen hun baan in dezelfde richting als"
26860 DATA"de klassieke manen van Galilei. De manen"
26870 DATA"waarvan de naam eindigt op een e, doorlopen"
26880 DATA"hun baan in de tegenovergestelde richting."
26890 DATA"#KEPLERWET"
26900 DATA"Wie er zin in heeft, kan met de gegevens uit"
26910 DATA"de tabel van manen de zogeheten derde wet van"
26920 DATA"Kepler controleren. Die wet geldt voor"
26930 DATA"groepen objecten die allemaal om eenzelfde"
26940 DATA"hemellichaam heenlopen, dus voor de planeten"
26950 DATA"die om de zon lopen, maar ook voor de manen"
26960 DATA"van Jupiter. De wet zegt dat de baanstraal"
26970 DATA"tot de derde macht gedeeld door de omlooptijd"
26980 DATA"in het kwadraat steeds hetzelfde is."
26990 DATA"Bijvoorbeeld voor Io (5.95^3)/(1.77^2) ="
27000 DATA"67 en voor Sinope (333^3)/(758^2) = 64,"
27010 DATA"(vrijwel) dezelfde uitkomst."
27020 DATA"#ONDERLINGE BEINVLOEDING"
27030 DATA"De Keplerwet wordt opgelegd door het"
27040 DATA"centrale lichaam, in dit geval dus door"
27050 DATA"Jupiter. De maantjes beinvloeden elkaar"
27060 DATA"echter ook onderling. Dat is te zien aan de"
27070 DATA"omlooptijden. Voor de manen I, II en III zijn"
27080 DATA"die 1.77, 3.55 en 7.15 dagen. Tweemaal 1.77"
27090 DATA"is 3.54, dus bijna precies de omlooptijd van"
27100 DATA"maan II. Nemen we dan tweemaal 3.55, dan"
27110 DATA"komen we uit op 7.10, bijna de omlooptijd van"
27120 DATA"maan III. Deze en meer verborgen"
27130 DATA"wetmatigheden hebben de maantjes elkaar via"
27140 DATA"hun zwaartekracht opgelegd."
27150 DATA"#ZELF NAGAAN"
27160 DATA"Wanneer het bewolkt is, kunnen we het"
27170 DATA"bovenstaande zelf eens nagaan met het"
27180 DATA"computerprogramma. Stel het tijdsinterval in"
27190 DATA"op 7.15 dagen, dat zijn 10300 minuten. Wanneer"
27200 DATA"we hiermee door de tijd stappen, zien we dat"
27210 DATA"het patroon J-i-e-g in het plaatje zich maar"
27220 DATA"langzaam wijzigt. Het gelijkblijven komt"
27230 DATA"doordat de omlooptijden zo goed op elkaar"
27240 DATA"passen. De kleine verandering komt doordat de"
27250 DATA"overeenstemming toch niet helemaal volmaakt"
27260 DATA"is."
27270 DATA"$$$$$"
30000 REM
30010 REM Pim van Tend
30020 REM Veldheimwg 8
30030 REM 6871 CD  RENKUM
30040 REM 08373 - 15358
30050 REM
30060 REM COPYRIGHT 1988 NOS HILVERSUM
