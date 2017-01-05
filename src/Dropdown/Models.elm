module Dropdown.Models exposing (..)


type alias Config msg item =
    { arrowClass : String
    , itemClass : String
    , itemStyles : List ( String, String )
    , menuClass : String
    , menuStyles : List ( String, String )
    , onSelect : item -> msg
    , promptClass : String
    , selectedStyles : List ( String, String )
    , toLabel : item -> String
    }


newConfig : (item -> msg) -> (item -> String) -> Config msg item
newConfig onSelect toLabel =
    { arrowClass = ""
    , itemClass = ""
    , itemStyles = []
    , menuClass = ""
    , menuStyles = []
    , onSelect = onSelect
    , promptClass = ""
    , selectedStyles = []
    , toLabel = toLabel
    }


type alias State =
    { id : String
    , isOpened : Bool
    }


newState : String -> State
newState id =
    { id = id
    , isOpened = False
    }
