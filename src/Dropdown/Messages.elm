module Dropdown.Messages exposing (..)


type Msg item
    = NoOp
    | OnBlur
    | OnClear
    | OnClickPrompt
    | OnEsc
    | OnSelect item
