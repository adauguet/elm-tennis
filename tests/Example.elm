module Example exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Player exposing (Player(..))
import Tennis.Game as Game exposing (Game(..), Score(..))
import Tennis.Set as Set exposing (Score(..), Set(..), run)
import Test exposing (..)


suite : Test
suite =
    describe "The Score module"
        [ test
            "0/0 advantage A"
          <|
            \_ -> Expect.equal (Set.Playing (Games ( 0, 0 ) (Advantage A))) (run [ A, B, A, B, B, A, A ])
        , test
            "TieBreak 6/3"
          <|
            \_ -> Expect.equal (Set.Playing (TieBreak ( 6, 3 ))) (run [ A, A, A, A, B, B, B, B, A, A, A, A, B, B, B, B, A, A, A, A, B, B, B, B, A, A, A, A, B, B, B, B, A, A, A, A, B, B, B, B, A, A, A, A, B, B, B, B, B, B, B, A, A, A, A, A, A ])
        ]
