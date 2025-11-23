import Test.Hspec
import Command

main :: IO ()
main = hspec $ do
    describe "Command.toCommand" $ do
        it "creates a Command from Integer" $ do
            eval (toCommand 5) `shouldBe` (5 :: Int)