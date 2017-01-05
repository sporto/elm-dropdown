module Dropdown.View.Arrow exposing (..)

import Dropdown.Models as Models
import Svg exposing (..)
import Svg.Attributes exposing (..)


arrow : Models.Config userMsg item -> Svg msg
arrow config =
    svg [ class config.arrowClass, width "16", height "16", viewBox "0 0 16 16" ]
        [ g [ transform "translate(4, 6)" ]
            [ polygon [ points "4.5,5 9,0 0,0" ] []
            ]
        ]
