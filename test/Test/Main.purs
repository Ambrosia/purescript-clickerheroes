module Test.Main where

import Prelude
import Control.Monad.Aff.Console (CONSOLE)
import Control.Monad.Eff (Eff)
import Node.Process (PROCESS)
import Test.ClickerHeroes.Number (numberSpec)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (run)

main :: forall eff. Eff (process :: PROCESS, console :: CONSOLE | eff) Unit
main = run [consoleReporter] do
  numberSpec
