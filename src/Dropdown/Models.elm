module Dropdown.Models exposing (..)


type alias Config msg item =
    { arrowClass : String
    , clearClass : String
    , itemClass : String
    , itemStyles : List ( String, String )
    , menuClass : String
    , menuStyles : List ( String, String )
    , onSelect : Maybe item -> msg
    , promptClass : String
    , selectedClass : String
    , selectedStyles : List ( String, String )
    , toLabel : item -> String
    }


newConfig : (Maybe item -> msg) -> (item -> String) -> Config msg item
newConfig onSelect toLabel =
    { arrowClass = ""
    , clearClass = ""
    , itemClass = ""
    , itemStyles = []
    , menuClass = ""
    , menuStyles = []
    , onSelect = onSelect
    , promptClass = ""
    , selectedClass = ""
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
