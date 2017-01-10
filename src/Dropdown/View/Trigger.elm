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
        styles =
            [ ( "display", "flex" )
            , ( "align-items", "center" )
            , ( "cursor", "pointer" )
            ]

        classes =
            config.triggerClass
    in
        div
            [ class classes
            , onBlurAttribute config state
            , onClick OnClickPrompt
            , onKeyUpAttribute
            , style styles
            , tabindex 0
            , Utils.referenceAttr config state
            ]
            [ promptOrCurrentView config state selected
            , clearView config state selected
            , arrowView config state
            ]


promptOrCurrentView : Config msg item -> State -> Maybe item -> Html (Msg item)
promptOrCurrentView config state selected =
    let
        ( maybePromptClass, maybePromptStyles ) =
            case selected of
                Nothing ->
                    ( config.promptClass, config.promptStyles )

                _ ->
                    ( "", [] )

        classes =
            maybePromptClass

        styles =
            List.append
                [ ( "flex-grow", "1" )
                , ( "text-overflow", "ellipsis" )
                , ( "overflow", "hidden" )
                , ( "white-space", "nowrap" )
                ]
                maybePromptStyles

        shownText =
            case selected of
                Nothing ->
                    config.prompt

                Just item ->
                    config.toLabel item
    in
        span [ class classes, style styles ] [ text shownText ]


clearView : Config msg item -> State -> Maybe item -> Html (Msg item)
clearView config state selected =
    let
        classes =
            "elm-dropdown-clear " ++ config.clearClass

        styles =
            config.clearStyles

        onClickWithoutPropagation msg =
            Decode.succeed msg
                |> onWithOptions "click" { stopPropagation = True, preventDefault = False }
    in
        if config.hasClear then
            case selected of
                Nothing ->
                    text ""

                Just _ ->
                    span
                        [ class classes
                        , style styles
                        , onClickWithoutPropagation OnClear
                        ]
                        [ Clear.view config ]
        else
            text ""


arrowView : Config msg item -> State -> Html (Msg item)
arrowView config state =
    let
        classes =
            "elm-dropdown-arrow " ++ config.arrowClass

        styles =
            List.append config.arrowStyles
                [ ( "padding", "0 0.25rem 0 0" )
                ]
    in
        span
            [ class classes
            , style styles
            ]
            [ Arrow.view config ]
