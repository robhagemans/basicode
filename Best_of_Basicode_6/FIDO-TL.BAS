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
 1000 A=600:GOTO 20:REM Basicode Beeldkrant
 1010 GOSUB 100:REM eerst scherm opmeten
 1020 I=0:J=I:VE=I:IP=64:JP=IP:FOR A=1 TO 7
 1030 I=I+IP:HO=I:GOSUB 110:GOSUB 120:IF HO<>I THEN I=I-IP
 1040 J=J+JP:VE=J:GOSUB 110:GOSUB 120:IF VE<>J THEN J=J-JP
 1050 IP=IP/2:JP=JP/2:NEXT A:HP=I+1:VP=J+1
 1060 REM begin programma
 1070 DIM K$(6)
 1080 GOSUB 100:PRINT"Basicode Beeldkrant"
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
 1330 K$(0)="*****************************"
 1340 K$(1)="*  Fido-NOS simulator V2.2  *"
 1350 K$(2)="*                           *"
 1360 K$(3)="*      geschreven door      *"
 1370 K$(4)="*                           *"
 1380 K$(5)="*  Peter Jan van der Mespel *"
 1390 K$(6)="*****************************"
 1400 GOSUB 100
 1410 SP=INT((HP-29)/2):IF PT=1 THEN SP=SP-3
 1420 GOSUB 1900
 1430 SR$=" ":GOSUB 20000
 1440 FOR I=0 TO 6:SR$=SP$+K$(I):GOSUB 20000:NEXT I
 1450 RESTORE
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
22060 SR$="Uitleg Fido-NOS simulator V2.2, pag. "+N$
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
25000 DATA"#FIDO-NOS SIMULATOR V2.2"
25010 DATA"Deze tweede versie van de simulator van"
25020 DATA"Fido-NOS is helemaal aangepast aan Fido versie"
25030 DATA"12p, die momenteel in de Fido-NOS databank"
25040 DATA"(tel. 035-45395) wordt gebruikt. We zullen"
25050 DATA"de belangrijkste commando's die Fido (en de"
25060 DATA"simulator) kent hieronder kort behandelen."
25070 DATA"#START PROGRAMMA"
25080 DATA"Als u het programma opstart, moet u eerst"
25090 DATA"enkele toetsen indrukken die van belang"
25100 DATA"zijn voor een goed verloop van de simulatie."
25110 DATA"Deze toetsen vertegenwoordigen enkele"
25120 DATA"functies zoals: afbreken (CTRL-C), pauze"
25130 DATA"(CTRL-S), wissen (DELETE) en download. U"
25140 DATA"moet elke keer een aparte toets invoeren,"
25150 DATA"anders kan de boel in het honderd lopen."
25160 DATA". "
25170 DATA"Vervolgens gaat de simulator 'bellen met Fido-"
25180 DATA"NOS' en verschijnt het welkomstbeeld, waarna"
25190 DATA"u gaat 'inloggen'. Als de simulator om 'FIRST"
25200 DATA"name' vraagt, moet u uw eigen naam invoeren."
25210 DATA"Enige toelichting hierbij bevindt zich in"
25220 DATA"de intro van Fido-NOS. U moet vervolgens"
25230 DATA"uw woonplaats en een eigen 'password'"
25240 DATA"(prive-code) invoeren. Deze gegevens blijven"
25250 DATA"in het programma aanwezig tot op het moment"
25260 DATA"dat u het programma opnieuw start of de"
25270 DATA"computer uitzet. Het is daarom handig om in de"
25280 DATA"regels 21340 en 21350 uw gegevens zelf in te"
25290 DATA"vullen, zodat iedere keer dat u de simulator"
25300 DATA"start, u met uw eigen naam kunt 'inloggen'. De"
25310 DATA"volgende variabelen worden hierbij gebruikt:"
25320 DATA". "
25330 DATA"NM$='Peter.jan Van.der.mespel'"
25340 DATA"(voornaam en achternaam)"
25350 DATA".PV$='test' (prive-code)"
25360 DATA".WP$='Den Haag' (woonplaats)"
25370 DATA"#ALGEMENE AANWIJZINGEN"
25380 DATA"U kunt Fido opdrachten geven door steeds de"
25390 DATA"eerste letter van een commando in te tikken,"
25400 DATA"gevolgd door <return>. U kunt ook meerdere"
25410 DATA"opdrachten achter elkaar intikken, van elkaar"
25420 DATA"gescheiden door een spatie of puntkomma."
25430 DATA"Voorbeeld: 'f a 1 f'. Fido maakt geen"
25440 DATA"onderscheid tussen hoofd- en kleine letters."
25450 DATA". "
25460 DATA"Bij bijna alle commando's kunt u de volgende"
25470 DATA"toets-combinaties toepassen. Deze combinaties"
25480 DATA"moeten NIET door een <return> gevolgd worden:"
25490 DATA". "
25500 DATA".CTRL-C breekt de verwerking van een"
25510 DATA"commando af en wist een hele regel."
25520 DATA".CTRL-S onderbreekt tijdelijk het 'listen'"
25530 DATA"op het scherm. Het 'listen' wordt vervolgd"
25540 DATA"als u op een willekeurige toets drukt."
25550 DATA"#MAIN SECTIE"
25560 DATA"Dit is het hoofdmenu van de databank, oftewel"
25570 DATA"het menu dat u te zien krijgt nadat u in"
25580 DATA"het BBS heeft 'ingelogd'. Enkele commando's:"
25590 DATA". "
25600 DATA"Met 'B' krijgt u een lijst van beschikbare"
25610 DATA"bulletins (in Fido: 1 tot maximaal 99, in de"
25620 DATA"simulator: 1 tot en met 5), dit afhankelijk"
25630 DATA"van het aantal bulletins dat in het systeem"
25640 DATA"staat. U kunt deze in de simulator niet"
25650 DATA"lezen, aangezien ze teveel ruimte innemen."
25660 DATA". "
25670 DATA"Met 'L' (list callers) kunt u kijken wie"
25680 DATA"er allemaal van dit BBS gebruik maken. U"
25690 DATA"kunt de hele lijst bekijken met een druk op"
25700 DATA"<CR> (d.w.z. de <return>-toets) of u kunt"
25710 DATA"zoeken op (een deel van) een bepaalde naam."
25720 DATA"#C)HANGE-MENU"
25730 DATA"Het hoofdmenu bevat verder een belangrijk"
25740 DATA"sub-menu, namelijk het C)hange-menu,"
25750 DATA"te bereiken via commando 'C'. In dit"
25760 DATA"menu kunnen een aantal dingen veranderd"
25770 DATA"worden, zoals naam, adres, prive-code,"
25780 DATA"etc. Sommige commando's zijn echter"
25790 DATA"alleen in Fido-NOS te veranderen."
25800 DATA". "
25810 DATA"Interessant is het commando H)elp-level. Dit"
25820 DATA"kan een van de volgende 3 niveau's aannemen:"
25830 DATA". "
25840 DATA"Level 3 = All"
25850 DATA".-------------"
25860 DATA".Dit niveau staat aan bij de eerste"
25870 DATA"keer inloggen; alle commando's"
25880 DATA"zijn voluit geschreven."
25890 DATA". "
25900 DATA"Level 2 = Some"
25910 DATA".--------------"
25920 DATA".Hulpniveau 2 geeft enkel de commandoletters."
25930 DATA". "
25940 DATA"Level 1 = None"
25950 DATA".--------------"
25960 DATA".Hulpniveau 1 geeft zelfs de commandoletters"
25970 DATA"niet meer. U moet dan uit uw hoofd weten"
25980 DATA"welke commando's er in een bepaald menu"
25990 DATA"gebruikt kunnen worden. Met dit niveau"
26000 DATA"kunnen ervaren Fido'ers zeer snel"
26010 DATA"opdrachten laten uitvoeren."
26020 DATA". "
26030 DATA"Met 'W' kunt u in het C)hange-menu instellen"
26040 DATA"hoeveel tekens er maximaal bij uw computer"
26050 DATA"op een regel passen. Normaal is dat 40 tekens"
26060 DATA"per regel (Basicode standaard), maar u kunt"
26070 DATA"bv. ook 80 tekens per regel instellen, als"
26080 DATA"uw beeldscherm dat aankan. De instelling"
26090 DATA"is onder andere van invloed op de weergave"
26100 DATA"van de berichten in de message gebieden."
26110 DATA". "
26120 DATA"Als u klaar bent met het bekijken c.q."
26130 DATA"veranderen van de systeem instellingen kunt"
26140 DATA"u met Q)uit terugkeren naar het hoofdmenu."
26150 DATA"#MESSAGE SECTIE"
26160 DATA"Met het commando 'M' gaat u vanuit het"
26170 DATA"hoofdgebied naar de berichtengebieden."
26180 DATA"U kunt daarna met A)rea-change een"
26190 DATA"bepaald berichtengebied uitkiezen. De"
26200 DATA"berichten die hierin staan kunt u direct"
26210 DATA"lezen door het betreffende nummer in te"
26220 DATA"tikken. Ook kunt u met N)ext of P)revious"
26230 DATA"naar het volgende resp. het vorige bericht"
26240 DATA"gaan. Commando's als C)ontinuous, L)ist en"
26250 DATA"S)earch kunnen in twee 'richtingen' werken."
26260 DATA"De onderste regel geeft aan in welke richting"
26270 DATA"deze commando's op een bepaald moment werken:"
26280 DATA". "
26290 DATA"Command or message number 1-3 [1 N]:"
26300 DATA". "
26310 DATA"Deze regel geeft aan dat er berichten"
26320 DATA"aanwezig zijn met de nummers 1 t/m 3,"
26330 DATA"het laatst gelezen bericht is bericht 1 en"
26340 DATA"de richting is 'N' (next). Dit wil zeggen"
26350 DATA"dat, als u <return> geeft, het eerstvolgende"
26360 DATA"bericht na bericht 1 wordt getoond. Als er"
26370 DATA"'P' staat (previous), worden de commando's"
26380 DATA"uitgevoerd in neerwaartse richting vanaf het"
26390 DATA"laatst gelezen bericht. Hieronder volgen de"
26400 DATA"commando's die volgens dit principe werken:"
26410 DATA". "
26420 DATA".C)ontinuous toont alle berichten"
26430 DATA"zonder onderbreking."
26440 DATA".L)ist toont de headers (koppen)"
26450 DATA"van alle berichten."
26460 DATA".S)earch zoekt alle headers in het"
26470 DATA"berichtengebied af naar een door u"
26480 DATA"ingevoerde term (naam of onderwerp)."
26490 DATA"#SPECIALE COMMANDO'S"
26500 DATA"Naast bovengenoemde commando's zijn er in"
26510 DATA"het berichtengebied nog enkele bijzondere"
26520 DATA"commando's die van invloed zijn op de volgorde"
26530 DATA"waarin de berichten worden gelezen of getoond:"
26540 DATA". "
26550 DATA".< : laat Fido naar het laagste bericht"
26560 DATA"gaan en zet de richting op N)ext."
26570 DATA".> : laat Fido naar het hoogste bericht"
26580 DATA"gaan en zet de richting op P)revious, dus"
26590 DATA"in de richting van het laagste bericht."
26600 DATA".. : (de punt) laat het laatstgelezen"
26610 DATA"bericht opnieuw zien."
26620 DATA"#ZELF BERICHTEN SCHRIJVEN"
26630 DATA"Deze tweede versie van de Fido-NOS simulator"
26640 DATA"heeft, in tegenstelling tot de eerste versie,"
26650 DATA"de mogelijkheid om zelf enkele berichten te"
26660 DATA"schrijven, met het commando E)nter (message)."
26670 DATA"Nadat u heeft opgegeven aan wie het bericht is"
26680 DATA"gericht (To:) en waar het over gaat (Subject:)"
26690 DATA"kunt u het gaan intikken. Als u klaar bent,"
26700 DATA"drukt u tweemaal achter elkaar op de <return>"
26710 DATA"toets. Na het aanbrengen van eventuele"
26720 DATA"wijzigingen kunt u het bericht opslaan"
26730 DATA"met 'S'. Het maximum aantal berichten in"
26740 DATA"ieder berichtengebied is 5 (d.w.z. in de"
26750 DATA"simulator, niet in het echte Fido-NOS BBS!)."
26760 DATA"#FILE SECTIE"
26770 DATA"Met het commando 'F' komt u vanuit het"
26780 DATA"hoofdmenu in de bestands gebieden terecht."
26790 DATA"Met 'A' (Area-change) krijgt u dan weer"
26800 DATA"een overzicht van de aanwezige gebieden, en"
26810 DATA"kunt u er eentje uitkiezen. Vervolgens biedt"
26820 DATA"'F' (files) een lijst van de in dat gebied"
26830 DATA"aanwezige bestanden (van links naar rechts:"
26840 DATA"file-naam, grootte in bytes, omschrijving)."
26850 DATA"Vanwege ruimtegebrek bevat de simulator"
26860 DATA"slechts een beperkt aantal bestandsnamen."
26870 DATA"Met 'T' (type) kunt u de inhoud van een"
26880 DATA"bestand bekijken. In de simulator is dat"
26890 DATA"overigens niet mogelijk, omdat geen bestanden"
26900 DATA"erin zijn opgenomen. Tot slot kunt u met"
26910 DATA"'D' (download) een bestand van Fido naar uw"
26920 DATA"computer overbrengen. Dit gaat met behulp van"
26930 DATA"zogenaamde 'bestands overdrachts protocollen'."
26940 DATA"Zie voor een verdere toelichting de 'help'-"
26950 DATA"teksten in de echte Fido (bereikbaar met"
26960 DATA"'?'). In het programma kan dit 'downloaden'"
26970 DATA"slechts worden gesimuleerd. Ook kan alleen"
26980 DATA"het Xmodem protocol worden gekozen."
26990 DATA"#UITLOGGEN"
27000 DATA"Vanuit de main sectie, de message sectie"
27010 DATA"of de file sectie kunt u 'uitloggen'"
27020 DATA"(het programma verlaten c.q. de telefoon"
27030 DATA"verbinding met Fido-NOS verbreken) door op"
27040 DATA"'G' (goodbye) te drukken. Eventueel kunt"
27050 DATA"u daarna, met behoud van alle variabelen,"
27060 DATA"instellingen en ingevoerde berichten, de"
27070 DATA"simulator opnieuw starten met 'GOTO 3000'."
27080 DATA"(Bij de echte Fido lukt dat dus niet...)"
27090 DATA"#TOT SLOT"
27100 DATA"Voor overige informatie over Fido kunt u"
27110 DATA"terecht in de Fido-NOS databank zelf (om"
27120 DATA"precies te zijn: Bulletin 4). Deze uitleg"
27130 DATA"is tot stand gekomen m.b.v. de zogenaamde"
27140 DATA"Fido 'help'-teksten. In Fido zijn deze"
27150 DATA"teksten in elk menu te lezen door '?' in"
27160 DATA"te tikken. In de simulator zijn ze niet"
27170 DATA"aanwezig, vanwege de beperkte ruimte."
27180 DATA".Tot zover de toelichting, succes bij"
27190 DATA"het inloggen in de Fido-NOS databank!"
27200 DATA". "
27210 DATA"Peter Jan van der Mespel, Den Haag."
27220 DATA"$$$$$"
30000 REM COPYRIGHT NOS HILVERSUM
