module Dropdown.Events exposing (..)

import Debug
import Dropdown.Messages exposing (..)
import Dropdown.Models exposing (..)
import Dropdown.Utils exposing (referenceDataName)
import Html exposing (..)
import Html.Events exposing (on)
import Json.Decode as Decode


{-| @priv

Use:

    Decode.maybe (traceDecoder "dataDecoder" dataDecoder)
-}
traceDecoder : String -> Decode.Decoder msg -> Decode.Decoder msg
traceDecoder message decoder =
    let
        log value =
            case Decode.decodeValue decoder value of
                Ok decoded ->
                    decoded |> Decode.succeed

                Err err ->
                    err |> Debug.log message |> Decode.fail
    in
        Decode.value
            |> Decode.andThen log


onBlurAttribute : Config msg item -> State -> Attribute (Msg item)
onBlurAttribute config state =
    let
        -- relatedTarget only works if element has tabindex
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
