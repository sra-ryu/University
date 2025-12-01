/ *überlegt, ob die folgenden Ausdrücke gültig(oder unifizierbar) sind und mögliche Variablenbelegungen */
X = 1. # X = 1.

x = 1. # falsch.(Variablennamen -> beginne mit Großbuchstaben oder _)

_ = "unterstrich". # true. _ bedeutet, Wert unabhängig ist.("unterstrich" -> nicht verwendbar)

mensch(X) == mensch(ich) # falsch. X != ich, aber wenn X = ich. dann true.

val(X,Y) = val(A,B). # X = A, Y = B.

val(X,Y,_) = val(X,Y). # false. (ungleiche Anzahl)

strcat(A," teil2",C) = strcat(" teil1 ",B," teil3 "). # A = " teil1 ", C = " teil3 ", B = " teil2".

1+1 = 2. # false. Nicht definiert.

2.0 is 1.0+1.0. # is -> arithmetic evaluation, ture.

Erg is 1+1, Erg == 2. # berechnen(1+1) und binding(Erg = 2) -> dann vergleichen. true.(Erg = 2, 2 == 2)

A = a, a == A. # A = a.

a == A, a = A. # zuerst, a != A und a ist kein Variable.

A(1,2,3) = funktion(1,2,3). # A kann nicht als Funktor sein.(A -> Variable)

X = f(X). # Variablen können Funktoren zugewiesen werden.

(X = 1; X = 2; X = 3), Y = X. # ; -> or Operator, erst Match -> binding(hier 1,2,3), also X = Y, Y = 1; X = Y, Y = 2; X = Y, Y = 3.

(X = 1; X = 2; X = 3), !, Y = X. # ! -> cut Operator - back tracking unmöglich, also X = Y, Y = 1.(fertig)

(X = 1; Y = 2; X = 3), \+(X = 2). # \+ -> not Operator -> not (X = 2), also X = 1; X = 3.

\+(X = 1; Y = 2; X = 3) # \+P bedeutet -> P kann nicht bewiesen werden.(if nicht beweiesen -> true. else -> false.) hier: X kann mit 1,2,3 binden -> false.