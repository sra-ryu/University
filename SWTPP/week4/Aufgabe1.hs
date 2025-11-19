module Aufgabe1 where
import Helper

-- schreibt badluck Funktion
-- Param.1: Anzahl der Chips zu Beginn, Param.2: Liste der Anzahl von Chips, die bei jeder Wette verloren gehen
badluck :: CommandR -> [CommandR] -> CommandR
badluck start bets = foldl TakeR start bets

-- schreibt any Funktion
-- wenn mindestens ein Element die Predikat erfüllt -> True
any2 :: (a -> Bool) -> [a] -> Bool
any2 pred = foldr (\x acc -> pred x || acc) False

-- implement elem Funktion mithilfe von List Funktionen
elem2 x = any2 (== x)

-- implement hasVowel Funktion
hasVowel = any2 isVowel