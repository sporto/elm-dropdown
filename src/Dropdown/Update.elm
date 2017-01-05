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

        OnEsc ->
            ( { model | isOpened = False }, Cmd.none )

        OnClickPrompt ->
            ( { model | isOpened = not model.isOpened }, Cmd.none )

        OnSelect item ->
            let
                cmd =
                    Task.succeed item
                        |> Task.perform config.onSelect
            in
                ( { model | isOpened = False }, cmd )
