module Dropdown.Update exposing (..)

import Dropdown.Messages exposing (..)
import Dropdown.Models as Models
import Task


update : Models.Config msg item -> Msg item -> Models.State -> ( Models.State, Cmd msg )
update config msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnBlur ->
            ( { model | isOpened = False }, Cmd.none )

        OnClear ->
            let
                cmd =
                    Task.succeed Nothing
                        |> Task.perform config.onSelect
            in
                ( { model | isOpened = False }, cmd )

        OnClickPrompt ->
            ( { model | isOpened = not model.isOpened }, Cmd.none )

        OnEsc ->
            ( { model | isOpened = False }, Cmd.none )

        OnSelect item ->
            let
                cmd =
                    Task.succeed (Just item)
                        |> Task.perform config.onSelect
            in
                ( { model | isOpened = False }, cmd )
