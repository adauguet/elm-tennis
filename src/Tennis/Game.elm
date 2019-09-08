module Tennis.Game exposing (Game(..), Score(..), Status(..), initial, update)

import Player exposing (Player(..))


type Status
    = Playing Game
    | Won Player


type Game
    = Scores ( Score, Score )
    | Advantage Player


type Score
    = Zero
    | Fifteen
    | Thirty
    | Forty


initial : Game
initial =
    Scores ( Zero, Zero )


update : Game -> Player -> Status
update game player =
    case ( game, player ) of
        ( Scores ( Zero, any ), A ) ->
            Playing (Scores ( Fifteen, any ))

        ( Scores ( Fifteen, any ), A ) ->
            Playing (Scores ( Thirty, any ))

        ( Scores ( Thirty, any ), A ) ->
            Playing (Scores ( Forty, any ))

        ( Scores ( any, Zero ), B ) ->
            Playing (Scores ( any, Fifteen ))

        ( Scores ( any, Fifteen ), B ) ->
            Playing (Scores ( any, Thirty ))

        ( Scores ( any, Thirty ), B ) ->
            Playing (Scores ( any, Forty ))

        ( Advantage B, A ) ->
            Playing (Scores ( Forty, Forty ))

        ( Advantage A, B ) ->
            Playing (Scores ( Forty, Forty ))

        ( Scores ( Forty, Forty ), A ) ->
            Playing (Advantage A)

        ( Scores ( Forty, Forty ), B ) ->
            Playing (Advantage B)

        ( Scores ( Forty, _ ), A ) ->
            Won A

        ( Advantage A, A ) ->
            Won A

        ( Scores ( _, Forty ), B ) ->
            Won B

        ( Advantage B, B ) ->
            Won B
