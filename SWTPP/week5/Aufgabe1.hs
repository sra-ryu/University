-- print "Hello {nama}" auf der Konsole
-- name ist ein Eingabe
greet :: IO()
greet = do
    putStrLn "Enter your name: "
    name <- getLine
    putStrLn ("Hello " ++ name)