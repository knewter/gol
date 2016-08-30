module GraphicsMain exposing (..)

import Html.App as App
import Html exposing (Html)
import World exposing (Model)
import Array exposing (Array)
import Time exposing (Time)
import Collage
import Element exposing (Element, flow, right, down, toHtml)
import Color exposing (greyscale)


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
    List.map viewRow (Array.toList model)
        |> flow down
        |> Element.toHtml


viewRow : Array Bool -> Element
viewRow row =
    List.map viewCell (Array.toList row)
        |> flow right


viewCell : Bool -> Element
viewCell cell =
    let
        color =
            case cell of
                True ->
                    greyscale 1.0

                False ->
                    greyscale 0.2
    in
        Element.empty
            |> Element.size 10 10
            |> Element.color color


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (Time.millisecond * 30) Tick


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
