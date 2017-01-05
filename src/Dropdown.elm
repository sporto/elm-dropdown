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
        , withItemClass
        , withItemStyles
        , withMenuClass
        , withMenuStyles
        , withPromptClass
        , withSelectedStyles
        )

import Dropdown.Messages as Messages
import Dropdown.Models as Models
import Dropdown.Update as Update
import Dropdown.View as View
import Html exposing (Html)


type Config msg item
    = PrivateConfig (Models.Config msg item)


type State
    = PrivateState Models.State


type Msg item
    = PrivateMsg (Messages.Msg item)


newConfig : (item -> msg) -> (item -> String) -> Config msg item
newConfig onSelectMessage toLabel =
    PrivateConfig (Models.newConfig onSelectMessage toLabel)


{-|
Class applied to the arrow svg
-}
withArrowClass : String -> Config msg item -> Config msg item
withArrowClass classes config =
    let
        fn c =
            { c | arrowClass = classes }
    in
        fmapConfig fn config


withItemClass : String -> Config msg item -> Config msg item
withItemClass classes config =
    let
        fn c =
            { c | itemClass = classes }
    in
        fmapConfig fn config


withItemStyles : List ( String, String ) -> Config msg item -> Config msg item
withItemStyles styles config =
    let
        fn c =
            { c | itemStyles = styles }
    in
        fmapConfig fn config


withMenuClass : String -> Config msg item -> Config msg item
withMenuClass classes config =
    let
        fn c =
            { c | menuClass = classes }
    in
        fmapConfig fn config


withMenuStyles : List ( String, String ) -> Config msg item -> Config msg item
withMenuStyles styles config =
    let
        fn c =
            { c | menuStyles = styles }
    in
        fmapConfig fn config


withPromptClass : String -> Config msg item -> Config msg item
withPromptClass classes config =
    let
        fn c =
            { c | promptClass = classes }
    in
        fmapConfig fn config


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


newState : String -> State
newState id =
    PrivateState (Models.newState id)


view : Config msg item -> State -> List item -> Maybe item -> Html (Msg item)
view config model items selected =
    let
        config_ =
            unwrapConfig config

        model_ =
            unwrapState model
    in
        Html.map PrivateMsg (View.view config_ model_ items selected)


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
