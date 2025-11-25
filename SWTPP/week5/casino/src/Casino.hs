module Casino 
  (
    Command(..)
    , toCommand
    , eval
    , toString
    , putChips
    , takeChips
    , win
    -- if I want to hide something, don't write here(ex: here fee function)
  ) where

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

data Command = Put Command Command 
             | Take Command Command
             | Win Command Command 
             | Val Int
             | Sig Command

eval :: Command -> Int
eval (Put c1 c2)  = putChips(eval c1) (eval c2)
eval (Take c1 c2) = takeChips(eval c1) (eval c2)
eval (Win c1 c2)  = win(eval c1) (eval c2)
eval (Val v)      = v
eval (Sig v)      = signum (eval v)

toString :: Command -> String
toString (Val n) = show n
toString (Put x y) = "(" ++ toString x ++ " + " ++ toString y ++ ")"
toString (Take x y) = "(" ++ toString x ++ " - " ++ toString y ++ ")"
toString (Win x y) = "(" ++ toString x ++ " * " ++ toString y ++ ")"
toString (Sig x) = "signum (" ++ toString x ++ ")"

instance Show Command where
    show = toString

-- write a function that only accepts positive numbers
toCommand :: Int -> Command
toCommand n
  | n > 0 = Val n
  | otherwise = error "Command can only accept positive number."

instance Num Command where
    c1 + c2 = Put c1 c2
    c1 - c2 = Take c1 c2
    c1 * c2 = Win c1 c2

    abs c1 = c1

    signum :: Command -> Command
    signum c1 = Sig c1

    fromInteger x
        | x >= 0 = Val (fromInteger x)

instance Eq Command where
    c1 == c2 = eval c1 == eval c2

instance Ord Command where
    c1 <= c2 = eval c1 <= eval c2