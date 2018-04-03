-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/time.html

import Html exposing (Html, div)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, millisecond)



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model = Time


init : (Model, Cmd Msg)
init =
  (0, Cmd.none)



-- UPDATE


type Msg 
  = Tick Time
  | Reset


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ((model + 1), Cmd.none)
    Reset ->
      (0, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every millisecond Tick


-- VIEW


view : Model -> Html Msg
view model =
  let
    progress = toString (
      if model <= 5000 then
        model / 50
      else 
        0
  )
  in
    svg [ viewBox "0 0 120 120", width "500px" ]
      [ rect [x "10", y "10", width "100", height "6", rx "2", ry "2" ] []
      , rect [x "10", y "10", width progress, height "6", rx "2", ry "2", fill "#AAA"] []
      ]