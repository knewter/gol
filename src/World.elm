module World exposing (init, isEmpty, setLivingAt, isAliveAt, tick)

import Array exposing (Array)


type alias Position =
    ( Int, Int )


type alias Model =
    Array (Array Bool)


init : Model
init =
    initialCells 10


tick : Model -> Model
tick model =
    model


arrayIsAllFalse : Array Bool -> Bool
arrayIsAllFalse array =
    array
        |> Array.foldl (\a b -> a || b) False
        |> not


isEmpty : Model -> Bool
isEmpty model =
    model
        |> Array.map (not << arrayIsAllFalse)
        |> arrayIsAllFalse


setLivingAt : Position -> Model -> Model
setLivingAt ( x, y ) model =
    let
        existingRow =
            Array.get x model
                |> Maybe.withDefault (Array.repeat (Array.length model) False)
    in
        model
            |> Array.set x
                (existingRow
                    |> Array.set y True
                )


isAliveAt : Position -> Model -> Bool
isAliveAt position model =
    True


initialCells : Int -> Array (Array Bool)
initialCells size =
    Array.repeat size (Array.repeat size False)
