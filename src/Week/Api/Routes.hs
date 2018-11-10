{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Week.Api.Routes
    ( Api
    , server
    ) where

import qualified Week.Api.ApiInfo as ApiInfo
import qualified Week.Api.Html.Home as HomeHtml
import qualified Lucid
import Servant
import Servant.HTML.Lucid



type Api
      =  HtmlApi
    :<|> StaticRoute


server :: Server Api
server
      =  (htmlServer)
    :<|> serveDirectoryWebApp "static"


type HtmlApi
      =  HomeHtmlRoute


htmlServer :: Server HtmlApi
htmlServer
      =  (HomeHtml.home)



type HomeHtmlRoute =
    Get '[PlainText, JSON, HTML] HomeHtml.WeekInfo


type StaticRoute =
    "static"
    :> Raw
