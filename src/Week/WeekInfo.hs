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
import Data.Monoid ((<>))
import Lucid
import Data.Aeson ((.=))



newtype WeekInfo = WeekInfo Clock.UTCTime
    deriving (Show)


instance ToHtml WeekInfo where
    toHtml weekInfo =
        let
            week =
                toHtml $ show $ getWeek weekInfo
        in
        doctypehtml_ $ do
            head_ $ do
                meta_ [ charset_ "UTF-8" ]
                meta_ [ name_ "viewport", content_ "width=device-width, initial-scale=1, shrink-to-fit=no" ]
                title_ ("Week: " <> week)
                link_ [ rel_ "stylesheet", type_ "text/css", href_ "/static/styles.css" ]
            body_ $ do
                div_ [ class_ "week" ] ("Week: " <> week)
                div_ [ class_ "api" ] $ do
                    h3_ "API"
                    p_ "Plaintext: curl https://week.vevapp.no"
                    p_ "JSON: curl https://week.vevapp.no --header \"Accept: application/json\""

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
