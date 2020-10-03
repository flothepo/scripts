module Main where

import           System.Process
import           Data.List

getDevices :: IO [String]
getDevices = do
  output <- readProcess "/usr/bin/adb" ["devices", "-l"] ""
  pure $ map getDeviceName $ filter (not . null) $ tail $ lines output

getDeviceName :: String -> String
getDeviceName = drop prefixLength . head . filter (isPrefixOf prefix) . words
 where
  prefix       = "model"
  prefixLength = (length prefix) + 1

androidIcon :: String
androidIcon = "\xf17b "

main :: IO ()
main = do
  devices <- getDevices
  if null devices
    then putChar '\n'
    else putStrLn (androidIcon ++ (concat $ intersperse "  " devices))
