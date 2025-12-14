/* FAKTEN */
edge(hamburg, berlin, 300).
edge(berlin, muenchen, 700).
edge(hamburg, koeln, 500).
edge(koeln, frankfurt, 300).
edge(frankfurt, muenchen, 300).
edge(frankfurt, stuttgart, 250).
edge(stuttgart, muenchen, 200).

/* Regeln */
directedgeion(X,Y,S) :- edge(X,Y,S) ; edge(Y,X,S).

dayTrip(X,Y,Max,S) :- directedgeion(X,Y,S), S =< Max.

oneStopedgeion(A,B,L) :- directedgeion(A,VIA,L1),
                            directedgeion(VIA,B,L2), L is L1+L2.

shortestOneStop(A,B, VIA,L) :- directedgeion(A,VIA,L1),
                               directedgeion(VIA,B,L2), L is L1+L2,
                               \+(oneStopedgeion(A,B,LL), LL < L).

pretty(X,Y) :- printedgeion(X,Y).
printedgeion(X,Y) :- directedgeion(X,Y,S),
                        write(X), write(" -> "), write(Y), 
                        write(": "), write(S).

dump(X,Y) :- pretty(X,Y), write("\n"), false.

/* A. Predikat edgeion(A, B) -> prüft, ob zwei Städte über beliebig viele Stopps miteinander verbunden sind. */
edgeion(A,B) :- directedgeion(A,B,_).
edgeion(A,B) :- directedgeion(A,C,_), edgeion(C,B).

/* B. Print die Anzahl der Städte auf der Route.  */
countRec(A,B,Count) :- directedgeion(A,B,_), C is Count +2,
                       write("Weg mit "), write(C), write(" Orten gefunden.").
countRec(A,B,Count) :- directedgeion(A,C,_) Count1 is Count + 1,
                       countRec(C,B,Count1).

count(A,B) :- countRec(A,B,0).

/* C. Berechnen die Distanz zwischen A und B. */
distance(A,B,Dist) :- directedgeion(A,B,Dist).
distance(A,B,Dist) :- directedgeion(A,C,S), distance(C,B,Dist1),
                      Dist is Dist1 + S.

/* D. Print alle Städte zwischen X und Y. */
route(X,Y) :- directedgeion(X,Y,_),
              write(Y), write(" "), write(X).
route(X,Z) :- directedgeion(X,Y,_), route(Y,Z), 
              write(" "), write(X).

/* E. prüfen, ob X eine Primzahl ist. */
primeHelper(_,2).
primeHelper(X,H) :- H2 is H-1, \+ (0 is X mod H2),
                    primeHelper(X,H2).

prime(X) :- X > 1, primeHelper(X,X).