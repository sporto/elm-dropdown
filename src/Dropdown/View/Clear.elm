module Dropdown.View.Clear exposing (..)

import Dropdown.Models as Models
import Svg exposing (..)
import Svg.Attributes as Attrs


view : Models.Config userMsg item -> Svg msg
view config =
    svg [ Attrs.class config.arrowClass, Attrs.width "16", Attrs.height "16", Attrs.viewBox "0 0 16 16" ]
        [ g [ Attrs.transform "translate(4, 6)" ]
            [ path [ Attrs.d svgPath ] []
            ]
        ]


svgPath : String
svgPath =
    "M5,-2.5575245e-15 C3.66990575,-0.0132303807 2.39043461,0.509304222 1.44986941,1.44986941 C0.509304222,2.39043461 -0.0132303807,3.66990575 1.22125617e-14,5 C-0.0132303807,6.33009425 0.509304222,7.60956539 1.44986941,8.55013059 C2.39043461,9.49069578 3.66990575,10.0132304 5,10 C6.33009425,10.0132304 7.60956539,9.49069578 8.55013059,8.55013059 C9.49069578,7.60956539 10.0132304,6.33009425 10,5 C10.0132304,3.66990575 9.49069578,2.39043461 8.55013059,1.44986941 C7.60956539,0.509304222 6.33009425,-0.0132303807 5,-2.5575245e-15 Z M7,6.2 C7.20014558,6.42911206 7.20014558,6.77088794 7,7 C6.77088794,7.20014558 6.42911206,7.20014558 6.2,7 L5,5.8 L3.7,7 C3.60882286,7.09587507 3.48230759,7.15015018 3.35,7.15015018 C3.21769241,7.15015018 3.09117714,7.09587507 3,7 C2.90412493,6.90882286 2.84984982,6.78230759 2.84984982,6.65 C2.84984982,6.51769241 2.90412493,6.39117714 3,6.3 L4.2,5 L3,3.8 C2.79985442,3.57088794 2.79985442,3.22911206 3,3 C3.22776052,2.79628479 3.57223948,2.79628479 3.8,3 L5,4.2 L6.3,3 C6.39117714,2.90412493 6.51769241,2.84984982 6.65,2.84984982 C6.78230759,2.84984982 6.90882286,2.90412493 7,3 C7.09587507,3.09117714 7.15015018,3.21769241 7.15015018,3.35 C7.15015018,3.48230759 7.09587507,3.60882286 7,3.7 L5.8,5 L7,6.2 Z"
