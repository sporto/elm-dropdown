module Dropdown
    exposing
        ( Config
        , State
        , Msg
        , newConfig
        , newState
        , update
        , view
        , withArrowClass
        , withArrowStyles
        , withArrowSvgClass
        , withClear
        , withClearClass
        , withClearStyles
        , withClearSvgClass
        , withItemClass
        , withItemStyles
        , withMenuClass
        , withMenuStyles
        , withPrompt
        , withPromptClass
        , withPromptStyles
        , withSelectedClass
        , withSelectedStyles
        , withTriggerClass
        , withTriggerStyles
        )

{-| Dropdown component


# Types

@docs Config, State, Msg


# Configuration

@docs newConfig, withClear, withPrompt


# Styling

@docs withArrowClass, withArrowStyles, withArrowSvgClass, withClearClass, withClearStyles, withClearSvgClass, withItemClass, withItemStyles, withMenuClass, withMenuStyles, withPromptClass, withPromptStyles, withSelectedClass, withSelectedStyles, withTriggerClass, withTriggerStyles


# State

@docs newState


# view

@docs view


# Update

@docs update

-}

import Dropdown.Messages as Messages
import Dropdown.Models as Models
import Dropdown.Update as Update
import Dropdown.View as View
import Html exposing (Html)


{-| Opaque type that holds the configuration
-}
type Config msg item
    = PrivateConfig (Models.Config msg item)


{-| Opaque type that holds the current state
-}
type State
    = PrivateState Models.State


{-| Opaque type for internal library messages
-}
type Msg item
    = PrivateMsg (Messages.Msg item)


{-| Create a new configuration. This takes:

  - A message to trigger when an item is selected

  - A function to get a label to display from an item

    Dropdown.newConfig OnSelect .label

-}
newConfig : (Maybe item -> msg) -> (item -> String) -> Config msg item
newConfig onSelectMessage toLabel =
    PrivateConfig (Models.newConfig onSelectMessage toLabel)


{-| Add classes to the arrow wrapper

    Dropdown.withArrowClass "arrow" config

-}
withArrowClass : String -> Config msg item -> Config msg item
withArrowClass classes config =
    let
        fn c =
            { c | arrowClass = classes }
    in
        fmapConfig fn config


{-| Add styles to the arrow wrapper

    Dropdown.withArrowStyles [("color", "red")] config

-}
withArrowStyles : List ( String, String ) -> Config msg item -> Config msg item
withArrowStyles styles config =
    let
        fn c =
            { c | arrowStyles = styles }
    in
        fmapConfig fn config


{-| Add classes to the arrow svg icon

    Dropdown.withArrowSvgClass "arrow" config

-}
withArrowSvgClass : String -> Config msg item -> Config msg item
withArrowSvgClass classes config =
    let
        fn c =
            { c | arrowSvgClass = classes }
    in
        fmapConfig fn config


{-| Show or hide the clear (x) button, default is true

    Dropdown.withClear False config

-}
withClear : Bool -> Config msg item -> Config msg item
withClear bool config =
    let
        fn c =
            { c | hasClear = bool }
    in
        fmapConfig fn config


{-| Add classes to the clear button wrapper

    Dropdown.withClearClass "clear" config

-}
withClearClass : String -> Config msg item -> Config msg item
withClearClass classes config =
    let
        fn c =
            { c | clearClass = classes }
    in
        fmapConfig fn config


{-| Add styles to the clear button wrapper

    Dropdown.withClearStyles [("color", "red")] config

-}
withClearStyles : List ( String, String ) -> Config msg item -> Config msg item
withClearStyles styles config =
    let
        fn c =
            { c | clearStyles = styles }
    in
        fmapConfig fn config


{-| Add classes to the clear icon

    Dropdown.withClearSvgClass "clear" config

-}
withClearSvgClass : String -> Config msg item -> Config msg item
withClearSvgClass classes config =
    let
        fn c =
            { c | clearSvgClass = classes }
    in
        fmapConfig fn config


{-| Add classes to the items in the list

    Dropdown.withItemClass "bg-white" config

-}
withItemClass : String -> Config msg item -> Config msg item
withItemClass classes config =
    let
        fn c =
            { c | itemClass = classes }
    in
        fmapConfig fn config


{-| Add styles to the items in the list

    Dropdown.withInputStyles [("color", "red")] config

-}
withItemStyles : List ( String, String ) -> Config msg item -> Config msg item
withItemStyles styles config =
    let
        fn c =
            { c | itemStyles = styles }
    in
        fmapConfig fn config


{-| Add classes to the menu (list of items)

    Dropdown.withMenuClass "bg-white" config

-}
withMenuClass : String -> Config msg item -> Config msg item
withMenuClass classes config =
    let
        fn c =
            { c | menuClass = classes }
    in
        fmapConfig fn config


{-| Add styles to menu

    Dropdown.withMenuStyles [("color", "red")] config

-}
withMenuStyles : List ( String, String ) -> Config msg item -> Config msg item
withMenuStyles styles config =
    let
        fn c =
            { c | menuStyles = styles }
    in
        fmapConfig fn config


{-| Add classes to the prompt text (When no item is selected)

    Dropdown.withPromptClass "prompt" config

-}
withPromptClass : String -> Config msg item -> Config msg item
withPromptClass classes config =
    let
        fn c =
            { c | promptClass = classes }
    in
        fmapConfig fn config


{-| Add a prompt text to be displayed when no element is selected

    Dropdown.withPrompt "Select a movie" config

-}
withPrompt : String -> Config msg item -> Config msg item
withPrompt prompt config =
    let
        fn c =
            { c | prompt = prompt }
    in
        fmapConfig fn config


{-| Add styles to prompt text

    Dropdown.withPromptStyles [("color", "red")] config

-}
withPromptStyles : List ( String, String ) -> Config msg item -> Config msg item
withPromptStyles styles config =
    let
        fn c =
            { c | promptStyles = styles }
    in
        fmapConfig fn config


{-| Add classes to currently selected item in the menu

    Dropdown.withSelectedClass "bg-white" config

-}
withSelectedClass : String -> Config msg item -> Config msg item
withSelectedClass classes config =
    let
        fn c =
            { c | selectedClass = classes }
    in
        fmapConfig fn config


{-| Add classes to trigger element

    Dropdown.withTriggerClass "bg-white" config

-}
withTriggerClass : String -> Config msg item -> Config msg item
withTriggerClass classes config =
    let
        fn c =
            { c | triggerClass = classes }
    in
        fmapConfig fn config


{-| Add styles to trigger element

    Dropdown.withTriggerStyles [("width", "100px")] config

-}
withTriggerStyles : List ( String, String ) -> Config msg item -> Config msg item
withTriggerStyles styles config =
    let
        fn c =
            { c | triggerStyles = styles }
    in
        fmapConfig fn config


{-| Add styles to currently selected item in the menu

    Dropdown.withSelectedStyles [("color", "red")] config

-}
withSelectedStyles : List ( String, String ) -> Config msg item -> Config msg item
withSelectedStyles styles config =
    let
        fn c =
            { c | selectedStyles = styles }
    in
        fmapConfig fn config


{-| @priv
-}
fmapConfig : (Models.Config msg item -> Models.Config msg item) -> Config msg item -> Config msg item
fmapConfig fn config =
    let
        config_ =
            unwrapConfig config
    in
        PrivateConfig (fn config_)


{-| Create a new state. You must pass a unique identifier for each select component.

    {
        ...
        dropdownState = Dropdown.newState "dropdown1"
    }

-}
newState : String -> State
newState id =
    PrivateState (Models.newState id)


{-| Render the view

    Html.map DropdownMsg (Dropdown.view dropdownConfig model.dropdownState model.items selectedItem)

-}
view : Config msg item -> State -> List item -> Maybe item -> Html (Msg item)
view config model items selected =
    let
        config_ =
            unwrapConfig config

        model_ =
            unwrapState model
    in
        Html.map PrivateMsg (View.view config_ model_ items selected)


{-| Update the component state

    DropdownMsg subMsg ->
        let
            ( updated, cmd ) =
                Dropdown.update dropdownConfig subMsg model.dropdownState
        in
            ( { model | dropdownState = updated }, cmd )

-}
update : Config msg item -> Msg item -> State -> ( State, Cmd msg )
update config msg model =
    let
        config_ =
            unwrapConfig config

        msg_ =
            unwrapMsg msg

        model_ =
            unwrapState model
    in
        let
            ( mdl, cmd ) =
                Update.update config_ msg_ model_
        in
            ( PrivateState mdl, cmd )


{-| @priv
-}
unwrapConfig : Config msg item -> Models.Config msg item
unwrapConfig (PrivateConfig config) =
    config


{-| @priv
-}
unwrapMsg : Msg item -> Messages.Msg item
unwrapMsg (PrivateMsg msg) =
    msg


{-| @priv
-}
unwrapState : State -> Models.State
unwrapState (PrivateState state) =
    state
