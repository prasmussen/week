{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ExtendedDefaultRules #-}


module Week.Api.Html.Home
    ( home
    ) where

import qualified Control.Monad.IO.Class as IO
import qualified Data.Time.Clock as Clock
import Servant
import qualified Week.WeekInfo as WeekInfo


home :: Handler WeekInfo.WeekInfo
home = do
    time <- IO.liftIO Clock.getCurrentTime
    return $ WeekInfo.WeekInfo time
