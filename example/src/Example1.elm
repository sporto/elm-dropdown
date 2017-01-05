module Example1 exposing (..)

import Debug
import Html exposing (..)
import Html.Attributes exposing (class)
import Movies
import Dropdown


{-|
Model to be passed to the select component. You model can be anything.
E.g. Records, tuples or just strings.
-}
type alias Movie =
    { id : String
    , label : String
    }


{-|
In your main application model you should store:

- The selected item e.g. selectedMovieId
- The state for the select component
-}
type alias Model =
    { id : String
    , movies : List Movie
    , selectedMovieId : Maybe String
    , dropdownState : Dropdown.State
    }


{-|
This just transforms a list of tuples into records
-}
movies : List Movie
movies =
    Movies.movies
        |> List.map (\( id, name ) -> Movie id name)
        |> List.take 6


{-|
Your model should store the selected item and the state of the Select component(s)
-}
initialModel : String -> Model
initialModel id =
    { id = id
    , movies = movies
    , selectedMovieId = Nothing
    , dropdownState = Dropdown.newState id
    }


{-|
Your application messages need to include:
- OnSelect item : This will be called when an item is selected
- DropdownMsg (Dropdown.Msg item) : A message that wraps internal Select library messages. This is necessary to route messages back to the component.
-}
type Msg
    = NoOp
    | OnSelect (Maybe Movie)
    | DropdownMsg (Dropdown.Msg Movie)


{-|
Create the configuration for the Dropdown component

`Dropdown.newConfig` takes two args:

- The selection message e.g. `OnSelect`
- A function that extract a label from an item e.g. `.label`
-}
dropdownConfig : Dropdown.Config Msg Movie
dropdownConfig =
    Dropdown.newConfig OnSelect .label
        |> Dropdown.withItemClass "border-bottom border-silver p1"
        |> Dropdown.withItemStyles [ ( "color", "darkgrey" ) ]
        |> Dropdown.withMenuClass "border border-gray"
        |> Dropdown.withMenuStyles [ ( "background", "white" ) ]
        |> Dropdown.withPromptClass "col-12 bg-white p1"


{-|
Your update function should route messages back to the Dropdown component, see `DropdownMsg`.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        -- OnSelect is triggered when a selection is made on the Dropdown component.
        OnSelect maybeMovie ->
            let
                maybeId =
                    maybeMovie
                        |> Maybe.map .id
            in
                ( { model | selectedMovieId = maybeId }, Cmd.none )

        -- Route message to the Dropdown component.
        -- The returned command is important.
        DropdownMsg subMsg ->
            let
                ( updated, cmd ) =
                    Dropdown.update dropdownConfig subMsg model.dropdownState
            in
                ( { model | dropdownState = updated }, cmd )

        NoOp ->
            ( model, Cmd.none )


{-|
Your view renders the select component passing the config, state, list of items and the currently selected item.
-}
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
            [ h3 [] [ text "Basic example" ]
            , text (toString model.selectedMovieId)
              -- Render the Dropdown view. You must pass:
              -- - The configuration
              -- - A unique identifier for the select component
              -- - The Dropdown internal state
              -- - A list of items
              -- - The currently selected item as Maybe
            , h4 [] [ text "Pick a movie" ]
            , Html.map DropdownMsg (Dropdown.view dropdownConfig model.dropdownState model.movies selectedMovie)
            ]
