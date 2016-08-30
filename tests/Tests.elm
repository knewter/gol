module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import World


all : Test
all =
    describe "Conway's Game of Life"
        [ test "a new world is empty" <|
            always <|
                Expect.equal 0 (World.livingCellsCount World.init)
        ]
