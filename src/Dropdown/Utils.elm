module Dropdown.Utils exposing (..)

import Dropdown.Models exposing (..)


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
