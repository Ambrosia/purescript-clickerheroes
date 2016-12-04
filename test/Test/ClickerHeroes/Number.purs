module Test.ClickerHeroes.Number where

import Prelude
import ClickerHeroes.Number (parse)
import Data.Decimal (fromString)
import Data.Maybe (Maybe(..))
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)

numberSpec =
  describe "ClickerHeroes.Number" do
    it "parses legendary numbers correctly" do
      parse "1K" `shouldEqual` fromString "1000"
      parse "33,100T" `shouldEqual` fromString "33100000000000000"

    it "still parses scientific numbers when given" do
      parse "4e4" `shouldEqual` fromString "40000"

    it "returns Nothing when an invalid legendary number is given" do
      parse "1k" `shouldEqual` Nothing
