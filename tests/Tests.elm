module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import World


all : Test
all =
    describe "Conway's Game of Life"
        [ test "a new world is empty" <|
            (\() ->
                World.init
                    |> World.isEmpty
                    |> Expect.true "Expected the world to be empty"
            )
        , test "a cell can be added to the world" <|
            (\() ->
                World.init
                    |> World.setLivingAt ( 1, 1 )
                    |> World.isAliveAt ( 1, 1 )
                    |> Expect.true "Expected the world to have an alive cell at (1, 1)"
            )
        , test "after adding a cell, the world is not empty" <|
            (\() ->
                World.init
                    |> World.setLivingAt ( 1, 1 )
                    |> World.isEmpty
                    |> Expect.false "Expected the world to not be empty"
            )
        , test "an empty world stays empty after a tick" <|
            (\() ->
                World.init
                    |> World.tick
                    |> World.isEmpty
                    |> Expect.true "Expected the world to be empty"
            )
        ]
