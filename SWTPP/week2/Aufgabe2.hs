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

-- a) implementieren Aufzählungstyp CommandS, CommandS hat Put, Take und Win
-- Verwendet deriving Show -> deriving Show konveriert Datentyp in String
data CommandS = Put | Take | Win deriving Show

evalS :: CommandS -> Int -> Int -> Int
evalS Put = putChips
evalS Take = takeChips
evalS Win = win

-- test deriving Show
myCommand :: CommandS
myCommand = Put

-- Musterlösung - use patternmatching
-- evalS :: CommandS -> Int -> Int -> Int
-- evalS c a b = case c of
--     Put -> putChips a b
--     Take -> takeChips a b
--     Win -> win a b


-- b) erweitern CommandS -> CommandP(Summen- und Produkttyp)
data CommandP = PutP Int Int | TakeP Int Int | WinP Int Int deriving Show

evalP :: CommandP -> Int
evalP (PutP owned added) = putChips owned added
evalP (TakeP owned taken) = takeChips owned taken
evalP (WinP a b) = win a b


-- c) implementieren rekursive Datentyp CommandR
data CommandR = PutR CommandR CommandR 
              | TakeR CommandR CommandR 
              | WinR CommandR CommandR 
              | ValR Int deriving Show

evalR :: CommandR -> Int
evalR (ValR v) = v
evalR (PutR owned added) = putChips (evalR owned) (evalR added)
evalR (TakeR owned taken) = takeChips (evalR owned) (evalR taken)
evalR (WinR a b) = win (evalR a) (evalR b)