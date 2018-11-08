module Week.Week
    ( getWeek
    ) where


import qualified Data.Time.Clock as Clock
import qualified Data.Time.Calendar as Calendar
import qualified Data.Time.Calendar.WeekDate as WeekDate

getWeek :: Calendar.Day -> Int
getWeek day =
    weekOfYear
    where
        (_, weekOfYear, _) = WeekDate.toWeekDate day



