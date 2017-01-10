module Dropdown.Models exposing (..)


type alias Style =
    ( String, String )


type alias Config msg item =
    { arrowClass : String
    , arrowStyles : List Style
    , arrowSvgClass : String
    , clearClass : String
    , clearStyles : List Style
    , clearSvgClass : String
    , hasClear : Bool
    , itemClass : String
    , itemStyles : List Style
    , menuClass : String
    , menuStyles : List Style
    , onSelect : Maybe item -> msg
    , prompt : String
    , promptClass : String
    , promptStyles : List Style
    , selectedClass : String
    , selectedStyles : List Style
    , toLabel : item -> String
    , triggerClass : String
    }


newConfig : (Maybe item -> msg) -> (item -> String) -> Config msg item
newConfig onSelect toLabel =
    { arrowClass = ""
    , arrowStyles = []
    , arrowSvgClass = ""
    , clearClass = ""
    , clearStyles = []
    , clearSvgClass = ""
    , hasClear = True
    , itemClass = ""
    , itemStyles = []
    , menuClass = ""
    , menuStyles = []
    , onSelect = onSelect
    , prompt = " "
    , promptClass = ""
    , promptStyles = []
    , triggerClass = ""
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


type Key
    = KeyOther
    | KeyArrowDown
    | KeyArrowUp
    | KeyEnter
    | KeyEsc
    | KeySpace
