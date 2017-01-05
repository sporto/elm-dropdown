module Example2 exposing (..)

import Debug
import Html exposing (..)
import Html.Attributes exposing (class)
import Movies
import Dropdown


type alias Movie =
    { id : String
    , label : String
    }


type alias Model =
    { id : String
    , movies : List Movie
    , selectedMovieId : Maybe String
    , dropdownState : Dropdown.State
    }


movies : List Movie
movies =
    Movies.movies
        |> List.map (\( id, name ) -> Movie id name)
        |> List.take 6


initialModel : String -> Model
initialModel id =
    { id = id
    , movies = movies
    , selectedMovieId = Nothing
    , dropdownState = Dropdown.newState id
    }


type Msg
    = NoOp
    | OnSelect (Maybe Movie)
    | DropdownMsg (Dropdown.Msg Movie)


dropdownConfig : Dropdown.Config Msg Movie
dropdownConfig =
    Dropdown.newConfig OnSelect .label
        |> Dropdown.withClear False


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        OnSelect maybeMovie ->
            let
                maybeId =
                    maybeMovie
                        |> Maybe.map .id
            in
                ( { model | selectedMovieId = maybeId }, Cmd.none )

        DropdownMsg subMsg ->
            let
                ( updated, cmd ) =
                    Dropdown.update dropdownConfig subMsg model.dropdownState
            in
                ( { model | dropdownState = updated }, cmd )

        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    let
        selectedMovie =
            case model.selectedMovieId of
                Nothing ->
                    Nothing

                Just id ->
                    List.filter (\movie -> movie.id == id) movies
                        |> List.head
    in
        div [ class "bg-silver p1" ]
            [ h3 [] [ text "No styles" ]
            , text (toString model.selectedMovieId)
            , h4 [] [ text "Pick a movie" ]
            , Html.map DropdownMsg (Dropdown.view dropdownConfig model.dropdownState model.movies selectedMovie)
            ]
