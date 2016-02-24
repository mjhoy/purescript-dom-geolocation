module Data.Geolocation (
    class Geolocation, LOCATION, Coordinates, Position, PositionError,
    PositionOptions, clearWatch, defaultOptions, getCurrentPosition,
    watchPosition
) where

import Control.Monad.Eff (Eff)
import Data.Date (Date)
import Data.Int (ceil)
import Data.Maybe (Maybe)
import Global (infinity)
import Prelude (Unit)

{-|
  | The Geolocation object is used by scripts to programmatically determine the
  | location information associated with the hosting device.
-}
class Geolocation g where
    getCurrentPosition :: forall eff. g -> (
                                Position ->
                                Eff (location :: LOCATION | eff) Unit
                            ) -> (
                                PositionError ->
                                Eff (location :: LOCATION | eff) Unit
                            ) -> PositionOptions ->
                            Eff (location :: LOCATION | eff) Unit

    watchPosition :: forall eff. g -> (
                            Position ->
                            Eff (location :: LOCATION | eff) Unit
                        ) -> (
                            PositionError ->
                            Eff (location :: LOCATION | eff) Unit
                        ) -> PositionOptions ->
                         Eff (location :: LOCATION | eff) Int

    clearWatch :: forall eff. g -> Int -> Eff (location :: LOCATION | eff) Unit

{-|
  | The effect type of the location side effect.
-}
foreign import data LOCATION :: !

{-|
  | Coordinates is the datatype of the coordinates of a position.
  | The geographic coordinate reference system used by the attributes in this
  | interface is the World Geodetic System (2d).
-}
type Coordinates = {
    latitude         :: Number,
    longitude        :: Number,
    altitude         :: Maybe Number,
    accuracy         :: Number,
    altitudeAccuracy :: Maybe Number,
    heading          :: Maybe Number,
    speed            :: Maybe Number
}

{-|
  | Postion is the container for the geolocation information returned by this
  | API.
-}
type Position = {
    coords    :: Coordinates,
    timestamp :: Date
}

{-|
  | PositionError is the datatype of the error which might be returned by
  | getCurrentPosition() and watchPosition().
-}
type PositionError = {
    code    :: Int,
    message :: String
}

{-|
  | PositionOptions is the data type of the options for getCurrentPosition() and
  | watchPosition().
-}
type PositionOptions = {
    enableHighAccuracy :: Boolean,
    timeout            :: Int,
    maximumAge         :: Int
}

{-|
  | defaultOptions is an PositionOptions object with the defaults.
-}
defaultOptions :: PositionOptions
defaultOptions = {
    enableHighAccuracy: false,
    timeout           : ceil infinity,
    maximumAge        : 0
}
