module View exposing (View, map, placeholder)

import Html exposing (Html)



-- View type must have exactly 1 type variable


type alias View msg =
    { title : String
    , body : List (Html msg)
    }


map : (msg1 -> msg2) -> View msg1 -> View msg2
map fn view_doc =
    { title = view_doc.title

    -- convert all Html msg1 to Html msg2
    , body = List.map (Html.map fn) view_doc.body
    }



-- used in conjunction with elm-pages cli to create new routes


placeholder : String -> View msg
placeholder moduleName =
    { title = "Placeholder - " ++ moduleName
    , body = [ Html.text moduleName ]
    }
