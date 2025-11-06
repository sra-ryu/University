-- schriebt rep Funktion
-- z.B.: rep [1,2] 2 -> [1,2,1,2]
rep :: [a] -> Int -> [a]
rep _ 0 = []
rep xs 1 = xs
rep xs n = xs ++ rep xs (n - 1)

-- schreibt mirror Funktion
-- z.B.: [1.2] -> [1,2,2,1]
mirror :: [a] -> [a]
mirror [] = []
mirror xs = xs ++ mirror' xs
    where
        mirror' [] = []
        mirror' (x:xs) = mirror' xs ++ [x]

-- schreibt drop2 Funktion
-- z.B.: [1,2,3,4] -> [3,4]
