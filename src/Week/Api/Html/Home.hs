{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ExtendedDefaultRules #-}


module Week.Api.Html.Home
    ( home
    , WeekInfo(..)
    ) where

import qualified Control.Monad.IO.Class as IO
import qualified Data.Text as T
import qualified Lucid
import qualified Data.Time.Clock as Clock
import Servant
import Lucid
import qualified Week.Week as Week
import qualified Data.ByteString.Lazy.Char8 as BSL8
import qualified Data.Aeson as Aeson
import Data.Aeson ((.=))


home :: Handler WeekInfo
home = do
    time <- IO.liftIO Clock.getCurrentTime
    return $ WeekInfo time


newtype WeekInfo = WeekInfo Clock.UTCTime
    deriving (Show)


instance ToHtml WeekInfo where
    toHtml (WeekInfo time) =
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

    toHtmlRaw =
        toHtml


instance Aeson.ToJSON WeekInfo where
    toJSON (WeekInfo time) =
        Aeson.object
            [ "week" .= Week.getWeek (Clock.utctDay time)
            ]


instance MimeRender PlainText WeekInfo where
    mimeRender _ (WeekInfo time) =
        BSL8.pack $ show $ Week.getWeek (Clock.utctDay time)