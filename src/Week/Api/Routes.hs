{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Week.Api.Routes
    ( Api
    , server
    ) where

import qualified Week.Api.Root as Root
import qualified Week.WeekInfo as WeekInfo
import qualified Week.Config as Config
import Servant
import Servant.HTML.Lucid



type Api
      =  RootRoute
    :<|> StaticRoute


server :: Config.Config -> Server Api
server config
      =  Root.root
    :<|> serveDirectoryWebApp (Config.staticPathStr config)


type RootRoute =
    Get '[PlainText, JSON, HTML] WeekInfo.WeekInfo


type StaticRoute =
    "static"
    :> Raw
