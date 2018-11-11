module Main where

import qualified Network.Wai.Handler.Warp as Warp
import qualified Week.Api as Api
import qualified Safe
import qualified Text.Read as Read
import qualified System.Environment as Env
import qualified Data.Coerce as Coerce
import Data.Monoid ((<>))


main :: IO ()
main = do
    listenPort <- lookupSetting "LISTEN_PORT" (ListenPort 8081)
    putStrLn $ "Listening on port: " <> (show listenPort)
    Warp.run (Coerce.coerce listenPort) Api.app



lookupSetting :: Read a => String -> a -> IO a
lookupSetting envKey def = do
    maybeValue <- Env.lookupEnv envKey
    case maybeValue of
        Just str ->
            return $ readSetting envKey str

        Nothing ->
            return def


readSetting :: Read a => String -> String -> a
readSetting envKey str =
    case Safe.readMay str of
        Just value ->
            value

        Nothing ->
            error $ mconcat
                [ "«"
                , str
                , "» is not a valid value for the environment variable "
                , envKey
                ]


newtype ListenPort = ListenPort Int
    deriving (Show)

instance Read ListenPort where
    readsPrec _ = readMaybe ListenPort


readMaybe :: Read b => (b -> a) -> String -> [(a, String)]
readMaybe constructor str =
    case Read.readMaybe str :: Read b => Maybe b of
        Just value ->
            [(constructor value, "")]

        Nothing ->
            []
