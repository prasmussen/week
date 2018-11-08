module Week.Api.Json.Home
    ( WeekInfo(..)
    , apiInfo
    ) where

import qualified Data.Aeson as Aeson
import qualified GHC.Generics as GHC
import Servant


data WeekInfo = WeekInfo
    { week :: Int
    }
    deriving (Show, GHC.Generic)

instance Aeson.ToJSON WeekInfo


apiInfo :: Handler WeekInfo
apiInfo = do
    return $ WeekInfo
        { week = 0
        }
