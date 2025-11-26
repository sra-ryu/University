import Test.Hspec
import Casino(Command(..), toCommand)

main :: IO ()
main = hspec $ do
    describe "test put chips" $ do
        it "add two numbers and subtract the fee." $ do
            Put (Val 10) (Val 5) `shouldBe` Val 14