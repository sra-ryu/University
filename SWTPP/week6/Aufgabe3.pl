/* FAKTEN */
:- ensure_loaded('Aufgabe2.pl').

/* Regeln */
% A. Füge eine Regel hinzu, die zwei-Wege-Bewegung ermöglichen. jetzt: connection(muenchen, frankfurt, _). -> true.
directConnection(X,Y,S) :- connection(X,Y,S) ; connection(Y,X,S).

% B. Find die direkte Verbindungen, die die Distanz nicht länger als Max ist.
dayTrip(X,Y,Max,S) :- directConnection(X,Y,S), S =< Max.

% C. Find die Verbindungen mit einem Umsteigeort.
% A: Abfahrtsort, VIA: Umsteigeort, B: Ankunftsort, L: gesamte Distanz
oneStopConnection(A,B,L) :- directConnection(A,VIA,L1),
                            directConnection(VIA,B,L2), L is L1+L2.

% D. Find oneStopConnection, das kürzte Distanz hat.
shortestOneStop(A,B, VIA,L) :- directConnection(A,VIA,L1),
                               directConnection(VIA,B,L2), L is L1+L2,
                               \+(oneStopConnection(A,B,LL), LL < L).

% E. Print Fakten aus Konsole
pretty(X,Y) :- printConnection(X,Y).
printConnection(X,Y) :- directConnection(X,Y,S),
                        write(X), write(" -> "), write(Y), 
                        write(": "), write(S).

% F. Print alle mögliche binding.
dump(X,Y) :- pretty(X,Y), write("\n"), false.