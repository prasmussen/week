module Week.WeekInfo
    ( WeekInfo(..)
    , getWeek
    ) where


import qualified Data.Time.Clock as Clock
import qualified Data.Time.Calendar as Calendar
import qualified Data.Time.Calendar.WeekDate as WeekDate
import qualified Data.ByteString.Lazy.Char8 as BSL8
import qualified Data.Aeson as Aeson
import qualified Servant
import Lucid
import Data.Aeson ((.=))



newtype WeekInfo = WeekInfo Clock.UTCTime
    deriving (Show)


instance ToHtml WeekInfo where
    toHtml weekInfo =
        let
            week =
                getWeek weekInfo
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
    toJSON weekInfo =
        Aeson.object
            [ "week" .= getWeek weekInfo
            ]


instance Servant.MimeRender Servant.PlainText WeekInfo where
    mimeRender _ weekInfo =
        BSL8.pack $ show $ getWeek weekInfo


getWeek :: WeekInfo -> Int
getWeek (WeekInfo time) =
    weekOfYear
    where
        day =
            Clock.utctDay time

        (_, weekOfYear, _) =
            WeekDate.toWeekDate day
