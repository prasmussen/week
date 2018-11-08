{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Week.Api
    ( app
    ) where


import qualified Week.Api.Routes as Routes
import qualified Servant


type AppAPI
    = Routes.Api


appApi :: Servant.Proxy AppAPI
appApi =
    Servant.Proxy


appServer :: Servant.Server AppAPI
appServer =
    Routes.server


app :: Servant.Application
app =
    Servant.serve appApi appServer