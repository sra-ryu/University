module Aufgabe3 where
import Helper

-- schreibt nvcls Funktion, die aus einem String alle Vokale entfernt.
nvcls :: String -> String
nvcls = filter  (not . isVowel)

-- wendet sqr und pot auf im Intervall [0, 10]
-- map sqr [0 .. 10]
-- map pot [0 .. 10]

-- schreibt Funktion listValues, die alle Blattwerte ValR sammelt
values :: CommandR -> [Int]
values (ValR v) = [v]
values (PutR owned added) = values owned ++ values added
values (TakeR owned taken) = values owned ++ values taken
values (WinR a b) = values a ++ values b

listValues :: [CommandR] -> [Int]
listValues = (foldr (++) []) . (map values)