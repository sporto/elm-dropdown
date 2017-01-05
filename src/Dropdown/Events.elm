module Dropdown.Events exposing (..)

import Dropdown.Messages exposing (..)
import Dropdown.Models exposing (..)
import Dropdown.Utils exposing (referenceDataName)
import Html exposing (..)
import Html.Events exposing (on)
import Json.Decode as Decode


onBlurAttribute : Config msg item -> State -> Attribute (Msg item)
onBlurAttribute config state =
    let
        dataDecoder =
            Decode.at [ "relatedTarget", "attributes", referenceDataName, "value" ] Decode.string

        attrToMsg attr =
            if attr == state.id then
                NoOp
            else
                OnBlur

        blur =
            Decode.maybe dataDecoder
                |> Decode.map (Maybe.map attrToMsg)
                |> Decode.map (Maybe.withDefault OnBlur)
    in
        on "blur" blur
