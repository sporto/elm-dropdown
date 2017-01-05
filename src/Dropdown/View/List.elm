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

        styles =
            List.concat
                [ config.menuStyles
                , [ ( "position", "absolute" )
                  ]
                ]
    in
        div [ class config.menuClass, style styles ] renderedItems
