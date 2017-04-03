1000 A=100: GOTO 20: REM ## BASHILF ## 
1010 GOSUB 100: A$=CHR$(34): SR$="Beschreibung von BASHILF"
1020 H=HO: HO=INT(H/2)-15: VE=0: GOSUB 110: GOSUB 150: PRINT
1030 PRINT"H. Voelz";TAB(H-9);"18.6.89":PRINT
1040 PRINT"Dieses Programm hilft bei der Umwandlung von"
1050 PRINT"BASIC-Programmen in BASICODE-Programme und ist"
1060 PRINT"nutzbar fuer Programme, die auf den KC-Rechnern"
1070 PRINT"geschrieben wurden. Dabei wird der folgende"
1080 PRINT"Ablauf empfohlen:":PRINT
1090 PRINT"1. Laden des BASIC-Programms,"
1110 PRINT"2. Anfertigen eines Ausdrucks,"
1120 PRINT"3. Mit BYE zurueck in das Betriebssystem,"
1130 PRINT"4. Laden von BASHILF,"
1140 PRINT"5. Starten von BASHILF,"
1150 PRINT"6. REBASIC bzw. WBASIC,"
1160 PRINT"7. Editieren des geaenderten BASIC": GOSUB 210
1170 PRINT"Es werden mit BASHILF folgende Aenderungen auto-"
1180 PRINT"matisch durchgefuehrt:":PRINT
1190 PRINT"1. Das unerlaubte REM-Zeichen <!> wird durch REM"
1200 PRINT"   ersetzt."
1210 PRINT"2. Alle unerlaubten Befehle werden durch ein <#>"
1220 PRINT"   ersetzt. Hierfuer muessen aehnliche Loesungen"
1230 PRINT"   mit BASICODE gesucht werden."
1240 PRINT"3. Hinter den Befehlen AND, DIM, INPUT, NOT, OR,"
1250 PRINT"   ON wird ein Fragezeichen geschrieben. Hierbei"
1260 PRINT"   wird ein eventuell direkt folgendes Zeichen"
1270 PRINT"   ueberschrieben. Deshalb ist der o.g. Ausdruck"
1280 PRINT"   zum Vergleich sinnvoll. Das Fragezeichen ist"
1290 PRINT"   aus folgenden Gruenden gesetzt:"
1300 PRINT" - Nach AND, OR und NOT und AND, OR muessen die"
1310 PRINT"   logischen Ausdruecke in Klammern stehen."
1320 PRINT" - DIM darf maximal zwei Dimensionen besitzen,"
1330 PRINT"   also z.B. A(7,9).": GOSUB 210
1340 PRINT" - INPUT darf keinen Prompt-String besitzen,"
1350 PRINT"   also INPUT";A$;"Name";A$";A ist durch:"
1360 PRINT" PRINT";A$;"Name";A$;";: INPUT A zu ersetzen."
1370 PRINT"4. NEXT wird durch <&> ersetzt. Dies soll darauf"
1380 PRINT"   hinweisen, das NEXT Variable notwendig ist."
1390 PRINT"5. RESTORE wird durch <@> ersetzt. Dies soll"
1400 PRINT"   darauf hinweisen, daB nach RESTORE keine"
1410 PRINT"   Zeilennummer stehen darf.":PRINT
1430 PRINT"editiert werden, besteht eine sehr groBe Chance,"
1440 PRINT"daB entsprechende Programm unter BASICODE zum"
1450 PRINT"Laufen zu bringen.": PRINT: GOSUB 210
1460 GOTO 950
32001 REM fuer Rundfunk geschrieben zu Programm BASHILF
32002 REM XT-compatibler Rechner
