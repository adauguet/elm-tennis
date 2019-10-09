module Tennis.Match exposing (Match)

import Player exposing (Player)
import Tennis.Set as Set


type Match
    = Playing (List ( Int, Int )) Set.Score
    | Won (List ( Int, Int ))


initial : Match
initial =
    Playing [] Set.initial


update : List ( Int, Int ) -> Set.Score -> Player -> Match
update sets score player =
    case Set.update score player of
        Set.Playing s ->
            Playing sets s

        Set.Won set ->
            let
                newSets =
                    List.append sets [ set ]
            in
            if isWon (computeScore newSets) then
                Won newSets

            else
                Playing newSets Set.initial


computeScore : List ( Int, Int ) -> ( Int, Int )
computeScore sets =
    sets
        |> List.partition (\( a, b ) -> a > b)
        |> Tuple.mapBoth List.length List.length


isWon : ( Int, Int ) -> Bool
isWon ( a, b ) =
    max a b > 3


run : List Player -> Match
run shots =
    List.foldl increment initial shots


increment : Player -> Match -> Match
increment player match =
    case match of
        Playing sets set ->
            update sets set player

        Won score ->
            Won score
