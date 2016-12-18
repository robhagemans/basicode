BasiCode - ein Esperanto fr Heimcomputer

Ein CPC 6128-Programm l„uft nicht auf dem 464? Wir laden den 6128-Emulator
in den 464 und es kann losgehen! Aus beruflichen Grnden muá ich zu Hause
einen IBM-Kompatiblen nutzen, m”chte nicht meine altvertrauten CPC-Programme
missen, aber auf dem Schreibtisch hat nur einer Platz (Sangen nicht schon
The Sparks: This Desk Ain't Big Enough For The Both Of Them)? Es gibt auch
einen CPC-Emulator fr den PC und schon spiele ich auf letzterem Zap'T'Balls
und Prehistorik II! Mein Sohn lernt die ersten BASIC-Schritte, gleich ihm
einige seiner Freunde, sie wollen gemeinsam knobeln, aber jeder hat von
seinen Eltern einen anderen Heimcomputer bernommen? Kinder, fangt ihr doch
nicht auch schon mit dem Streit an, welcher Computer besser sein soll! Nehmt
einen Emulator und arbeitet alle auf demselben! Wer wen emulieren soll? 
Streitet euch nicht! Wir definieren einen fiktiven Computer, und den
emulieren alle! Was heiát, sch”n w„rs? Diese Fiktion eines Computers gibt es
schon seit ber fnfzehn Jahren und der Emulator heiát BasiCode!

Damals stellten sich einige Niederl„nder das hehre Ziel, den Heimcomputer-
freaks eine gemeinsame Plattform anzubieten, damit sie, statt sich von den
Konkurrenzk„mpfen zwischen den einzelnen Herstellern entzweien zu lassen,
eine Chance fr ein friedliches und fruchtbares Miteinander erhalten.

BasiCode ist ein System von Vereinbarungen mit dem Ziel weitreichender
Kompatibilit„t von eigentlich unkompatiblen Computern. Diese Vereinbarungen
betreffen den Befehlsvorrat, das Speicherungsverfahren und den juristischen
Aspekt.

Entsprechend dieser Zielsetzung wird auf den "Geringsten unter den Brdern"
Rcksicht genommen, weswegen BasiCode fr manchen Einschr„nkungen bedeutet,
einem anderen aber erweiterte M”glichkeiten beschert. BasiCode ist nur
verwendbar fr reine BASIC-Programme, nicht fr computerspezifische
Maschinenroutinen. Auch wird das BASIC noch langsamer, doch wer wirklich an
Austausch mit anderen Computertypen interessiert ist, wird das im Interesse
der Kompatibilit„t in Kauf nehmen. BasiCode nutzt als Speichermedium die
Kassette (unabh„ngig davon k”nnen die BasiCode-Programme auf gewohnte Weise,
auch auf Diskette, gespeichert werden), denn mancher hat immer noch keine
Diskettenstation, und wenn, macht es immer noch Schwierigkeiten, eine 5,25"-
Diskette in ein 3"- oder 3,5"-Laufwerk zu bekommen...  

Was BasiCode kann, Programme in Form von ASCII-Listings in unterschiedliche
Computer zu transferieren, kann CP/M auch, aber BasiCode kann es auch ohne
Disketten und sorgt zudem fr eine gemeinsame Programmiersprache ohne
Dialektabweichungen. Nehmen wir ein Beispiel: An einer definierten Stelle
des Bildschirms soll ein Wort ausgedruckt werden. Unser CPC sagt: LOCATE 5,3:
PRINT "HALLO", ein K 8915: PRINT CHR$(27);CHR$(132);CHR$(130);"HALLO",
der KC 85/3: PRINT AT 5,3 "HALLO", der C 64: POKE 211,5:POKE 214,3:SYS 58640:
PRINT"HALLO". BasiCode sagt: HO=5:VE=3:GOSUB 110: PRINT "HALLO". Auf den
ersten Blick der aufwendigste Weg, aber er funktioniert auf allen vier
Computern, sofern sie unter BasiCode arbeiten, denn in Zeile 110 wird
entsprechend den Parametern HO und VE der Textcursor positioniert, in Zeile
110 stehen die hierfr erforderlichen computerspezifischen Befehle, die vom
computerunabh„ngigen Programm gefordert werden.

Das Programm, das den Computer veranlaát, sozusagen unter der Benutzer-
oberfl„che BasiCode zu arbeiten, der Bascoder, ist, natrlich, fr jeden
Computer anders. Aus den beiden unten genannten Bchern ist mir bekannt,
daá es Bascoder fr ca. 30 Computer gibt, ZX Spectrum, ZX 81, Dragon,
Apple II, Dragon, BBC A + B, Atari, C 64, Z 1013, KC 85/3 und /4, KC 87,
CPC ...

Der Bascoder untergliedert sich in einen Teil zum Realisieren g„ngiger BASIC-
Befehle trotz unterschiedlicher Syntax, der die Befehlszeilen von 1 bis 999
belegt, und in einen Teil zum Erzeugen und Verarbeiten der BasiCode-ASCII-
Kassettenfiles, welcher meist in Maschinencode geschrieben ist.

Das eigentliche BasiCode-Programm belegt die Programmzeilen ab 1000, hierfr
gelten weitere Hinweise, die in den unten genannten Bchern nachgelesen
werden k”nnen, um hier nicht den Rahmen zu sprengen.

Die Aufzeichnung der BasiCode-Programme erfolgt als ein einziges ASCII-File,
also nicht in mehreren Bl”cken, nach einem in /2/ detailliert beschriebenen
Schema, das eine hohe šbertragungssicherheit bietet, was zu Lasten der
Geschwindigkeit geht, weil man wie berall im Leben nicht alles auf einmal
haben kann. Auch Bin„rfiles k”nnen aufgezeichnet werden, hier erfolgt eine
Untergliederung in 1024 Byte groáe Bl”cke. BasiCode-Programme wurden schon
durch Rundfunk bertragen und sogar auf Mittelwelle erfolgreich empfangen.

Soviel zum Sprachumfang und Speicherverfahren von BasiCode, nun noch ein paar
Worte zur urheberrechtlichen Seite. Die Autoren dieses Programmsystems haben
sich in einer Stiftung zusammengeschlossen, der Nederlandse omroep Stichting
(NOS), und zur F”rderung des BasiCode-Gedankens auf pers”nliche materielle
Vergtung verzichtet. Programme anderer Autoren darf man zwar weiter-
entwickeln, aber die neue Version nicht ohne Einverst„ndnis des Autors
verbreiten. Der Name des Autors darf bei einer Kopie nicht entfernt werden.
Auch šbersetzungen bedrfen der Genehmigung des Autors. Programme in BasiCode
drfen nicht verkauft oder in sonstiger Weise zur pers”nlichen Bereicherung
genutzt werden. Wenn sich die NOS auch 1991 aufgel”st hat, sollte es trotzdem
eine Frage des Anstands sein, diese Maágaben weiter zu respektieren.

Ursprnglich (1979) war BasiCode nur ein einheitliches Speicherungsverfahren.
Sp„ter kam die Umsetzung von Befehlen unterschiedlichen Wortlauts bei
gleicher Zielstellung in einheitliche Syntax hinzu (BASICODE-1) und wurde
verbessert (BASICODE-2). Zu diesem erschien 1984 in Deutschland /1/. Es
enth„lt auf einer Kassette 14 BasiCode-Programme und Bascoder fr zwei
Dutzend Computer, leider noch nicht fr den CPC, der war ja taufrisch.
BASICODE-3 (1988) vereinheitlicht weitere Befehle: zur Musikausgabe, zur
Arbeit mit Files, zur Grafik-Mode-Nutzung. Auf der /2/ beiliegenden Schall-
platte ist endlich auch der CPC-Bascoder, fr den Herrn Sjef Simons und
Herrn Marius van der Meer der besondere Dank der CPC-Gemeinde gebhrt,
weiterhin vor allem Bascoder fr in der damaligen DDR verbreitete Heim-
computer. Als Listings enth„lt /2/ auáerdem weitere fnf BasiCode-Programme.

BASICODE-3 steht auch fr 16-Bit-PCs zur Verfgung, ist allerdings auf der
Schallplatte nicht enthalten, es wird auf Disketten verwiesen. Hier bietet
sich der Programmaustausch ber Disketten (oder serielle Kopplung / DFš) an, 
es gibt aber auch eine nicht schwer nachzubauende L”sung, am Parallelport
BasiCode-Kassetten einzulesen oder zu beschreiben.

1991 erfolgte die letzte Weiterentwicklung zum BASICODE-3C. Das C steht fr
Color, fr Text- und Grafikausgaben sind nun acht Farben zugelassen. Zwei
weitere Verbesserungen in dieser Version betreffen den Screen-Dump von Texten
und die Nutzung der Funktionstasten, soweit vorhanden. Diese Farb-Version
stand zun„chst fr den Commodore C-64, MSX-1, MSX-2, Schneider/Amstrad CPC
und den Philips P 2000 zur Verfgung, sp„ter fr den KC 85/4, IBM-Kompatible
sowieso, jngere Informationen liegen mir nicht vor.

Nach meiner Auffassung muá aber BasiCode wegen der Verdr„ngung der Kassette
als Speichermedium nicht sterben, sondern kann sich mittels CP/M, MS-DOS usw.
sogar noch weiter verbreiten, Bascoder máten dann NUR noch die Dialekt-
Vereinheitlichung realisieren. Es ist nur peinlich darauf zu achten, die
BasiCode-Programme zum Weitergeben nur ab Zeile 1000 und unbedingt in ASCII-
Form abzuspeichern, wie es dem Konzept von BasiCode entspricht. Ein fremder
Computer kann mit Token ebensowenig anfangen wie mit dem nicht fr ihn
geschriebenen Bascoder!

Doch nun endlich zu meinen eigenen Erfahrungen mit BasiCode. Den Bascoder
fr den KC compact (DDR-Nachbau des CPC von Schneider/Amstrad) schnitt ich
mir auf Tonband um und hatte keine Probleme mit dem Einlesen. Die kamen erst,
als ich mir das Gleiche fr den KC 85/3 vornahm. Hier muáte ich mir eine
lauff„hige Version aus den Umschnitten von drei oder vier Exemplaren der
Schallplatte zusammenstoppeln. (Der KC 85/3 ist ein DDR-Heimcomputer, der
zwar ein unattraktives Design aufzuweisen hat, fr den es aber dennoch
Programme mit sehr ansprechender Grafik und nettem Sound gibt, der ausbauf„hig 
konzipiert ist und fr den es auch die unterschiedlichsten Erweiterungsmodule
gibt und der in seiner Diskettenversion auch CP/M-f„hig ist.) Dafr klappte
das gegenseitige Lesen der BasiCode-Files auf Anhieb und bereitete auch
seitdem nie Probleme. Es ist sogar gelungen, BasiCode sozusagen als DFš-
Protokoll zu verwenden, also Programme gleich per Kabel in den anderen
Computer zu schicken.

Auch mit einem C64-User schloá ich mich probehalber einmal kurz - ebenfalls
Null Problemo. In letzter Zeit nutze ich BasiCode (mit Transfer per Diskette)
ebenso problemlos am PC, sowohl direkt als auch ber die Emulation des CPC. 
Selbst so ein PC kann doch zu etwas ntze sein...

Wenn BasiCode vielleicht teilweise vorhandene BASIC-M”glichkeiten einschr„nkt
(das Programm soll ja auch auf einem simpleren als meinem Computer lauff„hig
sein), heiát das dennoch nicht, das unter BasiCode keine leistungsf„higen
Programme m”glich sind. Adressen, Briefmarkensammlungen, Bundesligaergebnisse
oder sonstige Daten k”nnen verwaltet werden, ein Kalender mit festen und
beweglichen Feiertagen kann gedruckt werden, die Steuer kann berechnet
werden, wofr der Verlag (sofern das Angebot noch gilt) j„hrliche Updates
anbietet, Verzinsung von Guthaben oder Schulden, Sammelbestellung und Text-
verarbeitung sind m”glich (/1/), von den Grafikm”glichkeiten sollen die drei
Bildschirmabzge des Miniatlas und der Hiddenline-Darstellung aus /2/ einen
Eindruck vermitteln. Die Vielfalt der Anwendungen trotz der selbstauferlegten
Beschr„nkungen ist verblffend, auch Spiele und Musikprogramme liegen in
BasiCode vor, Fraktale k”nnen erarbeitet werden, Zeichenprogramme gibt es
ebenso wie Anwendungen fr den Elektronikbastler. Wohlgemerkt: jedes dieser
Programme ist auf den unterschiedlichsten Heimcomputern lauff„hig!

Wie erfolgt nun die Arbeit mit BasiCode auf unserem CPC? RUN"BASCODER" l„dt
und startet den Bascoder, der als erstes selbstt„tig den Bin„rteil
(BC3BIN.BIN) einliest. Anschlieáend erscheint ein Men mit einem Copyright-
hinweis, drei Befehlen und dem Hinweis, daá zu diesem Men jederzeit der
RSX-Befehl |HELP fhrt. Die drei Befehle: B fhrt in den gewohnten BASIC-
Editor zurck, L l„dt und startet das erste BasiCode-File von Kassette
(entsprechend RUN") und W speichert das Programm als BasiCode-File.

Nach Eingabe von L erscheint auf dem MODE 2-Bildschirm in der letzten Zeile
wieder der Copyright-Vermerk und auf dem restlichen Schirm werden fortlaufend
und ohne Scrolling die eintreffenden Zeichen angezeigt. Schraffierte Felder
bedeuten fehlerhafte Zeichen. M”gliche Meldungen nach dem Einlesen sind
Checksumerror, Memory full oder keine. In jedem Fall startet dann die
Umsetzung in CPC-Token, w„hrend der das Programm abermals gelistet wird.
Sind šbertragungsfehler aufgetreten, ist deren Korrektur gew”hnlich aus dem
Zusammenhang ableitbar, da die Aufzeichnung als ASCII-Daten erfolgte und
h”chstens ab und zu ein Zeichen fehlt, dessen Position auáerdem angezeigt
wird.

W startet die Aufzeichnung ab Zeile 1000 auf Kassette, auf dem Screen steht
nach der Copyright-Information Writing BasiCode - WAIT!

Fr CPC-Nutzer ein wichtiger Hinweis: Das Programm "BASCODER.BAS" enth„lt
eine Zeile 0, die beim Listen nicht erscheint. Fehlte diese Zeile 0, wrde
die BasiCode-Subroutine 220 (Holen eines Zeichens vom Bildschirm) nicht
korrekt laufen k”nnen, die ein sieben Byte langes Maschinencodeprogramm
aufruft, das in dieser unsichtbaren Zeile untergebracht ist.

Fr die Diskettenarbeit empfehle ich folgenden Weg: zun„chst erlaube ich mir,
den Bascoder leicht abzuwandeln. Zeile 1000, die den Bin„rteil nachl„dt und
beim Laden eines BasiCode-Programms berschrieben wird, l”sche ich, statt-
dessen erg„nze ich Zeile 5 um die Passage
 IF PEEK(&9E20)<>&7E THEN MEMORY &9200-1:LOAD"!bc3bin.bin":CALL &A585:|HELP
Den so ge„nderten Bascoder speichere ich unter dem Namen BASCODER.BAS.

Befindet sich nun im CPC ein BasiCode-Programm, das gespeichert werden soll,
wird zun„chst der Bascoder mit DELETE-999 gel”scht. Das restliche Programm
wird um folgende Zeile erg„nzt: 950 CHAIN MERGE "BASCODER.BAS" und mit
SAVE "filename.BC3" gespeichert.

Wessen CPC keine Token-Files MERGEn kann, der sollte natrlich den Bascoder
als ASCII-File speichern. ACHTUNG! Hierbei wrde Zeile 0 verloren gehen.
Um das zu vermeiden, muá vor dem SAVEn als ASCII-File gePOKEt werden: 
POKE &172,1:POKE &199,2. Nun ist allerdings peinlich darauf zu achten daá 
der jetzt vorhandenen Zeile 1 (die bisherige heiát nun 2) kein H„rchen
gekrmmt wird, um die Funktion von GOSUB 220 nicht zu gef„hrden.

Das BasiCode-Programm wird mit RUN "filename.BC3" gestartet, l„dt den
Bascoder nach, wobei Zeile 950 berschrieben wird, dann liest es den Bin„r-
teil ein und startet.

Eine andere Methode, die, jedenfalls ab dem zweiten Programm, mehr Raum auf
der Diskette beansprucht, ist, das Programm zusammen mit dem Bascoder zu
SAVEn. Die Handhabung habe ich in einem CPC-Layout noch einmal zusammengefaát.

In /2/ wird darauf hingewiesen, das GOSUB 220 nicht korrekt arbeitet, wenn
sich an der Bildschirmposition des Cursors ein invertiert dargestelltes
Zeichen befindet. Mein Vorschlag zur Behebung dieses kleinen Sch”nheits-
fehlers ist das Ab„ndern der Zeilen 223 bis 227 in folgende Form:
   
   223 LOCATE INT(HO+1),INT(VE+1):GOSUB 227
   224 IF IN=143 THEN IN=32:GOTO 216
   225 IF PEEK(&177)<>0 THEN 216 ELSE PRINT CHR$(24);:GOSUB 227:PRINT CHR$(24);
   226 IF IN$="" THEN IN$=" ":GOTO 216 ELSE 216
   227 CALL &179:IN=ASC(UPPER$(CHR$(PEEK(&177)))):RETURN

Ausgangsposition fr diese Ver„nderungen ist die Version 4.1 des CPC-Bas-
coders, die Version, die auf der dem DDR-BasiCode-Buch beiliegenden Schall-
platte ver”ffentlicht ist.

Diese Version enth„lt noch drei kleine Fehler, zwei davon werden nur CPC-464-
Usern auffallen: GOSUB 280 (Sperren/Freigeben der BREAK-Taste) verwendet den
Befehl ON BREAK CONT, den das BASIC 1.0 noch nicht kennt, wird er durch
GOSUB 301 ersetzt (dort steht nur ein RETURN), ist das Problem schon behoben.
bei GOSUB 450 (Warten auf Tastendruck) wird die verbrauchte statt der brig-
gebliebenen Zeit zurckgegeben - nderung: 454 SD=SD-INT((TIME-OTIME)/30).
Die Entdeckung dieser beiden Fehler und ihr Umgehen sind Herrn Olaf Krause
zu verdanken, er erw„hnte sie in SLINFO, dem Kommentar zu den Spielen SLIDER1
und SLIDER2, BasiCode-Adaptionen des vom PC bekannten SOKOBAN. Der dritte,
auch nur unter BASIC 1.0 zutagetretende, Fehler liegt in Zeile 310: auf dem
CPC 464 erfordert der DEC$-Befehl eine zus„tzliche ”ffnende Klammer.

Wer die unten aufgefhrten Bcher nicht auftreiben kann (Handel, Bibliotheken,
Fernleihe), kann sich mit einem adressierten und ausreichend frankierten
Rckumscschlag mit einer leeren Kassette oder formatierten 5,25"-Diskette
(Vortex 80 tracks, double sided) an mich wenden: Thomas Rademacher Rost-
straáe 4 D-99086 Erfurt. Bei Bedarf kopiere ich auáer den beiden Programm-
files auch zwei Context-Seiten mit den wichtigsten Regeln. Vielleicht findet
man alles auch im RS bzw. auf der RS-Disk.

/1/ Michael Wiegand; Manfred und Heike Fillinger: Basicode. Otto Maier Verlag
Ravensburg 1984 ISBN 3-473-44010-8
/2/ Horst V”lz (federfhrender Autor): Basicode. Verlag Technik, Berlin 1990
Bestellnummer: 554 342 0 ISBN 3-341-00895-0
