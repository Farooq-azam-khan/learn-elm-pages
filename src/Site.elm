module Site exposing (config)

import DataSource
import Head
import Pages.Manifest as Manifest
import Pages.Url as Url
import Path
import Route
import SiteConfig exposing (SiteConfig)


type alias Data =
    ()


config : SiteConfig Data
config =
    { data = data
    , canonicalUrl = "https://elm-pages.com"
    , manifest = manifest
    , head = head
    }


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


head : Data -> List Head.Tag
head static =
    [ Head.sitemapLink "/sitemap.xml"

    -- , Head.appleTouchIcon Nothing (Url.fromPath <| Path.fromString "favicon_ico/apple-touch-icon.png")
    ]



{-
   <link rel="apple-touch-icon" sizes="180x180" href="favicon_io/apple-touch-icon.png">
   <link rel="icon" type="image/png" sizes="32x32" href="favicon_io/favicon-32x32.png">
   <link rel="icon" type="image/png" sizes="16x16" href="favicon_io/favicon-16x16.png">
   <link rel="manifest" href="favicon_io/site.webmanifest">
   <link rel="icon" type="image/x-icon" href="/favicon.ico" />
-}


manifest : Data -> Manifest.Config
manifest static_data =
    Manifest.init
        { name = "elm pages test site"
        , description = "this site is to help understand the inner workings of elm pages"
        , startUrl = Route.Index |> Route.toPath
        , icons = []
        }
