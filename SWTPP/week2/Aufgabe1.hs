-- a) implementieren win mit Pattern Matching
win :: Int -> Int -> Int
win _ 0 = 0
win a b
  | a < b = win b a
  | a `mod` 10 == 0 = b + win (a - 1) (b - 1)
  | otherwise = b + win (a - 1) b

-- Musterlösung a)
-- win :: Int -> Int -> Int
-- win a b = if a > b then recurse a b else recurse b abs
--     where
--     recurse :: Int -> Int -> Int
--     recurse a 0 = 0
--     recurse 0 b = 0
--     recurse a b =
--           let b' = if a `mod` 10 == 0 then b - 1 else base
--           in b + recurse (a - 1) b'


-- b) optimieren win-Funktion mit weniger Speicher
-- Lazy Evaluation: Haskell postpones calculations until it nees -> it uses lots of memory
-- Use tail recursion + strict evaluation
winTR :: Int -> Int -> Int -> Int
winTR _ 0 acc = acc
winTR a b acc
  | a < b = winTR b a acc
  | a `mod` 10 == 0 = winTR (a - 1) (b - 1) $! (b + acc)
  | otherwise = winTR (a - 1) b $! (b + acc)

win2 :: Int -> Int -> Int
win2 a b = winTR a b 0

-- Musterlösung
-- win :: Int -> Int -> Int
-- win a b = if a > b then recurse a b else recurse b abs
--     where
--     recurse :: Int -> Int -> Int -> Int
--     recurse a 0 acc = acc
--     recurse 0 b acc = acc
--     recurse a b =
--           let b' = if a `mod` 10 == 0 then b - 1 else b
--           in recurse (a - 1) b' $! (b + acc)


-- c) implementieren fib-Funktion und optimieren die Funktion
-- Use tail recursion + strict evaluation
fibTR :: Int -> Int -> Int -> Int
fibTR 0 prev curr = prev
fibTR n prev curr = fibTR (n - 1) curr $! (prev + curr)

fib :: Int -> Int
fib x = fibTR x 0 1