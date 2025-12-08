module Main (main) where

import Lib

main :: IO ()
main = do
    print(fee)
    print(charge 0)
    print(charge 2)
    print(putChips 10 2)
    print(takeChips 10 11)
    print(takeChips 10 8)
    print(win 20 5)
