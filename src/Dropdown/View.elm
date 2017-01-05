module Dropdown.View exposing (..)

import Dropdown.Messages as Messages
import Dropdown.Models as Models
import Dropdown.View.List as List
import Dropdown.View.Prompt as Prompt
import Html exposing (..)
import Html.Attributes exposing (class, id, style)


view : Models.Config msg item -> Models.State -> List item -> Maybe item -> Html (Messages.Msg item)
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
            [ Prompt.view config model items selected
            , menu
            ]
