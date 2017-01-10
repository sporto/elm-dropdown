module Dropdown.View.Arrow exposing (..)

import Dropdown.Models as Models
import Svg exposing (..)
import Svg.Attributes exposing (..)


view : Models.Config userMsg item -> Svg msg
view config =
    svg [ class config.arrowSvgClass, width "16", height "16", viewBox "0 0 16 16" ]
        [ g [ transform "translate(3, 6)" ]
            [ polygon [ points "4.5,5 9,0 0,0" ] []
            ]
        ]
