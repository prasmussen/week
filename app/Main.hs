module Main where

import qualified Network.Wai.Handler.Warp as Warp
import qualified Week.Api as Api


main :: IO ()
main =
    Warp.run 9005 Api.app
