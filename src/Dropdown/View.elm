module Dropdown.View exposing (..)

import Dropdown.Messages as Messages
import Dropdown.Models as Models
import Dropdown.View.Arrow as Arrow
import Dropdown.View.List as List
import Html exposing (..)
import Html.Attributes exposing (class, id, style)
import Html.Events exposing (onClick)


view : Models.Config msg item -> Models.State -> List item -> Maybe item -> Html (Messages.Msg item)
view config model items selected =
    let
        menuWrapperStyles =
            [ ( "position", "relative" )
            ]

        prompWrapperStyles =
            [ ( "display", "flex" )
            , ( "align-items", "center" )
            , ( "cursor", "pointer" )
            ]

        promptText =
            case selected of
                Nothing ->
                    ""

                Just item ->
                    config.toLabel item

        prompt =
            div
                [ class config.promptClass
                , style prompWrapperStyles
                , onClick Messages.OnClickPrompt
                ]
                [ span [] [ text promptText ]
                , Arrow.arrow config
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
            [ prompt
            , menu
            ]
