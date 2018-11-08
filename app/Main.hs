module Main where

import qualified Week.Week as Lib
import qualified Data.Time.Clock as Clock
import qualified Network.Wai.Handler.Warp as Warp
import qualified Week.Api as Api


main :: IO ()
main = do
    day <- Clock.utctDay <$> Clock.getCurrentTime
    print $ Lib.getWeek day
    Warp.run 9005 Api.app
