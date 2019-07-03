module Game exposing (Game(..), initial, update)

import Player exposing (Player(..))


type Score
    = Zero
    | Fifteen
    | Thirty
    | Forty


type Game
    = Scores ( Score, Score )
    | Advantage Player
    | Won Player


initial : Game
initial =
    Scores ( Zero, Zero )


update : Game -> Player -> Game
update game player =
    case ( game, player ) of
        ( Scores ( Zero, any ), A ) ->
            Scores ( Fifteen, any )

        ( Scores ( Fifteen, any ), A ) ->
            Scores ( Thirty, any )

        ( Scores ( Thirty, any ), A ) ->
            Scores ( Forty, any )

        ( Scores ( any, Zero ), B ) ->
            Scores ( any, Fifteen )

        ( Scores ( any, Fifteen ), B ) ->
            Scores ( any, Thirty )

        ( Scores ( any, Thirty ), B ) ->
            Scores ( any, Forty )

        ( Advantage B, A ) ->
            Scores ( Forty, Forty )

        ( Advantage A, B ) ->
            Scores ( Forty, Forty )

        ( Scores ( Forty, Forty ), A ) ->
            Advantage A

        ( Scores ( Forty, Forty ), B ) ->
            Advantage A

        ( Scores ( Forty, _ ), A ) ->
            Won A

        ( Advantage A, A ) ->
            Won A

        ( Scores ( _, Forty ), B ) ->
            Won B

        ( Advantage B, B ) ->
            Won A

        ( Won p, _ ) ->
            Won p
