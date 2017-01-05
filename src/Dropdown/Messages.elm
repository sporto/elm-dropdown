module Dropdown.Messages exposing (..)


type Msg item
    = NoOp
    | OnBlur
    | OnClickPrompt
    | OnEsc
    | OnSelect item
