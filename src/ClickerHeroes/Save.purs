module ClickerHeroes.Save (DecodedSave(..), decode) where

import Data.String.Base64 as Base64
import Control.Monad.Eff.Exception (Error, error)
import Data.Array (catMaybes, mapWithIndex)
import Data.Either (Either(..))
import Data.Eq (class Eq)
import Data.Maybe (Maybe(..))
import Data.Show (class Show)
import Data.String (Pattern(..), split, fromCharArray, toCharArray)
import Prelude (mod, show, ($), (<$>), (==), (>>>))

newtype DecodedSave = DecodedSave String

instance showDecodedSave :: Show DecodedSave where
  show (DecodedSave s) = show s

derive instance eqDecodedSave :: Eq DecodedSave

antiCheatCode :: Pattern
antiCheatCode = Pattern "Fe12NAfA3R6z4k0z"

-- | Decodes a Clicker Heroes save. The result is a JSON string.
decode :: String -> Either Error DecodedSave
decode save = case split antiCheatCode save of
  [data'] -> DecodedSave <$> Base64.decode data'
  [data', _] -> DecodedSave <$> (Base64.decode $ removeOddChars data')
  _ -> Left (error "Invalid save data")

removeOddChars :: String -> String
removeOddChars = toCharArray >>> filterOdds >>> fromCharArray
  where
  filterOdds :: Array Char -> Array Char
  filterOdds = (mapWithIndex maybeEven) >>> catMaybes

  maybeEven :: Int -> Char -> Maybe Char
  maybeEven i c | i `mod` 2 == 0 = Just c
  maybeEven _ _ = Nothing
