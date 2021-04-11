module Main where

import           Data.Char                      ( isSpace )
import           Data.Foldable                  ( for_ )
import           System.Process

defaultSink :: IO String
defaultSink = trim <$> readCreateProcess cmd ""
 where
  cmd  = shell "pactl info | grep 'Default Sink' | cut -d : -f 2"
  trim = filter $ not . isSpace -- tis is a bit naïve

sinks :: IO [String]
sinks = lines <$> readCreateProcess cmd ""
  where cmd = shell "pactl list sinks short | cut -f 2"

sinkInputs :: IO [String]
sinkInputs = lines <$> readCreateProcess cmd ""
  where cmd = shell "pactl list sink-inputs short | cut -f 1"

setSink :: String -> IO ()
setSink sink =
  callProcess "pactl" ["set-default-sink", sink] >> moveSinkInputs sink

moveSinkInputs :: String -> IO ()
moveSinkInputs sink = do
  inputs <- sinkInputs
  for_ inputs $ \i -> callProcess "pactl" ["move-sink-input", i, sink]



next :: Eq a => a -> [a] -> Maybe a
next _ []        = Nothing
next e l@(x : _) = Just $ case dropWhile (/= e) l of
  (_ : y : _) -> y
  _           -> x

main :: IO ()
main = do
  ds <- defaultSink
  s  <- cycle <$> sinks
  putStrLn ds
  case next ds s of
    (Just ns) -> setSink ns
    Nothing   -> putStrLn "no next sink found"
