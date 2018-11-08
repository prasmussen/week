module Week.Api.ApiInfo
    ( ApiInfo(..)
    ) where

import qualified Data.Aeson as Aeson
import qualified Data.Text as T
import qualified GHC.Generics as GHC


data ApiInfo = ApiInfo
    { description :: T.Text
    , version :: T.Text
    }
    deriving (Show, GHC.Generic)

instance Aeson.ToJSON ApiInfo
