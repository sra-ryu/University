-- Die ersten 20 Vielfache von 7
a = [i * 7 | i <- [2 .. 21]]

-- Jede Zahl bis 100, die nicht durch 5 teilbar ist
b = [i | i <- [2 .. 100], i `mod` 5 /= 0]

-- Primzahlen in [1 .. 100]
c = [i | i <- [2 .. 100], all (\j -> i `mod` j /= 0) [2..(i `div` 2)]]