import Test.Hspec
import Casino(Command(..), toCommand)

main :: IO ()
main = hspec $ do
    describe "test put chips" $ do
        it "add two numbers and subtract the fee." $ do
            Put (Val 10) (Val 5) `shouldBe` 14
        
        it "handles zero" $ do
            Put (Val 0) (Val 5) `shouldBe` 4
    
    describe "test take chips" $ do
        it "substact chips from owned" $ do
            Take (Val 10) (Val 3) `shouldBe` 7
        
        it "returns 0 when taking more than owned" $ do
            Take (Val 0) (Val 4) `shouldBe` 0
        