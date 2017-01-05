module Dropdown.View.Trigger exposing (..)

import Dropdown.Messages exposing (..)
import Dropdown.Models exposing (..)
import Dropdown.Events exposing (onBlurAttribute)
import Dropdown.Utils as Utils
import Dropdown.View.Arrow as Arrow
import Dropdown.View.Clear as Clear
import Html exposing (..)
import Html.Attributes exposing (class, id, style, tabindex)
import Html.Events exposing (on, onWithOptions, onClick, keyCode)
import Json.Decode as Decode


onKeyUpAttribute : Attribute (Msg item)
onKeyUpAttribute =
    let
        fn code =
            case Utils.toKey code of
                KeyEnter ->
                    Decode.succeed OnClickPrompt

                KeySpace ->
                    Decode.succeed OnClickPrompt

                KeyArrowDown ->
                    Decode.succeed OnClickPrompt

                _ ->
                    Decode.fail "Invalid"
    in
        on "keyup" (Decode.andThen fn keyCode)


view : Config msg item -> State -> List item -> Maybe item -> Html (Msg item)
view config state items selected =
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
                    config.prompt

                Just item ->
                    config.toLabel item

        onClickWithoutPropagation msg =
            Decode.succeed msg
                |> onWithOptions "click" { stopPropagation = True, preventDefault = False }
    in
        div
            [ class config.triggerClass
            , onBlurAttribute config state
            , onClick OnClickPrompt
            , onKeyUpAttribute
            , style prompWrapperStyles
            , tabindex 0
            , Utils.referenceAttr config state
            ]
            [ span [ style textStyles ] [ text promptText ]
            , clear
            , span [ style arrowStyles ] [ Arrow.view config ]
            ]
