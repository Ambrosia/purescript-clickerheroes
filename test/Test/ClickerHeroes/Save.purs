module Test.ClickerHeroes.Save where

import Prelude
import ClickerHeroes.Save (DecodedSave(..), decode)
import Data.Either (fromRight)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readTextFile)
import Partial.Unsafe (unsafePartial)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)

saveSpec =
  describe "ClickerHeroes.Save" do
    it "decodes a save correctly" do
      encodedSave <- readTextFile UTF8 (fixturePath "/encoded.txt")
      decodedSave <- readTextFile UTF8 (fixturePath "/decoded.txt")
      unsafeDecode encodedSave `shouldEqual` (DecodedSave decodedSave)

unsafeDecode :: String -> DecodedSave
unsafeDecode s = unsafePartial $ fromRight $ decode s

fixturePath :: String -> String
fixturePath = (<>) "./test/Test/ClickerHeroes/Save"
