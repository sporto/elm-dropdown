module Main exposing (..)

import Example1
import Example2
import Html exposing (..)
import Html.Attributes exposing (class, href)


type alias Model =
    { example1 : Example1.Model
    , example2 : Example2.Model
    }


initialModel : Model
initialModel =
    { example1 = Example1.initialModel "example1"
    , example2 = Example2.initialModel "example2"
    }


initialCmds : Cmd Msg
initialCmds =
    Cmd.none


init : ( Model, Cmd Msg )
init =
    ( initialModel, initialCmds )


type Msg
    = NoOp
    | Example1Msg Example1.Msg
    | Example2Msg Example2.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Example1Msg sub ->
            let
                ( subModel, subCmd ) =
                    Example1.update sub model.example1
            in
                ( { model | example1 = subModel }, Cmd.map Example1Msg subCmd )

        Example2Msg sub ->
            let
                ( subModel, subCmd ) =
                    Example2.update sub model.example2
            in
                ( { model | example2 = subModel }, Cmd.map Example2Msg subCmd )

        NoOp ->
            ( model, Cmd.none )


projectUrl : String
projectUrl =
    "https://github.com/sporto/elm-dropdown"


view : Model -> Html Msg
view model =
    div [ class "p3" ]
        [ h1 [] [ text "Elm Dropdown" ]
        , a [ class "h3", href projectUrl ] [ text projectUrl ]
        , div [ class "clearfix mt2" ]
            [ div [ class "col col-6" ]
                [ Html.map Example1Msg (Example1.view model.example1)
                ]
            , div [ class "col col-6" ]
                [ Html.map Example2Msg (Example2.view model.example2)
                ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
