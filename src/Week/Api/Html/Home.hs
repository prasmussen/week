{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ExtendedDefaultRules #-}


module Week.Api.Html.Home
    ( home
    ) where

import qualified Control.Monad.IO.Class as IO
import qualified Data.Text as T
import qualified Lucid
import qualified Data.Time.Clock as Clock
import Servant
import Lucid
import qualified Week.Week as Week


home :: Handler (Lucid.Html ())
home = do
    time <- IO.liftIO Clock.getCurrentTime
    return $ homePage time


homePage :: Clock.UTCTime -> Html ()
homePage time =
    let
        week =
            Week.getWeek (Clock.utctDay time)
    in
    doctypehtml_ $ do
        head_ $ do
            meta_ [ charset_ "UTF-8" ]
            meta_ [ name_ "viewport", content_ "width=device-width, initial-scale=1, shrink-to-fit=no" ]
            title_ "Current week"
        body_ $ do
            div_ [] (toHtml $ show week)
