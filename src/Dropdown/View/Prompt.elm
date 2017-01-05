module Dropdown.View.Prompt exposing (..)

import Dropdown.Messages as Messages
import Dropdown.Models as Models
import Dropdown.View.Arrow as Arrow
import Html exposing (..)
import Html.Attributes exposing (class, id, style)
import Html.Events exposing (onClick)


view : Models.Config msg item -> Models.State -> List item -> Maybe item -> Html (Messages.Msg item)
view config model items selected =
    let
        prompWrapperStyles =
            [ ( "display", "flex" )
            , ( "align-items", "center" )
            , ( "cursor", "pointer" )
            ]

        promptText =
            case selected of
                Nothing ->
                    nbsp

                Just item ->
                    config.toLabel item
    in
        div
            [ class config.promptClass
            , style prompWrapperStyles
            , onClick Messages.OnClickPrompt
            ]
            [ span [] [ text promptText ]
            , Arrow.arrow config
            ]


nbsp =
    " "
