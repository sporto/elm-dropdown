module Dropdown.Utils exposing (..)

import Dropdown.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (attribute, class, value)


toKey : Int -> Key
toKey keyCode =
    case keyCode of
        13 ->
            KeyEnter

        27 ->
            KeyEsc

        32 ->
            KeySpace

        38 ->
            KeyArrowUp

        40 ->
            KeyArrowDown

        _ ->
            KeyOther


referenceDataName : String
referenceDataName =
    "data-dropdown-id"


referenceAttr : Config msg item -> State -> Attribute msg2
referenceAttr config model =
    attribute referenceDataName model.id
