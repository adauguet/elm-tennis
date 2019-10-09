module Tennis.Tournament exposing (Tournament)

import Tennis.Game as Game
import Tennis.Set exposing (Score(..), Set(..))


type alias Tournament =
    { handleNewGame : ( Int, Int ) -> Set
    , handleTieBreak : ( Int, Int ) -> Set
    }


handleNewGameFinalSetRolandGarros : ( Int, Int ) -> Set
handleNewGameFinalSetRolandGarros ( a, b ) =
    if abs (a - b) >= 2 && (a >= 6 || b >= 6) then
        Won ( a, b )

    else
        Playing (Games ( a, b ) Game.initial)


handleNewGameFinalSetWimbledon : ( Int, Int ) -> Set
handleNewGameFinalSetWimbledon ( a, b ) =
    if ( a, b ) == ( 12, 12 ) then
        Playing (TieBreak ( 0, 0 ))

    else if abs (a - b) >= 2 && (a >= 6 || b >= 6) then
        Won ( a, b )

    else
        Playing (Games ( a, b ) Game.initial)
