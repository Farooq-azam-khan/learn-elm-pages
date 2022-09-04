port module Page.MachineLearningBasics exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import DataSource.Port as Dport
import Head
import Head.Seo as Seo
import Html exposing (..)
import Html.Attributes exposing (property)
import Html.Events exposing (..)
import Html.Parser exposing (Node(..))
import Html.Parser.Util
import Json.Encode as Encode
import OptimizedDecoder as Decode
import Page exposing (PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)


type alias Model =
    {}


type Msg
    = RenderLatexMsg


type alias RouteParams =
    {}


page : PageWithState RouteParams Data {} Msg
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildWithSharedState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


init maybe_pageurl shared_model static_payload =
    ( {}, Cmd.none )


port renderLatex : String -> Cmd msg


update pageurl maybe_nav_key shared_model static_payload msg model =
    case msg of
        RenderLatexMsg ->
            ( model, renderLatex "", Nothing )




subscriptions : a -> b -> c -> d -> e -> Sub msg
subscriptions maybe_page_url route_params path shared_model model =
    Sub.none


type alias Data =
    List String


data : DataSource Data
data =
    DataSource.combine
        [ Dport.get "parse_katex"
            (Encode.string "a^2+b^2=c^2")
            Decode.string
        , Dport.get "parse_katex"
            (Encode.string """\\begin{bmatrix*}[r] 0 & -1 \\\\ 
-1 & 0 
\\end{bmatrix*}""")
            Decode.string
        ]


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
        , title = "machine learning basics"
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

        formulas =
            List.map
                (\formula ->
                    case Html.Parser.run formula of
                        Ok html_formula ->
                            Html.Parser.Util.toVirtualDom html_formula

                        Err _ ->
                            Html.Parser.Util.toVirtualDom [ Text "error parsing formula " ]
                )
                static.data
    in
    { title = "Machine Learning Basics"
    , body =
        [ div [] [ h2 [] [ text "Machine Learning" ] ]
        , div [] (List.map (\form -> div [] form) formulas)
        ]
    }
