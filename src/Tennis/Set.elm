module Tennis.Set exposing (Set(..), Status(..), run)

import Player exposing (Player(..))
import Tennis.Game as Game exposing (..)


type Status
    = Playing Set
    | Won ( Int, Int )


type Set
    = Set ( Int, Int ) Game
    | TieBreak ( Int, Int )


update : Set -> Player -> Status
update set player =
    case ( set, player ) of
        ( Set ( a, b ) game, p ) ->
            case Game.update game p of
                Game.Playing g ->
                    Playing (Set ( a, b ) g)

                Game.Won A ->
                    handleNewGame ( a + 1, b )

                Game.Won B ->
                    handleNewGame ( a, b + 1 )

        ( TieBreak ( a, b ), A ) ->
            handleTieBreak ( a + 1, b )

        ( TieBreak ( a, b ), B ) ->
            handleTieBreak ( a, b + 1 )


handleNewGame : ( Int, Int ) -> Status
handleNewGame ( a, b ) =
    if ( a, b ) == ( 6, 6 ) then
        Playing (TieBreak ( 0, 0 ))

    else if abs (a - b) >= 2 && (a >= 6 || b >= 6) then
        Won ( a, b )

    else
        Playing (Set ( a, b ) Game.initial)


handleTieBreak : ( Int, Int ) -> Status
handleTieBreak ( a, b ) =
    if a >= 7 && a - b >= 2 then
        Won ( 7, 6 )

    else if b >= 7 && b - a >= 2 then
        Won ( 6, 7 )

    else
        Playing (TieBreak ( a, b ))


run : List Player -> Status
run shots =
    List.foldl increment (Playing (Set ( 0, 0 ) Game.initial)) shots


increment : Player -> Status -> Status
increment player status =
    case status of
        Playing set ->
            update set player

        Won score ->
            Won score
