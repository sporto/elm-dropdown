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
        , withClearClass
        , withItemClass
        , withItemStyles
        , withMenuClass
        , withMenuStyles
        , withPromptClass
        , withSelectedStyles
        )

{-| Dropdown component

# Types
@docs Config, State, Msg

# Configuration
@docs newConfig

# Styling
@docs withArrowClass, withClearClass, withItemClass, withItemStyles, withMenuClass, withMenuStyles, withPromptClass, withSelectedStyles

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


{-|
Opaque type that holds the configuration
-}
type Config msg item
    = PrivateConfig (Models.Config msg item)


{-|
Opaque type that holds the current state
-}
type State
    = PrivateState Models.State


{-|
Opaque type for internal library messages
-}
type Msg item
    = PrivateMsg (Messages.Msg item)


{-|
Create a new configuration. This takes:

- A message to trigger when an item is selected
- A function to get a label to display from an item


    Dropdown.newConfig OnSelect .label
-}
newConfig : (item -> msg) -> (item -> String) -> Config msg item
newConfig onSelectMessage toLabel =
    PrivateConfig (Models.newConfig onSelectMessage toLabel)


{-|
Add classes to the arrow icon

    Dropdown.withArrowClass "arrow" config
-}
withArrowClass : String -> Config msg item -> Config msg item
withArrowClass classes config =
    let
        fn c =
            { c | arrowClass = classes }
    in
        fmapConfig fn config


{-|
Add classes to the clear icon

    Dropdown.withClearClass "clear" config
-}
withClearClass : String -> Config msg item -> Config msg item
withClearClass classes config =
    let
        fn c =
            { c | clearClass = classes }
    in
        fmapConfig fn config


{-|
Add classes to the items in the list

    Dropdown.withItemClass "bg-white" config
-}
withItemClass : String -> Config msg item -> Config msg item
withItemClass classes config =
    let
        fn c =
            { c | itemClass = classes }
    in
        fmapConfig fn config


{-|
Add styles to the items in the list

    Dropdown.withInputStyles [("color", "red")] config
-}
withItemStyles : List ( String, String ) -> Config msg item -> Config msg item
withItemStyles styles config =
    let
        fn c =
            { c | itemStyles = styles }
    in
        fmapConfig fn config


{-|
Add classes to the menu (list of items)

    Dropdown.withMenuClass "bg-white" config
-}
withMenuClass : String -> Config msg item -> Config msg item
withMenuClass classes config =
    let
        fn c =
            { c | menuClass = classes }
    in
        fmapConfig fn config


{-|
Add styles to menu

    Dropdown.withMenuStyles [("color", "red")] config
-}
withMenuStyles : List ( String, String ) -> Config msg item -> Config msg item
withMenuStyles styles config =
    let
        fn c =
            { c | menuStyles = styles }
    in
        fmapConfig fn config


{-|
Add classes to prompt text (The selected item)

    Dropdown.withPromptClass "bg-white" config
-}
withPromptClass : String -> Config msg item -> Config msg item
withPromptClass classes config =
    let
        fn c =
            { c | promptClass = classes }
    in
        fmapConfig fn config


{-|
Add classes to currently selected item in the menu

    Dropdown.withSelectedClass "bg-white" config
-}
withSelectedClass : String -> Config msg item -> Config msg item
withSelectedClass classes config =
    let
        fn c =
            { c | selectedClass = classes }
    in
        fmapConfig fn config


{-|
Add styles to currently selected item in the menu

    Dropdown.withSelectedStyles [("color", "red")] config
-}
withSelectedStyles : List ( String, String ) -> Config msg item -> Config msg item
withSelectedStyles styles config =
    let
        fn c =
            { c | selectedStyles = styles }
    in
        fmapConfig fn config


{-|
@priv
-}
fmapConfig : (Models.Config msg item -> Models.Config msg item) -> Config msg item -> Config msg item
fmapConfig fn config =
    let
        config_ =
            unwrapConfig config
    in
        PrivateConfig (fn config_)


{-|
Create a new state. You must pass a unique identifier for each select component.

    {
        ...
        dropdownState = Dropdown.newState "dropdown1"
    }
-}
newState : String -> State
newState id =
    PrivateState (Models.newState id)


{-|
Render the view

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


{-|
Update the component state

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


{-|
@priv
-}
unwrapConfig : Config msg item -> Models.Config msg item
unwrapConfig (PrivateConfig config) =
    config


{-|
@priv
-}
unwrapMsg : Msg item -> Messages.Msg item
unwrapMsg (PrivateMsg msg) =
    msg


{-|
@priv
-}
unwrapState : State -> Models.State
unwrapState (PrivateState state) =
    state
