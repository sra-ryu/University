/*
<Verbindungen>
- Hamburg ↔ Berlin (300km)
- Berlin ↔ München (700km)
- Hamburg ↔ Köln (500km)
- Köln ↔ Frankfurt (300km)
- Frankfurt ↔ München (300km)
- Frankfurt ↔ Stuttgart (250km)
- Stuttgart ↔ München (200km)
*/

% connection(Abfahrt, Ankunft, Distanz)
connection(hamburg, berlin, 300).
connection(berlin, muenchen, 700).
connection(hamburg, koeln, 500).
connection(koeln, frankfurt, 300).
connection(frankfurt, muenchen, 300).
connection(frankfurt, stuttgart, 250).
connection(stuttgart, muenchen, 200).

/*
A. Gibt es eine 300km Verbindung zwischen Berlin und Hamburg?
connection(hamburg, berechnen, 300). 
true.

B. Gibt es eine Verbindung zwischen Müchen und Frankfurt?
connection(muenchen, frankfurt, _). 
false.

C. Wie weit ist es von Berlin nach München?
connection(berlin, muenchen, X). 
X = 700 ; 
false.

D. Find die Städte, die man direkt von Berlin fahren kann.
findall(X, connection(berlin, X, _), L).
L = [muenchen].

connection(berlin, X, _).
X = meunchen.

*/