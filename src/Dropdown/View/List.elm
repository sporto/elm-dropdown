module Dropdown.View.List exposing (..)

import Dropdown.Messages as Messages
import Dropdown.Models as Models
import Dropdown.View.Item as Item
import Html exposing (..)
import Html.Attributes exposing (class, style)


view : Models.Config msg item -> Models.State -> List item -> Maybe item -> Html (Messages.Msg item)
view config model items selected =
    let
        renderedItems =
            List.map (Item.view config model selected) items

        classes =
            config.menuClass

        styles =
            List.append config.menuStyles
                [ ( "position", "absolute" )
                , ( "width", "100%" )
                ]
    in
        div [ class classes, style styles ] renderedItems
