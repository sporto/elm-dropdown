module Dropdown.View exposing (..)

import Dropdown.Messages exposing (..)
import Dropdown.Models exposing (..)
import Dropdown.View.List as List
import Dropdown.View.Trigger as Trigger
import Html exposing (..)
import Html.Attributes exposing (class, id, style)


view : Config msg item -> State -> List item -> Maybe item -> Html (Msg item)
view config model items selected =
    let
        menuWrapperStyles =
            [ ( "position", "relative" )
            ]

        menu =
            if model.isOpened then
                div [ style menuWrapperStyles ]
                    [ List.view config model items selected
                    ]
            else
                span [] []
    in
        div [ id model.id ]
            [ Trigger.view config model items selected
            , menu
            ]
