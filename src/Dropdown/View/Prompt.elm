module Dropdown.View.Prompt exposing (..)

import Dropdown.Messages as Messages
import Dropdown.Models as Models
import Dropdown.View.Arrow as Arrow
import Dropdown.View.Clear as Clear
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

        textStyles =
            [ ( "flex-grow", "1" )
            , ( "text-overflow", "ellipsis" )
            , ( "overflow", "hidden" )
            , ( "white-space", "nowrap" )
            ]

        arrowStyles =
            [ ( "padding", "0 0.25rem 0 0" )
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
            [ span [ style textStyles ] [ text promptText ]
            , span [] [ Clear.view config ]
            , span [ style arrowStyles ] [ Arrow.view config ]
            ]


nbsp : String
nbsp =
    " "
