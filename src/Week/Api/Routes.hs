{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Week.Api.Routes
    ( Api
    , server
    ) where

import qualified Week.Api.ApiInfo as ApiInfo
import qualified Week.Api.Html.Home as HomeHtml
import qualified Week.WeekInfo as WeekInfo
import Servant
import Servant.HTML.Lucid



type Api
      =  HomeHtmlRoute
    :<|> StaticRoute


server :: Server Api
server
      =  HomeHtml.home
    :<|> serveDirectoryWebApp "static"



type HomeHtmlRoute =
    Get '[PlainText, JSON, HTML] WeekInfo.WeekInfo


type StaticRoute =
    "static"
    :> Raw
