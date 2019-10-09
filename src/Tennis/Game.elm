module Tennis.Game exposing (Game(..), Point(..), Score(..), initial, update)

import Player exposing (Player(..))


type Game
    = Playing Score
    | Won Player


type Score
    = Points ( Point, Point )
    | Advantage Player


type Point
    = Zero
    | Fifteen
    | Thirty
    | Forty


initial : Score
initial =
    Points ( Zero, Zero )


update : Score -> Player -> Game
update game player =
    case ( game, player ) of
        ( Points ( Zero, any ), A ) ->
            Playing (Points ( Fifteen, any ))

        ( Points ( Fifteen, any ), A ) ->
            Playing (Points ( Thirty, any ))

        ( Points ( Thirty, any ), A ) ->
            Playing (Points ( Forty, any ))

        ( Points ( any, Zero ), B ) ->
            Playing (Points ( any, Fifteen ))

        ( Points ( any, Fifteen ), B ) ->
            Playing (Points ( any, Thirty ))

        ( Points ( any, Thirty ), B ) ->
            Playing (Points ( any, Forty ))

        ( Advantage B, A ) ->
            Playing (Points ( Forty, Forty ))

        ( Advantage A, B ) ->
            Playing (Points ( Forty, Forty ))

        ( Points ( Forty, Forty ), A ) ->
            Playing (Advantage A)

        ( Points ( Forty, Forty ), B ) ->
            Playing (Advantage B)

        ( Points ( Forty, _ ), A ) ->
            Won A

        ( Advantage A, A ) ->
            Won A

        ( Points ( _, Forty ), B ) ->
            Won B

        ( Advantage B, B ) ->
            Won B
