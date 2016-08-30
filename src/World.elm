module World exposing (init, livingCellsCount)


type alias Model =
    { cells : List Int
    }


init : Model
init =
    { cells = []
    }


livingCellsCount : Model -> Int
livingCellsCount model =
    0
