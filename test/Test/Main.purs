module Test.Main where

import Prelude
import Control.Monad.Aff.Console (CONSOLE)
import Control.Monad.Eff (Eff)
import Node.FS (FS)
import Node.Process (PROCESS)
import Test.ClickerHeroes.Number (numberSpec)
import Test.ClickerHeroes.Save (saveSpec)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (run)

main :: forall eff.
        Eff (fs :: FS, process :: PROCESS, console :: CONSOLE | eff) Unit
main = run [consoleReporter] do
  saveSpec
  numberSpec
