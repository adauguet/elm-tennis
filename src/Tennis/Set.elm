module Tennis.Set exposing (Score(..), Set(..), initial, update)

import Player exposing (Player(..))
import Tennis.Game as Game exposing (..)


type Set
    = Playing Score
    | Won ( Int, Int )


type Score
    = Games ( Int, Int ) Game.Score
    | TieBreak ( Int, Int )


initial : Score
initial =
    Games ( 0, 0 ) Game.initial


update : Score -> Player -> Set
update score player =
    case ( score, player ) of
        ( Games ( a, b ) game, p ) ->
            case Game.update game p of
                Game.Playing g ->
                    Playing (Games ( a, b ) g)

                Game.Won A ->
                    handleNewGame ( a + 1, b )

                Game.Won B ->
                    handleNewGame ( a, b + 1 )

        ( TieBreak ( a, b ), A ) ->
            handleClassicTieBreak ( a + 1, b )

        ( TieBreak ( a, b ), B ) ->
            handleClassicTieBreak ( a, b + 1 )


handleNewGame : ( Int, Int ) -> Set
handleNewGame ( a, b ) =
    if ( a, b ) == ( 6, 6 ) then
        Playing (TieBreak ( 0, 0 ))

    else if abs (a - b) >= 2 && (a >= 6 || b >= 6) then
        Won ( a, b )

    else
        Playing (Games ( a, b ) Game.initial)


handleSuperTieBreak : ( Int, Int ) -> Set
handleSuperTieBreak =
    handleTieBreakWithAtLeast 10


handleClassicTieBreak : ( Int, Int ) -> Set
handleClassicTieBreak =
    handleTieBreakWithAtLeast 7


handleTieBreakWithAtLeast : Int -> ( Int, Int ) -> Set
handleTieBreakWithAtLeast min ( a, b ) =
    if a >= min && a - b >= 2 then
        Won ( 7, 6 )

    else if b >= min && b - a >= 2 then
        Won ( 6, 7 )

    else
        Playing (TieBreak ( a, b ))
