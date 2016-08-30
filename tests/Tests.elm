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
        , test "without adding a cell to a position, that position is not living" <|
            (\() ->
                World.init
                    |> World.isAliveAt ( 1, 1 )
                    |> Expect.false "Expected the position to not be alive"
            )
        , test "an empty world stays empty after a tick" <|
            (\() ->
                World.init
                    |> World.tick
                    |> World.isEmpty
                    |> Expect.true "Expected the world to be empty"
            )
        , test "a dead cell with three live neighbors will be alive next generation" <|
            (\() ->
                World.init
                    |> World.setLivingAt ( 0, 1 )
                    |> World.setLivingAt ( 1, 1 )
                    |> World.setLivingAt ( 1, 0 )
                    |> World.cellAliveInNextGeneration ( 0, 0 )
                    |> Expect.true "Expected (0, 0) to be alive in the next generation"
            )
        , test "a dead cell with three live neighbors is alive after tick" <|
            (\() ->
                World.init
                    |> World.setLivingAt ( 0, 1 )
                    |> World.setLivingAt ( 1, 1 )
                    |> World.setLivingAt ( 1, 0 )
                    |> World.tick
                    |> World.isAliveAt ( 0, 0 )
                    |> Expect.true "Expected (0, 0) to be alive after tick"
            )
        ]
