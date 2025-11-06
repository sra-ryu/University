module Week3.Helper where

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