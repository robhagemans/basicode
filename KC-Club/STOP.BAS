1000 A=100: GOTO 20: REM ### STOP ###
1010 SR$="Stoptest": HO=INT((HO-LEN(SR$)-6)/2)
1020 VE=0: GOSUB 110: GOSUB 150: PRINT: FR=1
1030 PRINT "Stop: FR =";FR: GOSUB 280
1040 PRINT "Tasteneingabe; 0 fuer aendern": GOSUB 250
1050 GOSUB 210: PRINT IN$; IN: IF IN$<>"0" THEN 1050
1060 INPUT"0: stop moeglich; 1: nicht; 2: Ende"; FR
1070 GOSUB 250: IF FR<2 THEN 1030
1080 GOTO 950
1090 REM ----Programm-Ende------
30000 REM Test auf Moeglichkeit der Stoptaste
30010 REM also CTRL C, BRK, Stop oder aehnlich
30020 REM erfolgt mit FR und GOSUB 270
30030 REM Wenn Sie das Programm mit BRK usw.
30040 REM unterbrechen, denken Sie bitte daran,
30050 REM mit GOTO 950 Ihren Rechner wieder in
30060 REM in den Normalzustand zu versetzen.
32000 REM -----------------------
32010 REM H. Voelz; 9.5.89; fuer Rundfunk
32020 REM XT-compatibler Rechner
