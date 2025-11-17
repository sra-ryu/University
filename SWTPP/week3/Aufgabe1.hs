module Aufgabe1 where
import Helper

-- schriebt rep Funktion
-- z.B.: rep 2 [1,2] -> [1,2,1,2]
rep :: Int -> [a] -> [a]
rep 0 _ = []
rep 1 xs = xs
rep n xs = xs ++ rep (n - 1) xs

-- schreibt mirror Funktion
-- z.B.: [1.2] -> [1,2,2,1]
mirror :: [a] -> [a]
mirror [] = []
mirror xs = xs ++ mirror' xs
    where
        mirror' [] = []
        mirror' (x:xs) = mirror' xs ++ [x]

-- Musterlösung
-- mirror :: [a] -> [a]
-- mirror [] = []
-- mirror (x:xs) = [x] ++ mirror xs ++ [x]

-- schreibt drop2 Funktion
-- z.B.: [1,2,3,4] -> [3,4]
drop2 :: [a] -> [a]
drop2 [] = []
drop2 (_:[]) = []
drop2(_:_:xs) = xs

-- schreibt kick Funktion
-- Input: List vom CommandR
-- Output: alle Elemente, die kein Chip(Chip = 0, also evalR = 0) haben.
kick :: [CommandR] -> [CommandR]
kick [] = []
kick (x:xs) = if evalR x > 0 then x:kick xs else kick xs

-- schreibt payback Funktion
-- wenn man im lezten Schritt Chips eingesetzt haben -> nur 'owned' lassen
payback :: [CommandR] -> [CommandR]
payback [] = []
payback ((TakeR owned (ValR _)):xs) = owned:payback xs
payback (x:xs) = x:payback xs