-- Hilfsfunktionen
fee :: Int
fee = 1

charge :: Int -> Int
charge val = if val == 0 then 0 else val - fee

putChips :: Int -> Int -> Int
putChips owned added = charge (owned + added)

takeChips :: Int -> Int -> Int
takeChips owned taken = if owned < taken then 0 else owned - taken

winTR :: Int -> Int -> Int -> Int
winTR _ 0 acc = acc
winTR a b acc
  | a < b = winTR b a acc
  | a `mod` 10 == 0 = winTR (a - 1) (b - 1) $! (b + acc)
  | otherwise = winTR (a - 1) b $! (b + acc)

win :: Int -> Int -> Int
win a b = winTR a b 0

data CommandR = PutR CommandR CommandR 
              | TakeR CommandR CommandR 
              | WinR CommandR CommandR 
              | ValR Int deriving Show

evalR :: CommandR -> Int
evalR (ValR v) = v
evalR (PutR owned added) = putChips (evalR owned) (evalR added)
evalR (TakeR owned taken) = takeChips (evalR owned) (evalR taken)
evalR (WinR a b) = win (evalR a) (evalR b)


-- a) Gebt alle ASCII-Zeichen aus
ascii :: [Char]
ascii = ['\0' .. '\127']


-- b) schreiben eine Funktion isVowel
isVowel :: Char -> Bool
isVowel c = case c of
        'a' -> True
        'e' -> True
        'i' -> True
        'o' -> True
        'u' -> True
        _   -> False

-- use pattern matching
-- isVowel :: Char -> Bool
-- isVowel ('a') = True
-- isVowel ('e') = True
-- isVowel ('i') = True
-- isVowel ('o') = True
-- isVowel ('u') = True
-- isVowel _ = False


-- c) erweitern isVowel -> hasVowel
hasVowel :: String -> Bool
hasVowel [] = False
hasVowel (x:xs) = isVowel x || hasVowel xs


-- d) Schreiben eine Funktion toString mit der ein CommandR
toString :: CommandR -> String
toString c = case c of
        ValR x -> show x
        PutR x y -> "(" ++ toString x ++ " + " ++ toString y ++ ")"
        TakeR x y -> "(" ++ toString x ++ " - " ++ toString y ++ ")"
        WinR x y -> "(" ++ toString x ++ " * " ++ toString y ++ ")"