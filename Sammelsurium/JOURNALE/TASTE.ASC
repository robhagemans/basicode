1000 A=100:GOTO 20:REM ### TASTE ###
1010 SR$="Tastentest":HO=INT((HO-LEN(SR$)-6)/2)
1020 VE=0:GOSUB 110:GOSUB 150:PRINT
1030 PRINT"Tasteneingabe; 0 fuer Ende":GOSUB 250
1040 GOSUB 210:PRINT IN$;IN:IF IN$<>"0" THEN 1040
1050 GOSUB 250:GOTO 950
1060 REM ----Programm-Ende------
30000 REM Test der Tastatureingabe gemaess GOSUB 210
30010 REM und Demonstration von GOSUB 150, 250
32000 REM -----------------------
32010 REM H. Voelz; 9.5.89;24.8.89 fuer Rundfunk
32020 REM XT-compatibler Rechner
