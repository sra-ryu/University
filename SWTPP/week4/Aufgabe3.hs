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
eval (Sig v)      = Prelude.signum (eval v)

toString :: Command -> String
toString (Val n) = show n
toString (Put x y) = "(" ++ toString x ++ " + " ++ toString y ++ ")"
toString (Take x y) = "(" ++ toString x ++ " - " ++ toString y ++ ")"
toString (Win x y) = "(" ++ toString x ++ " * " ++ toString y ++ ")"
toString (Sig x) = "signum (" ++ toString x ++ ")"


-- instance of Show mit Command Tpy
instance Show Command where
    show = toString

-- implement +, -, * mit Command Typ
c1 + c2 = Put c1 c2
c1 - c2 = Take c1 c2
c1 * c2 = Win c1 c2

-- implement abs
abs c1 = c1
-- Command befasst sich nur mit positive Zahlen

-- implement signum
signum c1 = Sig c1

-- implement fromInteger
fromInteger x
        | x >= 0 = Val (Prelude.fromInteger x)