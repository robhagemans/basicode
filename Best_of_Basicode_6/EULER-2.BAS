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
 1010 GOSUB 100:REM OOIT VAN 'E' GEHOORD?
 1020 PRINT"---- even geduld a.u.b. ---"
 1030 VE=0:FOR I=0 TO 80:HO=I:GOSUB 110
 1040 GOSUB 120:IF HO<>I THEN HP=I:I=80
 1050 NEXT I:FOR I=0 TO 40:HO=0:VE=I:GOSUB 110
 1060 GOSUB 120:IF VE<>I THEN VP=I:I=40
 1070 NEXT I
 1080 REM BEGIN PROGRAMMA
 1090 DIM K$(6)
 1340 RT=0:H=0:TE=0
 1350 REM PRINT DE KOP
 1360 K$(0)="******************************"
 1370 K$(1)="*                            *"
 1380 K$(2)="*   Ooit van 'e' gehoord ?   *"
 1390 K$(3)="*   Historische Notities     *"
 1400 K$(4)="*   rond het getal 'e'       *"
 1410 K$(5)="*                            *"
 1420 K$(6)="******************************"
 1430 GOSUB 100
 1440 SP=INT((HP-30)/2)
 1450 GOSUB 1900
 1460 SR$=" ":GOSUB 20000
 1470 FOR I=0 TO 6:SR$=SP$+K$(I):GOSUB 20000:NEXT I
 1480 GOSUB 21000
 1490 GOTO 3000:REM*** MENU ***
 1600 REM*** PRINT DE OVERIGE DATA ***
 1610 A$="":GOSUB 100
 1620 READ BB$:KL=0
 1630 GOSUB 23000
 1640 GOSUB 24000
 1650 IF KL=0 THEN 1630
 1670 GOSUB 21000:GOTO 3000:REM** NAAR HOOFD-MENU **
 1900 SP$="":IF SP<1 THEN RETURN
 1910 FOR I=1 TO SP:SP$=SP$+" ":NEXT I
 1920 RETURN
 2000 GOSUB 100:END
 3000 RESTORE:GOSUB 100:HO=5:VE=4:GOSUB 110
 3010 PRINT"HOOFD-MENU getal 'e'"
 3020 VE=6:GOSUB 110:PRINT"1. Komplete tekst"
 3030 VE=8:GOSUB 110:PRINT"2. Hist.Notities"
 3040 VE=10:GOSUB 110:PRINT"3. Literatuur opg."
 3050 VE=12:GOSUB 110:PRINT"4. Stoppen"
 3060 HO=1:VE=VP-1:GOSUB 110
 3070 PRINT"<Geef nummer van Uw keuze>";
 3080 GOSUB 210:K=VAL(IN$)
 3085 IF(K<1) OR(K>4) THEN 3080
 3090 ON K GOTO 1610,4000,5000,2000
 3990 :
 4000 REM*** HISTORISCHE NOTITIES GETAL 'E' ***
 4010 RESTORE:GOSUB 100:HO=5:VE=4:GOSUB 110
 4020 PRINT"MENU - (Historische Notities)"
 4030 VE=8:GOSUB 110:PRINT"1. TEKST Hist.Not.geheel"
 4040 VE=10:GOSUB 110:PRINT"2. Keuze van fragment"
 4050 VE=12:GOSUB 110:PRINT"3. TERUG naar hoofd-menu"
 4060 HO=1:VE=VP-1:GOSUB 110
 4070 PRINT"<Geef nummer van Uw keuze>";
 4080 GOSUB 210:M=VAL(IN$)
 4085 IF(M<1) OR(M>3) THEN 4080
 4090 ON M GOTO 6000,7000,3000
 4990 REM*** LITERATUUR OPGAVE ***
 5000 RESTORE
 5010 FOR I=1 TO 227:READ BB$:NEXT I
 5020 GOTO 1610
 5990 :
 6000 REM*** ALLEEN HISTORISCHE NOT.***
 6010 RESTORE:GOSUB 100:TE=0
 6020 A$="":READ BB$
 6030 IF(TE=227) THEN 6060
 6040 GOSUB 23000:GOSUB 24000
 6050 GOTO 6030
 6060 TE=0:GOSUB 21000:GOTO 4000
 6990 :
 7000 REM*** KEUZE FRAGMENT ***
 7010 GOSUB 100:HO=1:VE=1:GOSUB 110
 7020 PRINT"KEUZE FRAGMENT"
 7030 VE=3:GOSUB 110:PRINT"1. Briggs"
 7040 VE=5:GOSUB 110:PRINT"2. Euler"
 7050 VE=7:GOSUB 110:PRINT"3. Logaritmen"
 7060 VE=9:GOSUB 110:PRINT"4. Merkator"
 7070 VE=11:GOSUB 110:PRINT"5. Neper"
 7080 VE=13:GOSUB 110:PRINT"6. Vlack"
 7090 VE=15:GOSUB 110:PRINT"7. Wallis"
 7100 VE=17:GOSUB 110:PRINT"8. Wolfram"
 7110 VE=19:GOSUB 110:PRINT"9. Hoofdmenu"
 8000 REM*** KEUZE ZOEKEN ***
 8010 HO=1:VE=VP-1:GOSUB 110
 8020 PRINT"<Geef het nummer van Uw keuze>";
 8030 GOSUB 210:N=VAL(IN$)
 8035 IF(N<1) OR(N>9) THEN 8030
 8040 ON N GOTO 8100,8200,8300,8400,8500,8600,8700,8800,3000
 8100 GOSUB 9000:BE=10:EN=32:GOTO 10000
 8200 GOSUB 9000:BE=33:EN=77:GOTO 10000
 8300 GOSUB 9000:BE=78:EN=86:GOTO 10000
 8400 GOSUB 9000:BE=87:EN=105:GOTO 10000
 8500 GOSUB 9000:BE=106:EN=185:GOTO 10000
 8600 GOSUB 9000:BE=186:EN=195:GOTO 10000
 8700 GOSUB 9000:BE=196:EN=212:GOTO 10000
 8800 GOSUB 9000:BE=213:EN=227:GOTO 10000
 9000 GOSUB 100:PRINT"--- even geduld a.u.b.---"
 9010 RETURN
10000 REM*** FRAGMENT ZOEKEN ***
10010 RESTORE:TE=0
10020 FOR I=1 TO(BE-1):READ C$:NEXT I
10030 A$="":READ BB$:GOSUB 100
10040 IF(TE>(EN-BE)) THEN 10070
10050 GOSUB 23000:GOSUB 24000
10060 GOTO 10040
10070 TE=0:GOSUB 21000:GOTO 7000
20000 REM AFDRUK SUBROUTINE
20010 IF SR$="" THEN RETURN
20030 PRINT SR$
20040 RT=RT+1:IF RT=VP-4 THEN GOSUB 21000
20050 RETURN
21000 REM SCHERM VOL
21010 IF RT=0 THEN RETURN
21020 HO=0:VE=VP-1:GOSUB 110
21030 PRINT"<toets voor verder>";
21040 GOSUB 210:GOSUB 100:RT=0:RETURN
23000 IF BB$="$$$$$" THEN KL=1:H=1:RETURN
23010 IF A$<>"" THEN A$=A$+" "
23020 A$=A$+BB$:READ BB$:TE=TE+1
23030 IF LEFT$(BB$,1)="#" THEN H=1:RETURN
23040 IF LEFT$(BB$,1)="." THEN H=1:RETURN
23050 IF A$=". " THEN RETURN
23060 IF LEFT$(A$,1)="#" THEN RETURN
23070 IF LEN(A$)<HP THEN 23000
23080 RETURN
24000 REM PRINT MET AANGEPASTE REGELLENGTE FRAGMENTEN
24010 IF LEFT$(A$,1)="#" THEN H=2
24020 IF(LEFT$(A$,1)<>".") AND(H<2) THEN 24070
24030 A$=RIGHT$(A$,LEN(A$)-1)
24040 IF H=2 THEN GOSUB 21000
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
24200 :
24210 REM DATA-DEEL
24220 :
25000 DATA"# ",". ",". ",". ",". ",". ",". ",". "
25010 DATA".    HISTORISCHE NOTITIES"
25020 DATA"# HENRY BRIGGS (1556-1631)"
25030 DATA".Henry Briggs was hoogleraar in de wiskunde"
25040 DATA"te Londen.In 1615 reisde hij naar Neper"
25050 DATA"om hem zijn hulde te betuigen en een"
25060 DATA"voorstel te doen tot een VERANDERING.Dit"
25070 DATA"voorstel leidde tot het aannemen van een"
25080 DATA"stelsel dat we nu"
25090 DATA". ",".    GEWONE logaritmen of"
25100 DATA".    BRIGGSE logaritmen noemen.",". "
25110 DATA".In 1617 liet Briggs een tafel verschijnen"
25120 DATA"met de logaritmen van de getallen van"
25130 DATA".    1 tot 1000 (met het grondtal 10)",". "
25140 DATA"#In 1624 maakte Briggs een tafel openbaar"
25150 DATA"met de logaritmen in 14 decimalen voor de"
25160 DATA"getallen van"
25170 DATA".    1 tot  20000   en"
25180 DATA".90000 tot 100000.",". "
25190 DATA".Spoedig verdrongen de Briggse logaritmen"
25200 DATA"de Neperse logaritmen."
25210 DATA"#  LEONHARD EULER (1707-1783)"
25220 DATA".Leonhard Euler werd geboren te Bazel."
25230 DATA"Hij studeerde aldaar onder Johann Bernoulli."
25240 DATA". ",".Katharina I haalde Euler in 1725"
25250 DATA"naar Petersburg.",". "
25260 DATA".In 1747 kwam Euler op uitnodiging van"
25270 DATA"Frederik de Grote naar Berlijn maar in"
25280 DATA"1766 keerde hij terug naar Petersburg."
25290 DATA"Kort daarop werd hij blind,maar dit belette"
25300 DATA"hem niet de laatste 17 jaren van zijn leven"
25310 DATA"te wijden aan de studie van de wiskunde.",". "
25320 DATA".Euler heeft als eerste geleerd"
25330 DATA".DE LOGARITMEN ALS EXPONENTEN te beschouwen."
25340 DATA"# LEONHARD EULER (vervolg)"
25350 DATA".Van Euler is ook de aanwijzing van het"
25360 DATA"grondtal van de natuurlijke logaritmen"
25370 DATA"door 'e' afkomstig.",". "
25380 DATA".In 1737 wees Euler 'Pi' aan als de"
25390 DATA"verhouding van de omtrek van een cirkel"
25400 DATA"tot zijn middellijn."
25410 DATA". ",".In 1748 gaf Euler 'Pi' op in 127"
25420 DATA"decimalen !",". "
25430 DATA".In 1794 voerde Euler het teken 'i' in"
25440 DATA"voor de imaginaire eenheid."
25450 DATA"# LEONHARD EULER (vervolg)"
25460 DATA".Euler maakte zich verdienstelijk op het"
25470 DATA"gebied van"
25480 DATA".        de getallen-leer"
25490 DATA".        de waarschijnlijkheidsrekening"
25500 DATA".        de mechanica"
25510 DATA".        de astronomie"
25520 DATA".        de goniometrie"
25530 DATA".        de analytische meetkunde.",". "
25540 DATA".De grootste verdiensten van Euler betreffen"
25550 DATA"de 'hogere wiskunde'.",". "
25560 DATA".Zijn geschriften samen beslaan ongeveer"
25570 DATA"16000 kwarto bladzijden."
25580 DATA"#       LOGARITME (historie)"
25590 DATA".Logaritme komt van"
25600 DATA".       LOGOS ARITHMOS"
25610 DATA".wat 'juiste verhouding' betekent."
25620 DATA".De logaritmen werden gevonden door:"
25630 DATA".       MICHAEL STIFEL (1486-1567)"
25640 DATA".en de Engelse astronoom en wiskundige"
25650 DATA".   SIR JOHN NAPIER (1550-1617)"
25660 DATA".ook wel Neper,Napeir,Napair."
25670 DATA"# NIC.MERKATOR (Mercator) (1620-1687)"
25680 DATA".Nic.Merkator voerde in 1668 de naam"
25690 DATA"'logarithmus naturalis' = natuurlijke"
25700 DATA"logaritme,afgekort 'Log nat.' in voor de"
25710 DATA"functie,gedefinieerd door"
25720 DATA".                     2    3"
25730 DATA".                    a    a"
25740 DATA".log nat (1+a) = a - -- + -- - ..."
25750 DATA".                    2    3",". "
25760 DATA".Nic.Merkator ,omstreeks 1620 in Holstein"
25770 DATA"geboren,bracht een groot deel van zijn leven"
25780 DATA"in Engeland door.In 1683 vertrok hij naar"
25790 DATA"Frankrijk,waar hij de fonteinen van"
25800 DATA"Versailles ontwierp en liet uitvoeren."
25810 DATA"Maar toen ze gereed waren,weigerde"
25820 DATA"Lodewijk XIV hem te betalen,tenzij hij"
25830 DATA"katholiek werd.Hij overleed van teleurstelling"
25840 DATA"in armoede in Parijs in 1687."
25850 DATA".   SIR JOHN NAPIER (1550-1617)"
25860 DATA".ook wel Neper,Napeir,Napair."
25870 DATA".Hij woonde meestal op zijn bezittingen"
25880 DATA"bij Edinburg.Hij verdeelde zijn tijd"
25890 DATA"tussen allerlei politieke of godsdienstige"
25900 DATA"twistvragen,een poging om te bewijzen,"
25910 DATA"dat de Paus de anti-Christus was en"
25920 DATA"wiskundige studies."
25930 DATA". ",".Neper bepaalde zijn wiskundige"
25940 DATA"studies vooral tot pogingen om rekenkundige"
25950 DATA"bewerkingen op KORTERE wijze te verrichten.",". "
25960 DATA".o.m.probeerde Neper het cijferen te bekorten"
25970 DATA"door logaritmen in 1614."
25980 DATA"#      NEPER (vervolg)"
25990 DATA".Het gronddenkbeeld van Neper is vergelijking"
26000 DATA"van een rekenkundige met een meetkundige"
26010 DATA"reeks.De termen van de rekenkundige reeks"
26020 DATA"gaven de aantallen van de verhoudingen"
26030 DATA"aan,die de reden van de meetkundige reeks"
26040 DATA"voorstellen."
26050 DATA".LOGARITME betekent AANTAL VERHOUDINGEN",". "
26060 DATA".De Neperse logaritmen verschillen van de"
26070 DATA"natuurlijke logaritmen,die e als grondtal"
26080 DATA"hebben,al worden de Nat.log wel per abuis"
26090 DATA"Neperse log.genoemd."
26100 DATA".De Neperse log.nemen af als de getallen"
26110 DATA"aangroeien,terwijl de Nat.log.dan juist"
26120 DATA"toenemen."
26130 DATA". ","Logaritme is de Griekse afkorting van"
26140 DATA"'numerus proportionis' = 'reden-getal."
26150 DATA"Die naam is te begrijpen op grond van de"
26160 DATA"Griekse 'reden-theorie',waarin de reden"
26170 DATA".  2    2"
26180 DATA". a  : b   de DUBBEL-REDEN heet van"
26190 DATA". ",". a : b  en",". "
26200 DATA".  3    3"
26210 DATA". a  : b   de TRIPEL-REDEN."
26220 DATA". ",".Voegt men nu met NAPIER (1550-1617)"
26230 DATA"aan een meetkundige reeks",". "
26240 DATA".         2     n"
26250 DATA".a  ar  ar ...ar",". "
26260 DATA".een rekenkundige reeks",". "
26270 DATA".0   1   2.....n  toe,",". "
26280 DATA". ",".dan heet n het reden-getal of"
26290 DATA"logaritme van"
26300 DATA".     n                    n"
26310 DATA".   ar   ,omdat de reden ar : a volgens"
26320 DATA"bovenstaande terminologie de n-voudige is"
26330 DATA"van ar : a."
26340 DATA". ",".Het woord logaritme is door Napier"
26350 DATA"gevormd ter vervanging van"
26360 DATA".NUMERI ARTIFICIALES = kunstmatige getallen."
26365 DATA". "
26370 DATA".De verhouding tussen Nep.log en Nat.log"
26380 DATA"volgt uit de volgende formule",". "
26390 DATA".                            7"
26400 DATA".              7           10"
26410 DATA".Nep.log.y = 10  * Nat.log.--"
26420 DATA".                           y",". "
26430 DATA"# NEPER (vervolg)"
26440 DATA".Ofschoon Neper niet aan een grond-tal"
26450 DATA"voor zijn logaritme heeft gedacht,kan men"
26460 DATA"uit zijn tafel afleiden,dat de Neperse"
26470 DATA"logaritmen overeenkomen met die voor het"
26480 DATA".grond-tal   1:e"
26490 DATA"#   ADRIAAN VLACK (1628)"
26500 DATA".Ook wel Adriaen Vlacq,boekhandelaar te"
26510 DATA"Gouda vulde de logaritme-tafel van Briggs"
26520 DATA"aan,door de logaritmen van de getallen"
26530 DATA".   van 20000 tot 90000"
26540 DATA".te berekenen.In 1628 gaf hij die uit."
26550 DATA"Later vestigde Vlack zich in Londen."
26560 DATA"Hier liet hij een kleinere tafel in"
26570 DATA"7 decimalen verschijnen,die een groot"
26580 DATA"succes werd."
26590 DATA"#  WALLIS (1616-1703)"
26600 DATA".Opgeleid voor de Kerk,werd Wallis in 1649"
26610 DATA"toch benoemd tot hoogleraar in de"
26620 DATA"meetkunde te Oxford.Hij is een van de"
26630 DATA"oprichters van de Royal Society in 1663."
26640 DATA"Zijn beroemdste werk is het"
26650 DATA".'Arithmetica Infinitorum' uit 1655"
26660 DATA". ",".Hij loste o.m.een vraagstuk op,dat"
26670 DATA"voor het eerst gesteld werd door de"
26680 DATA"Paltzgraaf Prins Rubert:"
26690 DATA". ",".   -In een gegeven kubus een gat"
26700 DATA".    te maken,waar een evengrote kubus"
26710 DATA".    doorheen kan.-",". "
26720 DATA".Wallis vond de oplossing."
26730 DATA"#  WOLFRAM (rond 1778)"
26740 DATA".De uitgebreide tafel van natuurlijke"
26750 DATA"logaritmen is berekend door"
26760 DATA".           WOLFRAM ,"
26770 DATA".een Hollandse luitenant der artillerie."
26780 DATA"Zijn tafel geeft in 48 decimalen de"
26790 DATA"logaritmen van alle getallen tot 2200"
26800 DATA"en van alle ondeelbare en een groot aantal"
26810 DATA"deelbare getallen tussen 2200 en 10009.",". "
26820 DATA"De tafel verscheen in 1778 in"
26830 DATA".'Schulze's Neue und Erweiterte"
26840 DATA".Sammlung logaritmischer Tafeln.",". "
26850 DATA".Ze werd herdrukt in Vega's Thesauris 1794."
26860 DATA"# ",". ",". ",". ",". ",". "
26870 DATA".       LITERATUUR - OPGAVE"
26880 DATA"# LITERATUUR - OPGAVE"
26890 DATA".Lagere Algebra -eerste deel"
26900 DATA".P.Wijdenes"
26910 DATA".P.Noordhoff N.V.-1942"
26920 DATA".Groningen-Batavia",". "
26930 DATA".Vreemde woorden in de wiskunde"
26940 DATA".Dr.E.J.Dijksterhuis"
26950 DATA".P.Noordhoff N.V.-1939"
26960 DATA".Groningen-Batavia",". "
26970 DATA".Logaritmische en Goniometrische tafels"
26980 DATA".en bijtafels -uitgave D"
26990 DATA".Dr.B.Gonggrijp"
27000 DATA".P.Noordhoff N.V.-1942"
27010 DATA".Groningen-Batavia"
27020 DATA"# LITERATUUR-OPGAVE (vervolg)"
27030 DATA".Beknopte Geschiedenis der Wiskunde"
27040 DATA".J.Versluys"
27050 DATA".Amsterdam - A.Versluys -1902",". "
27060 DATA".Kleine Winkler Prins in kleur dl.5"
27070 DATA".Elsevier-Amsterdam/Brussel",". "
27080 DATA".De Tovertuin der Wiskunde"
27090 DATA".A.Niklitschek/J.C.Alders"
27100 DATA".W.J.Thieme & Cie -Zutphen",". "
27110 DATA".Van 1x1 naar integraal"
27120 DATA".Egmont Colerus"
27130 DATA".De Gemeenschap - Bilthoven"
27140 DATA"# LITERATUUR - OPGAVE (vervolg)"
27150 DATA".(speciaal voor c 64 bezitters)",". "
27160 DATA".Commodore Info 1/88 -pag.68"
27170 DATA".Benadering 'e' door Obbe Vermey",". "
27180 DATA".64'er - 11/84 - pag.160"
27190 DATA".'Einzeiler':Formatierte Ausgabe"
27200 DATA".(met uitleg) -Volker Walter"
27210 DATA"$$$$$"
29990 :
30000 REM**** OOIT VAN'E'GEHOORD?(2)**
30010 REM**** HISTORISCHE NOTITIES  **
30020 REM**** EN LITERATUUR OPGAVE  **
30030 REM**** (KOMPLETE TEKST IN    **
30040 REM****  DEEL 1)              **
30050 REM
30060 REM**** HARRY EYCK / NEER     **
30070 REM**** OP COMMODORE C/64     **
30080 REM**** JUNI 1988             **
30090 REM COPYRIGHT NOS HILVERSUM
