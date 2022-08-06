module Page.MachineLearningBasics exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Html exposing (..)
import Katex as K exposing (Latex, display, human, inline)
import MiniLatex
import MiniLatex.Edit exposing (LaTeXMsg)
import Page exposing (PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)


passage : List Latex
passage =
    [ human "We denote by "
    , inline "\\phi"
    , human " the formula for which "
    , display "\\Gamma \\vDash \\phi"
    ]


type alias Model =
    {}


type Msg
    = LatexToHtml LaTeXMsg


type alias RouteParams =
    {}


page : PageWithState RouteParams Data {} Msg
page =
    Page.single
        -- prerender
        { head = head
        , data = data

        -- , routes = DataSource.succeed []
        }
        |> Page.buildWithSharedState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


init maybe_pageurl shared_model static_payload =
    ( {}, Cmd.none )


update pageurl maybe_nav_key shared_model static_payload msg model =
    case msg of
        LatexToHtml ltxmsg ->
            let
                _ =
                    Debug.log "ltxmsg" ltxmsg
            in
            ( model, Cmd.none, Nothing )



-- ( model, Cmd.none, Nothing )


subscriptions maybe_page_url route_params path shared_model model =
    Sub.none


type alias Data =
    {}



-- data : RouteParams -> DataSource Data


data : DataSource Data
data =
    DataSource.succeed {}


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "machine learning basics" -- metadata.title -- TODO
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel model static =
    let
        htmlGenerator isDisplayMode stringLatex =
            case isDisplayMode of
                Just True ->
                    Html.div [] [ text stringLatex ]

                _ ->
                    span [] [ text stringLatex ]

        _ =
            Debug.log "parse" (MiniLatex.parse txt)

        _ =
            Debug.log "render" (MiniLatex.render txt txt)
    in
    { title = "Machine Learning Basics"
    , body =
        [ div [] [ h2 [] [ text "Machine Learning" ] ]

        -- , passage |> List.map (K.generate htmlGenerator) |> div []
        , text txt
        , Html.map LatexToHtml (MiniLatex.render txt txt) -- |> Html.map mp_latex
        ]
    }


mp_latex : LaTeXMsg -> Msg
mp_latex x =
    let
        _ =
            Debug.log "latex:" x
    in
    LatexToHtml x


txt : String
txt =
    "Pythagoras says: $a^2 + b^2 = c^2$"
