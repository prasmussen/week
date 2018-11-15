{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}


module Week.Api
    ( app
    ) where


import qualified Week.Api.Routes as Routes
import qualified Week.Config as Config
import qualified Servant


type AppAPI
    = Routes.Api


appApi :: Servant.Proxy AppAPI
appApi =
    Servant.Proxy


appServer :: Config.Config -> Servant.Server AppAPI
appServer config =
    Routes.server config


app :: Config.Config -> Servant.Application
app config =
    Servant.serve appApi (appServer config)