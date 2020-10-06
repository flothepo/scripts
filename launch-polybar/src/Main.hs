module Main where

import           Control.Monad                  ( void )
import           Data.Foldable                  ( for_ )
import           System.Environment             ( setEnv )
import           System.Process

data Monitor = Monitor {
    monitorId        :: String
  , isPrimary :: Bool
  } deriving (Show)

mainBar :: String
mainBar = "main"

subBar :: String
subBar = "sub"

polybar :: Monitor -> IO ()
polybar monitor = do
  setEnv "MONITOR" $ monitorId monitor
  void $ spawnProcess "polybar" [bar, "--reload"]
  where bar = if isPrimary monitor then mainBar else subBar

killPolybar :: IO ()
killPolybar = do
  p <- spawnCommand "killall -q polybar"
  void $ waitForProcess p -- ignore non-zero exit code

readMonitor :: String -> Monitor
readMonitor str = Monitor { monitorId = init mId
                          , isPrimary = monitorIsPrimary
                          }
 where
  props@(mId : _)  = words str
  monitorIsPrimary = (length props) == 3

getMonitors :: IO [Monitor]
getMonitors = (map readMonitor) . lines <$> readProcess "polybar" ["-m"] ""

main :: IO ()
main = do
  killPolybar
  monitors <- getMonitors
  for_ monitors polybar
