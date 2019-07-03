module Score exposing (Set(..), run)

import Game exposing (Game)
import Player exposing (Player(..))


type Set
    = Set ( Int, Int ) Game
    | Won ( Int, Int )
    | TieBreak ( Int, Int )
    | WonTieBreak ( Int, Int )


run : List Player -> Set
run shots =
    List.foldl increment (Set ( 0, 0 ) Game.initial) shots


foo : Set -> Player -> Set
foo set player =
    set


increment : Player -> Set -> Set
increment player set =
    set



-- increment : Player -> Set -> Set
-- increment player set =
--     case ( set, player ) of
--         ( Set games (Scores Zero any), A ) ->
--             Set games (Scores Fifteen any)
--         ( Set games (Scores Fifteen any), A ) ->
--             Set games (Scores Thirty any)
--         ( Set games (Scores Thirty any), A ) ->
--             Set games (Scores Forty any)
--         ( Set games (Scores any Zero), B ) ->
--             Set games (Scores any Fifteen)
--         ( Set games (Scores any Fifteen), B ) ->
--             Set games (Scores any Thirty)
--         ( Set games (Scores any Thirty), B ) ->
--             Set games (Scores any Forty)
--         ( Set games (Scores Forty Forty), _ ) ->
--             Set games (Advantage player)
--         ( Set ( 5, 6 ) (Scores Forty _), A ) ->
--             TieBreak ( 0, 0 )
--         ( Set ( 5, 6 ) (Advantage A), A ) ->
--             TieBreak ( 0, 0 )
--         ( Set ( 6, 5 ) (Scores _ Forty), B ) ->
--             TieBreak ( 0, 0 )
--         ( Set ( 6, 5 ) (Advantage B), B ) ->
--             TieBreak ( 0, 0 )
--         ( Set ( a, b ) (Scores Forty _), A ) ->
--             Set ( a + 1, b ) initialGame
--         ( Set ( a, b ) (Scores _ Forty), B ) ->
--             Set ( a, b + 1 ) initialGame
--         ( Set ( a, b ) (Advantage A), A ) ->
--             Set ( a + 1, b ) initialGame
--         ( Set ( a, b ) (Advantage B), B ) ->
--             Set ( a, b + 1 ) initialGame
--         ( Set games (Advantage A), B ) ->
--             Set games (Scores Forty Forty)
--         ( Set games (Advantage B), A ) ->
--             Set games (Scores Forty Forty)
--         ( TieBreak ( a, b ), A ) ->
--             if a >= 6 && a > b then
--                 WonTieBreak ( a + 1, b )
--             else
--                 TieBreak ( a + 1, b )
--         ( TieBreak ( a, b ), B ) ->
--             if b >= 6 && b > a then
--                 WonTieBreak ( a, b + 1 )
--             else
--                 TieBreak ( a, b + 1 )
--         ( Won score, _ ) ->
--             Won score
--         ( WonTieBreak score, _ ) ->
--             WonTieBreak score
