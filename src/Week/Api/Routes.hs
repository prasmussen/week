{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Week.Api.Routes
    ( Api
    , JsonApi
    , server
    ) where

import qualified Week.Api.ApiInfo as ApiInfo
import qualified Week.Api.Html.Home as HomeHtml
import qualified Week.Api.Json.Home as HomeJson
import qualified Lucid
import Servant
import Servant.HTML.Lucid



type Api
      =  HtmlApi
    :<|> JsonApi
    :<|> StaticRoute


server :: Server Api
server
      =  (htmlServer)
    :<|> (jsonServer)
    :<|> serveDirectoryWebApp "static"


type HtmlApi
      =  HomeHtmlRoute


htmlServer :: Server HtmlApi
htmlServer
      =  (HomeHtml.home)


type JsonApi
      =  ApiInfoJsonRoute


jsonServer :: Server JsonApi
jsonServer
      =  (HomeJson.apiInfo)


type HomeHtmlRoute =
    Get '[HTML] (Lucid.Html ())


type ApiInfoJsonRoute =
    Get '[JSON] HomeJson.WeekInfo


type StaticRoute =
    "static"
    :> Raw
