-- 1a) reguläres Modul
-- module Command where

-- 1b) Modul mit expliziten Exporten
module Command (
        Command (Put, Take, Win, Sig),
        toCommand,
        eval,
        values,
        listValues,
        badluck
    ) where


-- | Standardgebühr
fee :: Int
fee = 1

-- | Zieht die Standardgebühr von einem gegebenen Chipstapel ab.
--
-- Ergibt keine negative Werte, stattdessen 0.
-- 
-- Beispiele:
--
-- >>> charge 10
-- 9
--
-- >>> charge 0
-- 0
--
charge :: Int -> Int
charge a = if a > fee then a - fee else 0

-- | Addiert zwei Werte zusammen und zieht die Standardgebühr ab.
--
-- Ergibt keine negative Werte, stattdessen 0.
--
-- Beispiele:
--
-- >>> putChips 4 2
-- 5
--
-- >>> putChips 0 0
-- 0
--
putChips :: Int -> Int -> Int
putChips owned bought = charge (owned + bought)

-- | @takeChips x y@ nimmt @y@ Chips von der Chipstabel @x@.
--
-- Ergibt keine negative Werte, stattdessen 0.
-- 
-- Beispiele:
--
-- >>> takeChips 4 2
-- 2
--
-- >>> takeChips 2 4
-- 0
--
takeChips :: Int -> Int -> Int
takeChips owned taken = let result = owned - taken in 
            if result >= 0 then result else 0

-- | Berechnet einen Gewinn, bei dem zwei Werten multipliziert werden
-- und eine gestaffelte Gebühr abgezogen wird.
--
-- Beispiele:
--
-- >>> win 20 0
-- 0
--
-- >>> win 20 5
-- 72
--
-- >>> win 5 20
-- 72
--
-- >>> win 20 2
-- 12
--
win :: Int -> Int -> Int
win a b = if a > b then recurse a b 0 else recurse b a 0
    where
    recurse _ 0 p = p
    recurse 0 _ p = p
    recurse a b p = 
        let b' = if a `mod` 10 == 0 then b-1 else b 
        in recurse (a - 1) b' $! (b + p)

data Command
    = Put Command Command   
    -- ^ Addiert zwei Werte zusammen und zieht die Standardgebühr ab
    | Take Command Command  
    -- ^ Subtrahiert das zweite Wert vom Ersten
    | Win Command Command 
    -- ^ Berechnet einen Gewinn, bei dem zwei Werten mutpliziert werden
    -- und eine gestaffelte Gebühr abgezogen wird
    | Val Int
    -- ^ Konstanter Wert
    | Sig Command
    -- ^ Ergibt 1 für positive Werte, sonst 0

-- | Konstanter Wert (für negative Zahlen nicht definiert!)
toCommand :: Int -> Command
toCommand = fromIntegral

-- | Evaluiert den gegebenen Command
eval :: Command -> Int
eval (Put c1 c2)  = putChips (eval c1) (eval c2)
eval (Take c1 c2) = takeChips (eval c1) (eval c2)
eval (Win c1 c2)  = win (eval c1) (eval c2)
eval (Val v)      = v
eval (Sig v)      = signum (eval v)
              

-- | Konvertiert einen Command in einen mathematischen Ausdruck
toString :: Command -> String
toString command = case command of
    Val x    -> show x
    Sig x    -> "signum " ++ toString x
    Put x y  -> "(" ++ toString x ++ " + " ++ toString y ++ ")"
    Take x y -> "(" ++ toString x ++ " - " ++ toString y ++ ")"
    Win x y  -> "(" ++ toString x ++ " * " ++ toString y ++ ")"

-- | Macht die letzte Operation rückgängig, falls die einen 'Take' mit einem 'Val'
-- als zweiten Operand war. Ansonsten bleibt der Wert unverändert.
--
-- Beispiel:
-- >>> payback [Val 0, Val 1, Take (Val 5) (Val 10), Win (Val 4) (Val 2)]
-- [0,1,5,4 * 2]
--
payback :: [Command] -> [Command]
payback [] = []
payback ((Take op1 (Val _)):xs) = op1: payback xs
payback (x:xs) = x:payback xs

-- | Listet alle Blattwerte eines Commands.
values (Val v) = [v]
values (Put a b) = (values a) ++ (values b)
values (Take a b) = (values a) ++ (values b)
values (Win a b) = (values a) ++ (values b)

-- | Listet alle Blattwerte einer Liste von Commands
listValues = (foldr (++) []) . (map values)


-- | Zieht alle Einsätze der gegebenen Liste von der gegebenen Stapel ab.
--
-- >>> badluck (Val 10) [Val 4, Val 2]
-- 10 - 4 - 2
--
badluck :: Command -> [Command] -> Command
badluck start bets = foldl Take start bets

instance Show Command where
    show = toString

-- | Commands werden nur nach Wert verglichen, die Struktur wird ignoriert
instance Eq Command where
    c1 == c2 = eval c1 == eval c2

-- | Commands werden nur nach Wert verglichen, die Struktur wird ignoriert
instance Ord Command where
    c1 <= c2 = eval c1 <= eval c2
    
-- | 'fromInteger' ist für negative Zahlen nicht definiert.
instance Num Command where
    c1 + c2 = Put c1 c2
    c1 - c2 = Take c1 c2
    c1 * c2 = Win c1 c2
    abs c1 = c1
    signum c1 = c1
    fromInteger v
        | v >= 0 = Val (fromInteger v)
