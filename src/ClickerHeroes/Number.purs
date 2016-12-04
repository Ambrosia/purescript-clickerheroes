module ClickerHeroes.Number (parse) where

import Prelude
import Data.Array (head)
import Data.Decimal (Decimal, fromString)
import Data.Either (fromRight)
import Data.Maybe (Maybe, fromJust)
import Data.String (Pattern(..), indexOf, singleton, toChar)
import Data.String.Regex (Regex, match, regex, replace', test)
import Data.String.Regex.Flags (noFlags)
import Data.String.Utils (filter)
import Partial.Unsafe (unsafePartial)

-- | Parses Clicker Heroe's Legendary Numbers
-- | (see legend on www.clickerheroes.com) into Decimals
parse :: String -> Maybe Decimal
parse n | test legNumSymbolRegex n =
  fromString $ legNumToScientific $ stripCommas n
  where
  stripCommas = filter $ (/=) ','
parse n | otherwise = fromString n

legNumToScientific :: String -> String
legNumToScientific = replace' legNumSymbolRegex toScientific
  where
  getExp :: String -> Int
  getExp s = unsafePartial $ fromJust $ legNumCharToExp $ fromJust $ toChar s

  toScientific :: String -> Array String -> String
  toScientific s _ = "e" <> (show $ getExp s)

legNumSymbols :: String
legNumSymbols = "KMBTqQsSONdUD!@#$%^&*"

getLegNumSymbol :: String -> Maybe Char
getLegNumSymbol n = do
  matches <- match legNumSymbolRegex n
  firstMatch <- head matches
  string <- firstMatch
  char <- toChar string
  pure char

legNumSymbolRegex :: Regex
legNumSymbolRegex = unsafePartial $ fromRight $ regex pattern noFlags
  where
  pattern = "[" <> legNumSymbols <> "]"

legNumCharToExp :: Char -> Maybe Int
legNumCharToExp x = (1 + _) >>> (3 * _) <$> indexOf (pattern x) legNumSymbols
  where
  pattern :: Char -> Pattern
  pattern = Pattern <$> singleton
