module Dropdown.View.Prompt exposing (..)

import Dropdown.Messages exposing (..)
import Dropdown.Models exposing (..)
import Dropdown.View.Arrow as Arrow
import Dropdown.View.Clear as Clear
import Html exposing (..)
import Html.Attributes exposing (class, id, style, tabindex)
import Html.Events exposing (onWithOptions, onClick)
import Json.Decode as Decode


view : Config msg item -> State -> List item -> Maybe item -> Html (Msg item)
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

        clear =
            case selected of
                Nothing ->
                    text ""

                Just _ ->
                    span [ onClickWithoutPropagation OnClear ] [ Clear.view config ]

        promptText =
            case selected of
                Nothing ->
                    nbsp

                Just item ->
                    config.toLabel item

        onClickWithoutPropagation msg =
            Decode.succeed msg
                |> onWithOptions "click" { stopPropagation = True, preventDefault = False }
    in
        div
            [ class config.promptClass
            , style prompWrapperStyles
            , onClick OnClickPrompt
            , tabindex 0
            ]
            [ span [ style textStyles ] [ text promptText ]
            , clear
            , span [ style arrowStyles ] [ Arrow.view config ]
            ]


nbsp : String
nbsp =
    " "
