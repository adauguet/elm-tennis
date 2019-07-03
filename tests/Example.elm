module Example exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Score exposing (Game(..), Player(..), Score(..), Set(..), run)
import Test exposing (..)


suite : Test
suite =
    describe "The Score module"
        [ describe "Score.run"
            [ test
                "[A, B, A, B, B, A, A]"
              <|
                \_ -> Expect.equal (Set ( 0, 0 ) (Advantage A)) (run [ A, B, A, B, B, A, A ])
            , test
                "[A, B, A, B, B, A, A, B, B, A, A, B, B, B, B, B, A, A, A, B, A, A, A]"
              <|
                let
                    shots =
                        [ A, B, A, B, B, A, A, B, B, A, A, B, B, B, B, B, A, A, A, B, A, A, A ]
                in
                \_ -> Expect.equal (Set ( 1, 1 ) (Scores Fifteen Zero)) (run shots)
            ]
        ]
