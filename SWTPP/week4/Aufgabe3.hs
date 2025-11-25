module Aufgabe3 where
import Helper

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


-- instance of Show mit Command
instance Show Command where
    show = toString

-- instance of Num mit Command
-- implement +, -, *
instance Num Command where
    c1 + c2 = Put c1 c2
    c1 - c2 = Take c1 c2
    c1 * c2 = Win c1 c2

    -- implement abs
    abs c1 = c1
    -- Command befasst sich nur mit positive Zahlen

    -- implement signum
    -- if x = 0 -> 0, else -> 1(hier x >= 1)
    signum :: Command -> Command
    signum c1 = Sig c1

    -- implement fromInteger
    fromInteger x
        | x >= 0 = Val (fromInteger x)

-- instance of Eq mit Command
instance Eq Command where
    c1 == c2 = eval c1 == eval c2

-- instance of Ord mit Commnad
-- Eq: vergleichen nur die Wert
-- Ord: miteinamder kompatibel
instance Ord Command where
    c1 <= c2 = eval c1 <= eval c2