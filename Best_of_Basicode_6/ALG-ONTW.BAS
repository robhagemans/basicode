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
 1010 REM*************************
 1020 REM* ALGEMENE ONTWIKKELING *
 1030 REM* Meerkeuzetest bo-bouw *
 1040 REM*************************
 1045 GOSUB 100
 1050 DIM N$(2),B$(3),GD(2)
 1060 RESTORE:VR=-1
 1070 READ A$,B$,C$,D$,E
 1080 VR=VR+1:IF A$="0" THEN 1100
 1090 GOTO 1070
 1100 GOSUB 100
 1110 VE=5:HO=0:GOSUB 110
 1120 PRINT"T E S T    A L G E M E N E"
 1130 PRINT"-------    ==============="
 1140 PRINT"           O N T W I K K E L I N G"
 1150 PRINT"           ======================="
 1160 VE=20:HO=0:GOSUB 110
 1170 PRINT"NOS BASICODE-2  <>  W.v.d.Elshout"
 1180 GOSUB 10000
 1200 REM* Uitleg *
 1210 GOSUB 100
 1220 PRINT"Voor dit spel hebben we 2 spelers no-"
 1230 PRINT"dig."
 1240 PRINT:PRINT"Naam speler 1: ";:INPUT N$(1)
 1250 IF N$(1)="" THEN N$(1)="ONBEKENDE"
 1260 PRINT:PRINT"Naam speler 2: ";:INPUT N$(2)
 1270 IF N$(2)="" THEN N$(2)="INCOGNITO"
 1280 GOSUB 100
 1290 PRINT"Speler 1: ";N$(1)
 1300 PRINT:PRINT"Speler 2: ";N$(2)
 1310 VE=8:HO=0:GOSUB 110
 1320 PRINT"Is dit goed ?  <j/n>";:GOSUB 210
 1330 IF(IN$="j") OR(IN$="J") THEN 1400
 1340 IF(IN$="n") OR(IN$="N") THEN GOSUB 100:GOTO 1240
 1350 GOSUB 250:GOSUB 250:GOSUB 250:GOTO 1310
 1400 VE=12:HO=0:GOSUB 110
 1410 PRINT"Wil je uitleg ?  <j/n>";:GOSUB 210
 1420 IF(IN$="j") OR(IN$="J") THEN 1500
 1430 IF(IN$="n") OR(IN$="N") THEN 1700
 1440 GOSUB 250:GOSUB 250:GOSUB 250:GOTO 1400
 1500 REM* Uitleg *
 1510 GOSUB 100
 1520 PRINT N$(1);" <> ";N$(2)
 1530 PRINT"====================================="
 1540 PRINT"Jullie gaan tegen elkaar spelen."
 1550 PRINT"Je krijgt vragen op allerlei gebied."
 1560 PRINT"We gaan dus kijken hoe jullie algeme-"
 1570 PRINT"ne ontwikkeling is."
 1580 PRINT"Als je een antwoord niet weet moet je"
 1590 PRINT"altijd raden, want het zijn meerkeuze"
 1600 PRINT"vragen. Ik laat steeds de score zien."
 1620 GOSUB 10000
 1700 GOSUB 100
 1710 PRINT"Hoeveel vragen wil elk van jullie ?"
 1720 PRINT"=> ";:INPUT HV
 1730 IF(HV<1) OR(HV>100) THEN GOSUB 250:GOTO 1700
 1740 VE=10:HO=0:GOSUB 110
 1750 PRINT N$(1);" & ";N$(2);","
 1760 PRINT:PRINT"Druk op een toets om te starten ..."
 1770 GOSUB 10000
 2000 REM* Speler 1*
 2010 B=0:GD(1)=0:GD(2)=0
 2020 B=B+1
 2030 GOSUB 100
 2040 RESTORE
 2050 PRINT N$(1);:SR=GD(1):GOSUB 300:PRINT" > ";SR$
 2060 PRINT N$(2);:SR=GD(2):GOSUB 300:PRINT" > ";SR$
 2070 PRINT"AAN DE BEURT: ";N$(1)
 2075 PRINT TAB(14);"SPEL NR. ";:SR=B:GOSUB 300:PRINT SR$
 2080 PRINT"====================================="
 2090 GOSUB 260:X=INT(VR*RV)+1
 2095 FOR Y=1 TO X
 2100 READ A$,B$(1),B$(2),B$(3),C
 2105 NEXT Y
 2110 VE=6:HO=0:GOSUB 110
 2120 PRINT"*************************************"
 2130 PRINT A$
 2140 PRINT"*************************************"
 2145 PRINT
 2150 PRINT"1> ";B$(1)
 2151 PRINT"2> ";B$(2)
 2152 PRINT"3> ";B$(3)
 2159 PRINT
 2160 PRINT"====================================="
 2170 VE=18:HO=0:GOSUB 110
 2180 PRINT"Antwoord-nummer: ";:GOSUB 210
 2190 IF(IN$="1") OR(IN$="2") OR(IN$="3") THEN 2300
 2200 GOSUB 250:GOSUB 250:GOSUB 250:GOTO 2170
 2300 SR=C:GOSUB 300
 2310 IF IN$=SR$ THEN GD(1)=GD(1)+1:GOTO 2400
 2320 GOSUB 100
 2325 FOR Z=1 TO 5
 2330 VE=10:HO=12:GOSUB 110
 2340 PRINT"F O U T"
 2345 GOSUB 250
 2350 GOSUB 110:PRINT"!!!!!!!"
 2360 GOSUB 250
 2370 NEXT Z
 2380 PRINT:PRINT"Het goede antwoord was:"
 2385 SR=C:GOSUB 300:PRINT SR$;"> ";B$(C)
 2390 GOSUB 10000:GOTO 3000
 2400 GOSUB 100
 2410 VE=10:HO=12:GOSUB 110
 2420 PRINT"P R I M A"
 2430 VE=11:GOSUB 110:PRINT"*********"
 2440 GOSUB 10000
 3000 REM* Speler 2*
 3030 GOSUB 100
 3040 RESTORE
 3050 PRINT N$(1);:SR=GD(1):GOSUB 300:PRINT" > ";SR$
 3060 PRINT N$(2);:SR=GD(2):GOSUB 300:PRINT" > ";SR$
 3070 PRINT"AAN DE BEURT: ";N$(2)
 3075 PRINT TAB(14);"SPEL NR. ";:SR=B:GOSUB 300:PRINT SR$
 3080 PRINT"====================================="
 3090 GOSUB 260:X=INT(VR*RV)+1
 3095 FOR Y=1 TO X
 3100 READ A$,B$(1),B$(2),B$(3),C
 3105 NEXT Y
 3110 VE=6:HO=0:GOSUB 110
 3120 PRINT"*************************************"
 3130 PRINT A$
 3140 PRINT"*************************************"
 3145 PRINT
 3150 PRINT"1> ";B$(1)
 3151 PRINT"2> ";B$(2)
 3152 PRINT"3> ";B$(3)
 3159 PRINT
 3160 PRINT"====================================="
 3170 VE=18:HO=0:GOSUB 110
 3180 PRINT"Antwoord-nummer: ";:GOSUB 210
 3190 IF(IN$="1") OR(IN$="2") OR(IN$="3") THEN 3300
 3200 GOSUB 250:GOSUB 250:GOSUB 250:GOTO 3170
 3300 SR=C:GOSUB 300
 3310 IF IN$=SR$ THEN GD(2)=GD(2)+1:GOTO 3400
 3320 GOSUB 100
 3325 FOR Z=1 TO 5
 3330 VE=10:HO=12:GOSUB 110
 3340 PRINT"F O U T"
 3345 GOSUB 250
 3350 GOSUB 110:PRINT"!!!!!!!"
 3360 GOSUB 250
 3370 NEXT Z
 3380 PRINT:PRINT"Het goede antwoord was:"
 3385 SR=C:GOSUB 300:PRINT SR$;"> ";B$(C)
 3390 GOSUB 10000:GOTO 3500
 3400 GOSUB 100
 3410 VE=10:HO=12:GOSUB 110
 3420 PRINT"P R I M A"
 3430 VE=11:GOSUB 110:PRINT"*********"
 3440 GOSUB 10000
 3500 IF HV=B THEN 4000
 3510 GOTO 2020
 4000 REM* Einde *
 4005 GOSUB 100
 4010 PRINT"*************************************"
 4020 PRINT"** E I N D R E S U L T A A T  SPEL **"
 4030 PRINT"*************************************"
 4040 VE=5:HO=0:GOSUB 110
 4050 PRINT N$(1);"=> ";:SR=GD(1):GOSUB 300:PRINT SR$
 4060 VE=8:GOSUB 110
 4070 PRINT N$(2);"=> ";:SR=GD(2):GOSUB 300:PRINT SR$
 4080 PRINT:PRINT
 4090 FOR Z=1 TO 3
 4100 PRINT"*************************************"
 4110 NEXT Z
 4120 VE=20:HO=10:GOSUB 110
 4130 PRINT"(C)1988, W.v.d.Elshout."
 4140 END
10000 REM* Toets *
10010 VE=22:HO=35:GOSUB 110
10020 PRINT"==";:GOSUB 200
10030 IF IN$="" THEN 10040
10035 RETURN
10040 FOR WA=1 TO 50:NEXT WA
10045 GOSUB 110:PRINT"<>";:GOSUB 200
10050 IF IN$="" THEN 10010
10060 RETURN
25000 DATA"Hoe noemt men illegale radiozenders?"
25010 DATA"amateurs","piraten","disc-jockeys",2
25012 DATA"Wie zijn uitvinders van ons alfabet?"
25014 DATA"Feniciers","Turken","Hollanders"
25015 DATA 1
25016 DATA"Zijn vliegende reptielen vogels?"
25018 DATA"nee","ja","soms",1
25020 DATA"Waar ligt de Tyrrheense Zee?"
25022 DATA"Perzie","Tibet","Italie",3
25024 DATA"Wanneer is de HERFSTMAAND?"
25026 DATA"Augustus","September","Oktober",2
25028 DATA"Wat is een MONDORGEL"
25030 DATA"pijporgel","harmonica","harmonium",2
25032 DATA"Bij welk land hoort MADEIRA-ARCHIPEL?"
25034 DATA"Portugal","Madeira","Spanje",1
25036 DATA"Wat zijn KARVELEN, BRIKKEN en BARKEN?"
25038 DATA"schaatsen","schepen","stenen",2
25040 DATA"Van welk dier brengt de poot geluk?"
25042 DATA"olifant","haas","konijn",3
25044 DATA"Waar komt een GROTE TERTS voor?"
25046 DATA"muziek","waterpolo","skieen",1
25048 DATA"Wat is MON CHOU?"
25050 DATA"pudding","kaas","soort appel",2
25052 DATA"Welke R. bracht rozen naar Sandra?"
25054 DATA"Ron Brandsteder","Richard Tauber"
25055 DATA"Ronnie Tober",3
25056 DATA"Waarop 'klopt men iets af'?"
25058 DATA"tafel","aanrecht","hout",3
25060 DATA"Wat betekent ORANG OETANG?"
25062 DATA"Rhesusaap","Man van het bos"
25063 DATA"Afstammeling",2
25064 DATA"Waar is TSJERNOBYL van bekend?"
25066 DATA"badplaats","revolutie","kernramp",3
25068 DATA"Iemand die afhankelijk is eet ....."
25070 DATA"genadebrood","brood en spelen"
25071 DATA"peperkoek",1
25072 DATA"Wat is een GALJOEN"
25074 DATA"geldbedrag","schip","munt",2
25076 DATA"Wat is een monocle"
25078 DATA"soort bril","geluidsinstallatie"
25079 DATA"gezelschapsspel",1
25080 DATA"Wat deed de Neanderthaler met doden?"
25081 DATA"verbranden","begraven","opeten",2
25082 DATA"Wat speelt u als u PANDOERT?"
25084 DATA"kaartspel","schaken","ganzebord",1
25086 DATA"Welke zoutjes zitten in mij?"
25088 DATA"nootjes","koekjes","chips",3
25090 DATA"Waar ligt SIERRA LEONE?"
25092 DATA"Zuid-Amerika","Noord-Amerika"
25093 DATA"Afrika",3
25094 DATA"Wat is EEN BLIJDE"
25095 DATA"Diploma voor consumptieve beroepen"
25096 DATA"Belegeringswerktuig"
25097 DATA"Timmermansgereedschap",2
25100 DATA"Wie was in wereldoorlog-1 neutraal?"
25102 DATA"Verenigde staten","Italie","Nederland",3
25104 DATA"Wie was in wereldoorlog-2 neutraal?"
25106 DATA"Zwitserland","Italie","Nederland",1
25108 DATA"In welke sport blinkt Etheopie uit?"
25110 DATA"hoogspringen","hardlopen","schaken",2
25112 DATA"Welke kerk kent JUBELJAREN?"
25114 DATA"Rooms-Katholieke kerk","Protestantse kerk"
25115 DATA"Geen kerk",1
25116 DATA"Welke H. richtte HARLEKIJN HOLLAND op"
25118 DATA"Henk Elsink","Tineke Schouten"
25120 DATA"Herman van Veen",3
25122 DATA"Wat is een KURAS?"
25124 DATA"steekwapen","motoronderdeel","harnas",3
25126 DATA"Waar ligt het hoofdkwartier van de VN"
25128 DATA"USA","Brussel","Londen",1
25130 DATA"Welk foto-hulpmiddel dateert uit 1930"
25132 DATA"pocket-camera","filmcamera","flitslamp",3
25134 DATA"Hoe heette de eerste mens in Europa?"
25136 DATA"Neanderthaler","Batavier","Germaan",1
25138 DATA"Waar liggen de EVERGLADES?"
25140 DATA"Schotland","Florida","Australie",2
25142 DATA"Wat is de PRINSEMARIJ?"
25144 DATA"Marine","Politie","Het hof",2
25146 DATA"Waar ligt HET BINNENHOF?"
25148 DATA"Amsterdam","Den Bosch","Den Haag",3
25150 DATA"Wat was een RAPIER?"
25152 DATA"hofdame","ridder van adel","degen",3
25154 DATA"Wat is een LEONE?"
25156 DATA"Munt van Sierra Leone","vrijheidstrijder"
25158 DATA"Italiaans gerecht",1
25160 DATA"Welke omroep werkt met een kompas?"
25162 DATA"VARA","NOS","TROS",3
25164 DATA"Wat was het beroep van mijnh. Celsius"
25166 DATA"Monnik","Sterrenkundige","Architect",2
25168 DATA"Wat is een FOBOFOOB?"
25169 DATA"Iemand die bang is voor fobieen"
25170 DATA"Insekt","Belichtingsmeter",1
25172 DATA"Het Kaukasusgebergte ligt in ..."
25174 DATA"Europa en Australie"
25176 DATA"Rusland","Europa en op de maan",3
25178 DATA"Waar ligt het Kroeller-Mueller museum"
25180 DATA"West-Duitsland","Oost-Duitsland"
25181 DATA"De Hoge Veluwe",3
25182 DATA"Dat is SCHERING en ....."
25184 DATA"NERING","INSLAG","GEEN VAN TWEE",2
25186 DATA"Het TV-programma VERONA heette eerst"
25188 DATA"Koot & Bie","De Boerderie","Pisa",3
25190 DATA"Wanneer ontstond de MARSEILLAISE?"
25192 DATA"tijdens de eerste wereldoorlog"
25193 DATA"tijdens de Franse Revolutie"
25194 DATA"na de 80-jarige oorlog",2
25196 DATA"In welk gebergte leven de ALPACA'S?"
25198 DATA"Andes","Alpen","Oekraine",1
25200 DATA"Wat betekent S.O.S.?"
25202 DATA"Stichting Onze Samenwerking"
25204 DATA"Save OurSelves","Save Our Souls",3
25206 DATA"Waar ligt het vliegveld KLOTEN?"
25208 DATA"Zwitserland","Belgie","Oostenrijk",1
25210 DATA"Wie was DOLLFUSS?"
25211 DATA"Een typetje van Dorus"
25212 DATA"Een Oostenrijks staatsman"
25213 DATA"Een Nazi-misdadiger",2
25214 DATA"Wat staat op het biljet F250,-- ?"
25216 DATA"Snip","Koningin","Vuurtoren",3
25218 DATA"Wat betekent 4711 bij het reukwater?"
25220 DATA"Huisnummer van het bedrijf"
25221 DATA"Eerste telefoonnummer"
25222 DATA"Scheikundige code",1
25224 DATA"Waar werd het ENGLANDSPIEL bedreven?"
25226 DATA"Nederland","Duitsland","Engeland",1
25228 DATA"Waar hadden sommige pausen hun zetel?"
25230 DATA"Parijs","Avignon","Lourdes",2
25232 DATA"Wie richtten DE MOUNTIES op?"
25233 DATA"Piet Bambergen en Rene van Vooren"
25234 DATA"Piet Bambergen en Piet Muijselaar"
25235 DATA"Piet Bambergen en Fred Plevier",3
25236 DATA"Wat is goed:"
25237 DATA"Ratten horen tot de familie Muizen"
25238 DATA"Muizen horen tot de familie Ratten"
25239 DATA"Geen van beiden",1
25240 DATA"Welke acteur speelt J.R. in Dallas?"
25242 DATA"Bobby Ewing","Larry Hagman","Harry Lagman",2
25244 DATA"Wat is een PATER NOSTER?"
25246 DATA"kapelaan","personenlift","sterke drank",2
25248 DATA"Waarvan is het anker het symbool?"
25250 DATA"Strijd","Liefde","Hoop",3
25252 DATA"Welk spel maakt u van GIN en RUM?"
25253 DATA"Rummicup","Ginrummy","Poker",2
25254 DATA"Waar staat MICHIEL DE RUYTER?"
25256 DATA"Vlissingen","Breskens","Terneuzen",1
25258 DATA"Wat betekent ARMA CHRISTIE?"
25260 DATA"Soldaten van God","Martelwerktuigen"
25262 DATA"De armen onder ons",2
25264 DATA"Wat betekent CARTE BLANCHE?"
25266 DATA"IJs met warme chocoladesaus"
25268 DATA"Landkaart zonder straten"
25270 DATA"Blanco volmacht",3
25280 DATA"Wie was de oudste koloniale macht ?"
25282 DATA"Engeland","Portugal","Spanje",2
25284 DATA"Wat betekent 1 Olympische ring ?"
25286 DATA"Een land","Een sport-tak","Een continent",3
25288 DATA"Wat geeft het KARAAT bij diamant aan?"
25290 DATA"hardheid","gewicht","kleur",2
25292 DATA"Waar liggen de VOGEZEN ?"
25294 DATA"Frankrijk","West-Duitsland","Oostenrijk",1
29999 DATA"0","0","0","0",0
30000 REM***************************
30010 REM* Walther van den Elshout *
30020 REM* van Gorkumlaan 151      *
30030 REM* 5641 WP  Eindhoven      *
30040 REM*                         *
30050 REM* Aquarius 32K - 38 Char. *
30060 REM*                         *
30070 REM* COPYRIGHT NOS HILVERSUM *
30080 REM***************************
