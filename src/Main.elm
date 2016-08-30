module Main exposing (..)

import Html.App as App
import Html exposing (Html, table, tr, td, text)
import Html.Attributes exposing (style)
import World exposing (Model)
import Array exposing (Array)
import Time exposing (Time)


type Msg
    = Tick Time


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( World.tick model
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    table [] <|
        List.map viewRow (Array.toList model)


viewRow : Array Bool -> Html Msg
viewRow row =
    tr [] <|
        List.map viewCell (Array.toList row)


viewCell : Bool -> Html Msg
viewCell cell =
    let
        color =
            case cell of
                True ->
                    "black"

                False ->
                    "#ccc"
    in
        td [ style [ ( "width", "10px" ), ( "height", "10px" ), ( "background-color", color ) ] ] []


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (Time.millisecond * 200) Tick


init : ( Model, Cmd Msg )
init =
    ( World.init
        |> World.setLivingAt ( 1, 1 )
        |> World.setLivingAt ( 2, 2 )
        |> World.setLivingAt ( 3, 0 )
        |> World.setLivingAt ( 3, 1 )
        |> World.setLivingAt ( 3, 2 )
    , Cmd.none
    )
