module Lib
    ( fee
    , charge
    , putChips
    , takeChips
    , win
    ) where

-- festsetzen Transaktionsgebühr
fee :: Int
fee = 1

-- zieht die Gebühr von einem gegebenen Wert ab
charge :: Int -> Int
charge val = if val == 0 then 0 else val - fee

-- zwei Chip zusammenrechnen, Transaktionsgebühr fällig
putChips :: Int -> Int -> Int
putChips owned added = charge (owned + added)

-- zieht einen Chipstapel taken von owned ab
takeChips :: Int -> Int -> Int
takeChips owned taken = if owned < taken then 0 else owned - taken

-- implementieren ein spezieller Gewinn-Modus
win :: Int -> Int -> Int
win _ 0 = 0
win a b = 
    if a < b then
        win b a
    else
        if a `mod` 10 == 0 then b + win (a - 1) (b - 1)
        else b + win (a - 1) b
