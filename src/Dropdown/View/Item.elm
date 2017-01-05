module Dropdown.View.Item exposing (..)

import Dropdown.Messages as Messages
import Dropdown.Models as Models
import Html exposing (..)
import Html.Attributes exposing (attribute, class, style, tabindex)
import Html.Events exposing (onClick, on, keyCode)


view : Models.Config msg item -> Models.State -> Maybe item -> item -> Html (Messages.Msg item)
view config state selected item =
    let
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
            [ onClick (Messages.OnSelect item)
            , tabindex 0
            , class config.itemClass
            , style styles
            ]
            [ text (config.toLabel item)
            ]
