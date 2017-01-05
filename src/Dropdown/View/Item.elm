module Dropdown.View.Item exposing (..)

import Dropdown.Messages exposing (..)
import Dropdown.Models exposing (..)
import Dropdown.Utils as Utils
import Html exposing (..)
import Html.Attributes exposing (attribute, class, style, tabindex)
import Html.Events exposing (onClick, on, keyCode)
import Json.Decode as Decode


onKeyUpAttribute : item -> Attribute (Msg item)
onKeyUpAttribute item =
    let
        fn code =
            case Utils.toKey code of
                KeyEnter ->
                    Decode.succeed (OnSelect item)

                KeyEsc ->
                    Decode.succeed OnEsc

                KeySpace ->
                    Decode.succeed (OnSelect item)

                _ ->
                    Decode.fail "not ENTER"
    in
        on "keyup" (Decode.andThen fn keyCode)


view : Config msg item -> State -> Maybe item -> item -> Html (Msg item)
view config state selected item =
    let
        classes =
            config.itemClass ++ " " ++ config.selectedClass

        baseStyles =
            [ ( "cursor", "pointer" )
            ]

        selectedStyles =
            case selected of
                Just selectedItem ->
                    if selectedItem == item then
                        config.selectedStyles
                    else
                        []

                Nothing ->
                    []

        styles =
            List.concat [ baseStyles, selectedStyles, config.itemStyles ]
    in
        div
            [ class classes
            , onClick (OnSelect item)
            , onKeyUpAttribute item
            , Utils.referenceAttr config state
            , style styles
            ]
            [ text (config.toLabel item)
            ]
