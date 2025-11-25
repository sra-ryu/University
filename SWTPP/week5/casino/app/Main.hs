module Main (main) where
-- import all functions in Casino module
import Casino

main :: IO ()
main = do
    let val1 = Val 10
    let val2 = Val 5

    let putCmd = Put val1 val2
    putStrLn $ "Put: " ++ toString putCmd ++ " = " ++ show (eval putCmd)

    -- it's not possible to access fee
    -- print fee

    -- man can't use negative number
    -- let val3 = val (-5)