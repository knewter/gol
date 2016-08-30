module World exposing (init, isEmpty, setLivingAt, isAliveAt, tick, cellAliveInNextGeneration)

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


cellAliveInNextGeneration : Position -> Model -> Bool
cellAliveInNextGeneration position model =
    case isAliveAt position model of
        True ->
            (2 == numberOfNeighbors position model)
                || (3 == numberOfNeighbors position model)

        False ->
            (3 == numberOfNeighbors position model)


neighbors : Position -> Model -> List Position
neighbors ( x, y ) model =
    [ ( x - 1, y - 1 )
    , ( x - 1, y )
    , ( x - 1, y + 1 )
    , ( x, y - 1 )
    , ( x, y + 1 )
    , ( x + 1, y - 1 )
    , ( x + 1, y )
    , ( x + 1, y + 1 )
    ]


numberOfNeighbors : Position -> Model -> Int
numberOfNeighbors position model =
    neighbors position model
        |> List.filter (\p -> isAliveAt p model)
        |> List.length


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
isAliveAt ( x, y ) model =
    case Array.get x model of
        Nothing ->
            False

        Just sub ->
            case Array.get y sub of
                Nothing ->
                    False

                Just val ->
                    val


initialCells : Int -> Array (Array Bool)
initialCells size =
    Array.repeat size (Array.repeat size False)
