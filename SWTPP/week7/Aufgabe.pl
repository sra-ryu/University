/* FAKTEN */
connect(hamburg, berlin, 300).
connect(berlin, muenchen, 700).
connect(hamburg, koeln, 500).
connect(koeln, frankfurt, 300).
connect(frankfurt, muenchen, 300).
connect(frankfurt, stuttgart, 250).
connect(stuttgart, muenchen, 200).

/* Regeln */
directConnection(X,Y,S) :- connect(X,Y,S) ; connect(Y,X,S).

dayTrip(X,Y,Max,S) :- directConnection(X,Y,S), S =< Max.

oneStopConnection(A,B,L) :- directConnection(A,VIA,L1),
                            directConnection(VIA,B,L2), L is L1+L2.

shortestOneStop(A,B, VIA,L) :- directConnection(A,VIA,L1),
                               directConnection(VIA,B,L2), L is L1+L2,
                               \+(oneStopConnection(A,B,LL), LL < L).

pretty(X,Y) :- printConnection(X,Y).
printConnection(X,Y) :- directConnection(X,Y,S),
                        write(X), write(" -> "), write(Y), 
                        write(": "), write(S).

dump(X,Y) :- pretty(X,Y), write("\n"), false.

/* A. Predikat connection(A, B) -> prüft, ob zwei Städte über beliebig viele Stopps miteinander verbunden sind. */
connection(A,B) :- directConnection(A,B,_).
connection(A,B) :- directConnection(A,C,_), connection(C,B).

/* B. Print die Anzahl der Städte auf der Route  */
countRec(A,B,Count) :- directConnection(A,B,_), C is Count +2,
                       write("Weg mit "), write(C), write(" Orten gefunden.").
countRec(A,B,Count) :- directConnection(A,C,_) Count1 is Count + 1,
                       countRec(C,B,Count1).

count(A,B) :- countRec(A,B,0).