import Data.Char (ord, chr)

-- input: n
-- output: n^2
sqr :: Int -> Int
sqr = (^ 2)

-- input: n
-- output: 2^n
pot :: Int -> Int
pot = (2 ^)

-- Leitet aus der elem die isVowel Funktion ab
-- isVowel Funktion
-- isVowel :: Char -> Bool
-- isVowel c = case c of
--         'a' -> True
--         'e' -> True
--         'i' -> True
--         'o' -> True
--         'u' -> True
--         _   -> False

isVowel :: Char -> Bool
isVowel = (`elem` "aeiou")

-- input: uppercase
-- output: lowercase
lower :: Char -> Char
lower c = chr (ord c + 32)