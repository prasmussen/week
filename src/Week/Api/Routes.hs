{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Week.Api.Routes
    ( Api
    , server
    ) where

import qualified Week.Api.Root as Root
import qualified Week.WeekInfo as WeekInfo
import Servant
import Servant.HTML.Lucid



type Api
      =  HomeHtmlRoute
    :<|> StaticRoute


server :: Server Api
server
      =  Root.root
    :<|> serveDirectoryWebApp "static"



type HomeHtmlRoute =
    Get '[PlainText, JSON, HTML] WeekInfo.WeekInfo


type StaticRoute =
    "static"
    :> Raw
