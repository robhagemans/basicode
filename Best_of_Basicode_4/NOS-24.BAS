1000 A=600:GOTO 20
1010 GOSUB 100:REM 8085-SIMULATOR BESCHRIJVING
1020 BI=0:DE=0:HP=40:VP=24:KL$="":N=1:GOSUB 100
1130 PRINT :PRINT "Naar Printer (1) of Scherm (2) ";
1140 GOSUB 210:IF (IN$<>"1") AND(IN$<>"2") THEN 1140
1150 PT=1:IF IN$="2" THEN PT=0:GOTO 1230
1160 PRINT :PRINT :PRINT "Hoeveel letters per regel ";
1170 INPUT HP
1180 PRINT :PRINT "Kantlijnbreedte: ";
1190 INPUT SP:GOSUB 1900:KL$=SP$
1200 HP=HP-SP:IF SP>1 THEN HP=HP-SP+2
1210 PRINT :PRINT "Aantal regels per pagina ";
1220 INPUT VP:VP=VP-6
1230 RT=0:H=0:SR$=" ":GOSUB 20000
1320 GOSUB 100:SR$="8085-SIMULATOR"
1330 SP=INT((HP-14)/2)::IF PT=1 THEN SP=SP-3
1340 GOSUB 1900
1350 SR$=SP$+SR$:GOSUB 20000
1360 SR$=SP$+"--------------":GOSUB 20000
1370 SR$=" ":GOSUB 20000
1375 A$="":RESTORE :READ BB$
1380 GOSUB 22100
1390 GOSUB 22190
1400 GOTO 1380
1410 END
1900 SP$="":FOR I=1 TO SP:SP$=SP$+" ":NEXT I:RETURN
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
21030 PRINT "<Toets voor verder>";
21040 GOSUB 210:GOSUB 100:RT=0:RETURN
22000 REM papier vol
22010 GOSUB 100:FOR I=1 TO 6:GOSUB 360:NEXT I
22020 PRINT "Zet de printer bovenaan nieuwe pagina"
22030 PRINT "en druk daarna op een toets."
22040 GOSUB 210:RT=0:GOSUB 100
22050 N=N+1:SR=N:GOSUB 300:N$=SR$
22060 SR$="8085-SIMULATOR  pagina "+N$
22070 NL=LEN(SR$):GOSUB 20060:SR$=""
22080 SR$=SR$+"-":IF LEN(SR$)<NL THEN 22080
22090 GOSUB 20060:SR$=" ":GOSUB 20060:RETURN
22100 IF BB$="$$$$$" THEN H=1:GOSUB 22190:END
22110 IF A$<>"" THEN A$=A$+" "
22120 A$=A$+BB$:READ BB$
22121 IF BB$="**" THEN READ BB$:IF PT=0 THEN GOSUB 210
22122 IF BB$="+++++" THEN GOSUB 22480:GOTO 22121
22123 IF RIGHT$(BB$,1)="#" THEN GOSUB 22380
22124 IF RIGHT$(BB$,1)=";" THEN GOSUB 22430
22130 IF LEFT$(BB$,1)="#" THEN H=1:GOTO 22180
22140 IF LEFT$(BB$,1)="." THEN H=1:GOTO 22180
22150 IF A$=". " THEN 22180
22160 IF LEFT$(A$,1)="#" THEN 22180
22170 IF LEN(A$)<HP THEN 22100
22180 RETURN
22190 REM PRINT MET AANGEPASTE REGELLENGTE
22200 IF LEFT$(A$,1)="#" THEN H=3
22210 IF (LEFT$(A$,1)<>".") AND(H<3) THEN 22260
22220 LL=LEN(A$):A$=RIGHT$(A$,LL-1)
22230 IF H<3 THEN 22260
22240 IF PT=0 THEN GOSUB 21010
22250 IF PT=1 THEN SR$=" ":GOSUB 20000
22260 IF A$=" " THEN SR$=A$:A$="":GOSUB 20000:GOTO 22370
22270 L=LEN(A$):IF (H=0) AND(L<HP) THEN 22370
22280 IF L<HP THEN SR$=A$:A$="":GOSUB 20000:GOTO 22360
22290 FOR I=HP TO 1 STEP -1
22300 B$=MID$(A$,I,1)
22310 IF B$=" " THEN J=I:I=1
22320 NEXT I
22330 SR$=LEFT$(A$,J-1):A$=RIGHT$(A$,L-J)
22340 GOSUB 20000
22350 GOTO 22270
22360 IF H=3 THEN SR$=" ":GOSUB 20000
22370 H=0:RETURN
22380 LL=LEN(BB$):BB$=LEFT$(BB$,LL-1)
22390 IF PT=0 THEN RETURN
22400 READ BB$:IF RIGHT$(BB$,1)="#" THEN 22400
22410 IF RIGHT$(BB$,1)=";" THEN 22430
22420 RETURN
22430 LL=LEN(BB$):BB$=LEFT$(BB$,LL-1)
22440 IF PT=1 THEN RETURN
22450 READ BB$:IF RIGHT$(BB$,1)=";" THEN 22450
22460 IF RIGHT$(BB$,1)="#" THEN 22380
22470 RETURN
22480 READ BB$:IF PT=1 THEN RETURN
22490 A$="":RT=0:DE=DE+1:IF DE>5 THEN GOSUB 100:RETURN
22510 ON DE GOSUB 22720,22720,22550,22775,22775
22515 IF DE=3 THEN RETURN
22520 IF DE=1 THEN GOSUB 210:GOSUB 100:RETURN
22530 IF DE=2 THEN RETURN
22540 IF DE>3 THEN VE=1:HO=0:GOSUB 110:READ BB$:RETURN
22550 GOSUB 210:GOSUB 22580
22560 IF IN$<>" " THEN 22550
22570 RETURN
22580 IF (IN$<"A") OR(IN$>"H") THEN RETURN
22590 A1=ASC(IN$)-ASC("A"):VE=A1+1:A1=2^A1
22600 G=INT(BI/A1):A2=INT(G/2)*2
22610 IF G=A2 THEN BI=BI+A1:G=1:GOTO 22630
22620 BI=BI-A1:G=0
22630 HO=4:GOSUB 110
22640 FOR J=1 TO 5
22650 PRINT "         ";:GOSUB 110
22660 FOR A2=1 TO 50:NEXT A2
22670 PRINT "-------->";:GOSUB 110
22680 FOR A2=1 TO 50:NEXT A2
22690 NEXT J
22700 SR=G:GOSUB 300
22710 HO=16:GOSUB 110:PRINT SR$:RETURN
22720 HO=4:VE=0:GOSUB 110:PRINT "INPUT 00              ";
22730 PRINT "OUTPUT 00":ZZ$="--------":HO=0
22740 FOR I=0 TO 7
22750 SR=I:GOSUB 300
22760 PRINT "B";SR$;"  ";ZZ$;"> ( 0 ) ( 0 ) ";ZZ$;">  B";SR$
22770 NEXT I
22775 IF DE>3 THEN GOSUB 100
22780 VE=10:HO=0:GOSUB 110
22790 IF DE=2 THEN RETURN
22795 ZZ$="--------"
22800 PRINT "INSTRUCTIE ";ZZ$;ZZ$;ZZ$;"----"
22810 PRINT "  REGISTER *":HO=22:VE=11:GOSUB 110
22820 PRINT "*":HO=38:GOSUB 110:PRINT "*"
22830 PRINT "+ DECODING ";ZZ$;ZZ$;ZZ$;"----"
22840 HO=3:VE=14:GOSUB 110:PRINT "AUX.":HO=14:GOSUB 110
22850 PRINT "ACCU":HO=25:GOSUB 110:PRINT "PROGR. TELLER"
22860 HO=1:VE=15:GOSUB 110:PRINT ZZ$;"   ";ZZ$
22870 VE=17:GOSUB 110:PRINT ZZ$;"   ";ZZ$
22880 HO=25:ZZ$=ZZ$+"-----"
22890 FOR I=15 TO 23 STEP 2
22900 VE=I:GOSUB 110:PRINT ZZ$;
22910 NEXT I
22920 HO=1:VE=16:GOSUB 110:PRINT "*":HO=8:GOSUB 110:PRINT "*"
22930 HO=12:GOSUB 110:PRINT "*":HO=19:GOSUB 110:PRINT "*"
22940 HO=25:GOSUB 110:PRINT "*":HO=37:GOSUB 110:PRINT "*"
22950 HO=1:VE=18:GOSUB 110:PRINT "********   ********    H"
22960 PRINT "  *":PRINT "   *":PRINT "    *"
22970 PRINT "     ***********        B"
22980 HO=9:VE=19:GOSUB 110:PRINT "* *      *":VE=20:GOSUB 110
22990 PRINT " *      *      D":VE=21:GOSUB 110
23000 PRINT "ALU    *":VE=18:HO=31:GOSUB 110:PRINT "*      L"
23010 VE=20:GOSUB 110:PRINT "*      E"
23020 VE=22:GOSUB 110:PRINT "*      C"
23030 HO=1:VE=23:GOSUB 110:PRINT "S=0 Z=0 A=0 P=0 C=0";
23040 RETURN
24000 END
25000 DATA "In cursussen over microprocessors"
25010 DATA "wordt vaak gebruik gemaakt van de"
25020 DATA "8085-microprocessor."
25030 DATA ".Voor zover mij bekend wordt deze"
25040 DATA "processor niet toegepast in home-computers."
25050 DATA ".Dit programma geeft U de mogelijkheid"
25060 DATA "om op uw home-computer programma's te maken"
25070 DATA "in de 8085 assembleertaal, deze te vertalen"
25080 DATA "naar machinecode, en met een single step"
25090 DATA "routine te testen."
25100 DATA "# ","Bedenk wel, dit programma maakt geen"
25110 DATA "machinetaal programma, maar een simulatie"
25120 DATA "in basic.",".De uitvoering van de instructies"
25130 DATA "zal daardoor ook vrij traag gaan."
25140 DATA ".Dit geeft U wel de gelegenheid om goed te"
25150 DATA "volgen wat er gebeurt.",".Bij het gebruik"
25160 DATA "van het programma wordt uitgegaan van een"
25170 DATA "scherm met 40 karakters en 24 regels."
25180 DATA ".Het programma is ongeveer 20K groot en"
25190 DATA "gebruikt ongeveer 7K voor tabellen en"
25200 DATA "variabelen.",".Dit kan voor een aantal"
25210 DATA "computers problemen opleveren."
25220 DATA ".Daarom kunt U door het wijzigen van de"
25230 DATA "variabelen V en W in regel 1010 en 1020"
25240 DATA "de ruimte aanpassen die door de tabellen"
25250 DATA "wordt gebruikt."
25260 DATA "# ","De standaard instelling van V en W is"
25270 DATA "60 respectievelijk 1023."
25280 DATA ".De variabele V bepaalt het aantal regels"
25290 DATA "tekst dat U in kunt voeren."
25300 DATA ".Deze kunt U naar believen groter of"
25310 DATA "kleiner maken.",".De variabele W geeft de"
25320 DATA "grootte aan van de ruimte waarin het vertaalde"
25330 DATA "programma komt te staan."
25340 DATA ".Deze variabele mag niet groter gemaakt"
25350 DATA "worden dan 1023.",".U kunt deze variabele"
25360 DATA "eventueel wel kleiner maken."
25370 DATA ".Het bereik van de te gebruiken adressen"
25380 DATA "in uw programma, is echter afhankelijk"
25390 DATA "van de variabele W.","# ","Heeft U een voorbeeld"
25400 DATA "programma waarin adressen gebruikt worden"
25410 DATA "die groter zijn dan W, dan zult u die "
25420 DATA "moeten aanpassen."
25430 DATA ".","          Bijvoorbeeld:",". ","ORG 1800H"
25440 DATA "       --->   ORG 100H",".SOM EQU 2000H   "
25450 DATA "--->   SOM EQU 900D",".ADD B           "
25460 DATA "--->   ADD B",".ADD E           "
25470 DATA "--->   ADD E",".STA SOM         "
25480 DATA "--->   STA SOM",".END           "
25490 DATA "  --->   HLT"
25500 DATA ". ","In de eerste twee regels, ziet U dat"
25510 DATA "de adressen aangepast zijn."
25520 DATA ".Het resultaat van de optelling gaat naar"
25530 DATA "adres 900D  (D = decimaal)",".Het programma"
25540 DATA "zelf wordt geplaatst op adres 100H"
25550 DATA "(H = hexadecimaal)"
25560 DATA "# ","De assembler kent een drietal directives."
25570 DATA ".(Aanwijzingen voor de assembler)"
25580 DATA ".Deze zijn:",".ORG : Geeft het beginadres"
25590 DATA ".      van het vertaalde programma aan."
25600 DATA ".EQU : Geeft een waarde aan een"
25610 DATA ".      symbolische naam.",".DB  : Reserveert"
25620 DATA "een geheugenplaats en",".      vult deze met de"
25630 DATA "achter DB",".      vermelde waarde."
25640 DATA ". ","Het directive 'END' mag niet gebruikt"
25650 DATA "worden.",".Sluit het programma af met HLT."
25660 DATA ".De eerste opdracht in regel nul moet altijd"
25670 DATA "ORG zijn gevolgd door een decimaal of"
25680 DATA "hexadecimaal adres."
25690 DATA "# ","Na het commando RUN wordt de tabel die"
25700 DATA "gebruikt wordt om het werkgeheugen te simuleren"
25710 DATA "op nul gezet."
25720 DATA ".Dit vraagt wat tijd."
25730 DATA ".Hierna ziet U op het scherm het volgende:"
25740 DATA ". ",". ","8085-SIMULATOR",".KLAAR VOOR INVOER"
25750 DATA ". ",". ",". ","0  -",". ",". "
25760 DATA "Nul is het regelnummer.",".Het minteken"
25770 DATA "is de cursor.","# ","U kunt nu beginnen met het"
25780 DATA "intikken van uw 8085 programma."
25790 DATA ".Regel 0 moet altijd beginnen met ORG."
25800 DATA ".Na het intikken van een programmaregel"
25810 DATA "gevolgd door RETURN (ENTER)"
25820 DATA "wordt automatisch een nieuw regelnummer"
25830 DATA "gegenereerd.",".U kunt tijdens het intikken"
25840 DATA "gebruik maken van een aantal commando's."
25850 DATA ".Deze commando's bestaan uit een letter."
25860 DATA ".U kunt deze commando's gebruiken door"
25870 DATA "in plaats van een programmaregel de"
25880 DATA "betreffende letter in te tikken gevolgd"
25890 DATA "door RETURN (ENTER)."
25900 DATA "# ","De beschikbare commando's zijn:"
25910 DATA ".M = menu",".L = list",".W = wijzigen"
25920 DATA ".V = verwijderen",".T = tussenvoegen"
25930 DATA ".Z = geheugen dump",".A = start assembler"
25940 DATA ".R = single step",".N = nieuw programma"
25950 DATA ". ","M : Laat U het bovenstaande menu zien."
25960 DATA ". ","N : Geeft U de mogelijkheid een nieuw"
25970 DATA ".    programma in te voeren.",".    De"
25980 DATA "vertaalde code van het oude"
25990 DATA ".    programma wordt niet gewist."
26000 DATA "# ","L : Geeft een listing van de reeds"
26010 DATA ".    ingetikte programmaregels."
26020 DATA ".    Tijdens de listing kunnen direct"
26030 DATA ".    commando's worden ingevoerd voor"
26040 DATA ".    b.v. wijzigen."
26050 DATA ". ","W : Vraagt U welke regel U wenst te"
26060 DATA ".    wijzigen.",".    Na het intikken van het"
26070 DATA "regelnr.",".    gevolgd door RETURN (ENTER),"
26080 DATA ".    tikt U de regel opnieuw in."
26090 DATA ". ","V : Vraagt U welke regel U wenst te"
26100 DATA ".    verwijderen.",".    Na het verwijderen"
26110 DATA "worden de",".    onderliggende regels een"
26120 DATA "plaats",".    naar boven opgeschoven."
26130 DATA "# ","T : Vraagt U waar U een regel wenst"
26140 DATA ".    tussen te voegen.",".    U geeft het"
26150 DATA "regelnr. op van de",".    eerste regel die"
26160 DATA "moet zakken.",".    De onderliggende"
26170 DATA "regels worden",".    een plaats naar"
26180 DATA "beneden opgeschoven",".    inclusief de"
26190 DATA "opgegeven regel.",".    De nieuwe regel die"
26200 DATA "U nu kunt",".    intikken wordt tussengevoegd."
26210 DATA ". ","Z : Vraagt U vanaf welk adres U de"
26220 DATA ".    geheugen-inhoud wenst te zien."
26230 DATA ".    U kunt dan decimaal",".    of hexadecimaal"
26240 DATA "het gewenste adres",".    intikken."
26250 DATA ".    b.v.  7BH  of  123D"
26260 DATA ".    Op uw scherm ziet U dan het"
26270 DATA ".    volgende:"
26280 DATA "# ","    ADRES    HEX.   DEC.   BINAIR"
26290 DATA ". ","    0123     3E     62     00111110"
26300 DATA ".    0124     25     37     00100101"
26310 DATA ".    enz."
26320 DATA ". ","    Afhankelijk van hoe U het adres"
26330 DATA ".    ingeeft (hexadecimaal of decimaal)"
26340 DATA ".    wordt in de kolom ADRES  het adres"
26350 DATA ".    hexadecimaal of decimaal"
26360 DATA ".    weergegeven."
26370 DATA ".    De geheugen-inhoud wordt zowel"
26380 DATA ".    decimaal, hexadecimaal als binair"
26390 DATA ".    weergegeven."
26400 DATA "# ","A : Vertaalt de ingetikte regels naar"
26410 DATA ".    machine code en plaatst deze in"
26420 DATA ".    een tabel dat gebruikt wordt om"
26430 DATA ".    het werkgeheugen te simuleren."
26440 DATA ".    Wordt tijdens de vertaling een"
26450 DATA ".    syntax fout gesignaleerd, dan wordt"
26460 DATA ".    daar melding van gemaakt."
26470 DATA ".    De vertaling gaat echter door."
26480 DATA ".    Wordt tijdens de vertaling het"
26490 DATA ".    adres groter dan de variabele W,"
26500 DATA ".    dan wordt de vertaling afgebroken"
26510 DATA ".    met de foutmelding 'ADRES TE HOOG'."
26520 DATA ".    De vertaalde regels worden op het"
26530 DATA ".    scherm weergegeven."
26540 DATA "# ","R : Is het programma foutloos vertaald,"
26550 DATA ".    dan kunt U door middel van de"
26560 DATA ".    spatiebalk het programma stap voor"
26570 DATA ".    stap laten uitvoeren."
26580 DATA ".    De werking van het programma wordt"
26590 DATA ".    weergegeven in een controle scherm."
26600 DATA ". ",". ","Bij de volgende druk op de#"
26610 DATA "spatiebalk ziet U een beeldlayout#"
26620 DATA "van het controle scherm.#"
26630 DATA ".Bij de daarop volgende druk op de#"
26640 DATA "spatiebalk wordt de beschrijving#"
26650 DATA "voortgezet.#"
26660 DATA "# ",". ","+++++"
26670 DATA "    INPUT 00              OUTPUT 00;"
26680 DATA ".B0  --------> ( 0 ) ( 0 ) -------->  B0;"
26690 DATA ".B1  --------> ( 0 ) ( 0 ) -------->  B1;"
26700 DATA ".B2  --------> ( 0 ) ( 0 ) -------->  B2;"
26710 DATA ".B3  --------> ( 0 ) ( 0 ) -------->  B3;"
26720 DATA ".B4  --------> ( 0 ) ( 0 ) -------->  B4;"
26730 DATA ".B5  --------> ( 0 ) ( 0 ) -------->  B5;"
26740 DATA ".B6  --------> ( 0 ) ( 0 ) -------->  B6;"
26750 DATA ".B7  --------> ( 0 ) ( 0 ) -------->  B7;"
26760 DATA ". ","+++++"
26770 DATA "Dit gedeelte  geeft de input en output"
26780 DATA "weer.",".Links ziet U acht input lijnen."
26790 DATA ".Deze kunt U activeren met behulp van de"
26800 DATA "toetsen A t/m H.",".Probeer het maar!#"
26810 DATA ". ","De output lijnen worden door het"
26820 DATA "door U gemaakte programma geactiveerd."
26830 DATA ".<SPATIEBALK IS VERDER>#"
26840 DATA ". ","+++++","+++++",". "
26850 DATA ".INSTRUCTIE ----------------------------;"
26860 DATA ".  REGISTER *          *               *;"
26870 DATA ".+ DECODING ----------------------------;",". ;"
26880 DATA ".   AUX.       ACCU       PROGR. TELLER;"
26890 DATA ". --------   --------     -------------;"
26900 DATA ". *      *   *      *     *           *;"
26910 DATA ". --------   --------     -------------;"
26920 DATA ". ********   ********    H      *      L;"
26930 DATA ".  *      * *      *      -------------;"
26940 DATA ".   *      *      *      D      *      E;"
26950 DATA ".    *    ALU    *        -------------;"
26960 DATA ".     ***********        B      *      C;"
26970 DATA ". S=0 Z=0 A=0 P=0 C=0     -------------;"
26980 DATA ".Dit gedeelte geeft de inhoud van de"
26990 DATA "verschillende registers weer."
27000 DATA ".In het gedeelte instructie register"
27010 DATA "+ decoding wordt de op dat moment"
27020 DATA "in bewerking zijnde instructie weergegeven."
27030 DATA ". ","**","+++++"
27040 DATA ". ","In de progr. teller wordt het adres"
27050 DATA "weergegeven"
27060 DATA "van de opdracht die in bewerking is."
27070 DATA ".Onder de ALU wordt de inhoud van de"
27080 DATA "status flags weergegeven."
27090 DATA ".AUX. is een hulpregister dat gebruikt"
27100 DATA "wordt bij bewerkingen in de ALU."
27110 DATA ". ","**","+++++"
27111 DATA "# ","Tijdens single step kunt U de status flags"
27112 DATA "setten of resetten met behulp van de toetsen"
27113 DATA "1 t/m 5.",".Dit kunt U gebruiken om b.v."
27114 DATA "een lange wachtlus te onderbreken.",". "
27115 DATA "toets 1 = S",".toets 2 = Z",".toets 3 = A"
27116 DATA ".toets 4 = P",".toets 5 = C","# "
27120 DATA ". ","Bij het invoeren van uw programma"
27130 DATA "moet U bepaalde regels in acht nemen."
27140 DATA ". ","Symbolische namen moeten een waarde"
27150 DATA "hebben voor U ze gebruikt in uw programma."
27160 DATA ". ","Labels moeten op een aparte regel."
27170 DATA ".25 LABEL: MOV A,B  is niet toegestaan."
27180 DATA ".Dit moet zijn:        ---------------"
27190 DATA ".25 LABEL:",".26 MOV A,B"
27200 DATA ". ","Labels moeten eindigen met dubbele punt."
27210 DATA ".De laatste letter van een label mag"
27220 DATA "geen B D of H zijn.",". "
27230 DATA "# ","Adressen en data moeten eindigen"
27240 DATA ".op H bij hexadecimale getallen,"
27250 DATA ".op B bij binaire getallen,"
27260 DATA ".op D bij decimale getallen."
27270 DATA ".Het weglaten van D bij decimale"
27280 DATA "getallen is niet toegestaan."
27290 DATA ". ","Alle invoer moet in hoofdletters."
27300 DATA ". ","Er zijn enkele opdrachten die U niet"
27310 DATA "mag gebruiken.",".Dit zijn de opdrachten die"
27320 DATA "gebruik maken van interrupts."
27330 DATA ".Deze opdrachten zijn:"
27340 DATA ".RIM  SIM  EI  DI  RST 0 t/m 7"
27350 DATA "# ","Het controlescherm kan maar een input-"
27360 DATA "en een outputpoort weergeven."
27370 DATA ".Het is dus niet toegestaan meer dan"
27380 DATA "een input- en een outputnummer gelijktijdig"
27390 DATA "te gebruiken.",". ","In sprongopdrachten,"
27400 DATA "die gebruik maken van labels, wordt het"
27410 DATA "sprongadres pas na de vertaling ingevult."
27420 DATA ". ","U kunt commentaar in uw programma"
27430 DATA "opnemen door dit vooraf te laten gaan"
27440 DATA "door de puntkomma.",".Bijvoorbeeld:"
27450 DATA ".LXI H,1234H ;INITIALISEER DATAPOINTER"
27460 DATA "# ","De stackpointer wordt door het"
27470 DATA "programma op W-2 gezet."
27480 DATA ".(W = grootte van de geheugentabel)"
27490 DATA ".De standaard instelling van de stackpointer"
27500 DATA "is dus 1021.",".Dit kunt U door een opdracht"
27510 DATA "in uw 8085 programma eventueel veranderen."
27520 DATA ". ","Tijdens single step kunt U terug naar de"
27530 DATA "invoermode door toets S in te drukken."
27540 DATA ".Sluit U het programma af met de opdracht"
27550 DATA "HLT, dan zal automatisch terug gesprongen"
27560 DATA "worden naar de invoermode."
27570 DATA "# ","Na uitvoering van een commando of bij"
27580 DATA "een fout tijdens single step, zal altijd"
27590 DATA "terug gesprongen worden naar de invoer mode"
27600 DATA "en wordt het laatste vrije regelnummer"
27610 DATA "weergegeven.",".Hierna kunt U weer verder"
27620 DATA "gaan met invoeren van programmaregels"
27630 DATA "of commando's.",". ","Indien U tijdens het"
27640 DATA "intikken een fout maakt, kunt U voorgaande"
27650 DATA "letters verwijderen door het ? in te tikken."
27660 DATA ".Gebruik hiervoor niet de delete toets."
27670 DATA ".Bij een aantal computers geeft dat problemen."
27680 DATA "# ","U kunt eventueel met GOTO1060 weer"
27690 DATA "terug in het programma springen zonder"
27700 DATA "dat U reeds ingetikte regels kwijtraakt."
27710 DATA ". ","Mocht U toch nog problemen hebben"
27720 DATA "met het gebruik van het programma, neemt U"
27730 DATA "dan even kontakt met mij op."
27740 DATA ". ","***************************************"
27750 DATA ".*    Dit programma is gemaakt door    *"
27760 DATA ".*             A Commeren              *"
27770 DATA ".*             Weide  120              *"
27780 DATA ".*           5103 HZ Dongen            *"
27790 DATA ".*                                     *"
27800 DATA ".*   Het programma is gemaakt op een   *"
27810 DATA ".*            'ACORN  BBC'             *"
27820 DATA ".***************************************"
27830 DATA "# ","Nu volgen nog een viertal programma"
27840 DATA "voorbeelden.",". ","VOORBEELD 1",". "
27850 DATA "0  ORG 100H"
27860 DATA ".1  LXI H,900D",".2  MVI B,8D",".3  VOLGENDE:"
27870 DATA ".4  MOV A,M",".5  OUT 12H",".6  INX H"
27880 DATA ".7  DCR B",".8  JNZ VOLGENDE",".9  HLT"
27890 DATA ".10 ORG 900D",".11 DB 00000001B"
27900 DATA ".12 DB 00000010B",".13 DB 00000100B"
27910 DATA ".14 DB 00001000B",".15 DB 00010000B"
27920 DATA ".16 DB 00100000B",".17 DB 01000000B"
27930 DATA ".18 DB 10000000B",". ","Dit programma haalt"
27940 DATA "data op uit het geheugen vanaf adres 900D"
27950 DATA "en stuurt dit door naar outputpoort 12H."
27960 DATA ".Alle outputlijnen worden een voor een"
27970 DATA "geactiveerd.","# ","VOORBEELD 2"
27980 DATA ". ","0  ORG 100D",".1  GETAL1 EQU 3759H"
27990 DATA ".2  GETAL2 EQU 4263H",".3  LXI H,GETAL1"
28000 DATA ".4  LXI D,GETAL2",".5  MOV A,L",".6  ADD E"
28010 DATA ".7  DAA",".8  MOV C,A",".9  MOV A,H"
28020 DATA ".10 ADC D",".11 DAA",".12 MOV B,A",".13 HLT"
28030 DATA ". ","In registerpaar HL wordt in BCD code"
28040 DATA "het getal 3759 geplaatst."
28050 DATA ".In registerpaar DE wordt in BCD code"
28060 DATA "het getal 4263 geplaatst."
28070 DATA ".Deze getallen worden bij elkaar opgetelt"
28080 DATA " en het antwoord, in BCD code, wordt"
28090 DATA "in registerpaar BC geplaatst."
28100 DATA "# ","VOORBEELD 3",". ",".0  ORG 123H"
28110 DATA ".1  MVI A,FFH",".2  MVI B,10D"
28120 DATA ".3  LXI H,1000D",".4  NEXT:",".5  CMP M"
28130 DATA ".6  JC GROTER",".7  MOV A,M",".8  GROTER:"
28140 DATA ".9  INX H",".10 DCR B",".11 JNZ NEXT"
28150 DATA ".12 MOV M,A",".13 HLT",".14 ORG 1000D"
28160 DATA ".15 DB 73D",".16 DB 25D",".17 DB 81D"
28170 DATA ".18 DB 204D",".19 DB 17D",".20 DB 112D"
28180 DATA ".21 DB 5D",".22 DB 58D",".23 DB 13D"
28190 DATA ".24 DB 75D"
28200 DATA ". ","In het geheugen, vanaf adres 1000D,"
28210 DATA "staat een reeks van 10 getallen."
28220 DATA ".Het programma zoekt de kleinste van deze"
28230 DATA "getallen op en plaatst een copie hiervan"
28240 DATA "achter de reeks getallen.","# "
28250 DATA "VOORBEELD 4",". ","0  ORG 12D"
28260 DATA ".1  DEUREN EQU 00000111B"
28265 DATA ".2  COMBINATIE1 EQU 110B"
28270 DATA ".3  COMBINATIE2 EQU 101B"
28275 DATA ".4  COMBINATIE3 EQU 011B"
28280 DATA ".5  COMBINATIE4 EQU 111B",".6  TEST-LUS:"
28290 DATA ".7  IN 23H",".8  ANI DEUREN"
28300 DATA ".9  CPI COMBINATIE1",".10 JZ MELDING"
28310 DATA ".11 CPI COMBINATIE2",".12 JZ MELDING"
28320 DATA ".13 CPI COMBINATIE3",".14 JZ MELDING"
28330 DATA ".15 CPI COMBINATIE4",".16 JZ MELDING"
28340 DATA ".17 MVI A,0D",".18 OUT 16H"
28350 DATA ".19 JMP TEST-LUS",".20 MELDING:"
28360 DATA ".21 MVI A,00000001B",".22 OUT 16H"
28370 DATA ".23 JMP TEST-LUS",". "
28380 DATA "Een kamer heeft 3 deuren.",".Deze deuren"
28390 DATA "zijn door middel van schakelaars"
28400 DATA "verbonden met de ingangen B0, B1 en B2"
28410 DATA "van inputpoort 12H van uw computer."
28420 DATA ".Is een deur gesloten, dan geeft dit een"
28430 DATA "nul op de ingang.",".I.v.m. tocht mag"
28440 DATA "er steeds maar een deur open staan."
28450 DATA ".Dit programma test de ingangen B0, B1 en B2"
28460 DATA "en maakt uitgang B0 hoog als er meer dan"
28470 DATA "een deur open staat."
28480 DATA "# ",". ","VEEL PLEZIER MET DIT PROGRAMMA"
28490 DATA "$$$$$"
30000 REM COPYRIGHT NOS HILVERSUM
