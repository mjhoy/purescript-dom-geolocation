module Data.Geolocation (
    Coordinates(),
    Geolocation(),
    Position(),
    PositionError(),
    PositionOptions()
) where

import Data.Date (Date())
import Data.Maybe (Maybe())
import Prelude

{-|
  | The Geolocation object is used by scripts to programmatically determine the
  | location information associated with the hosting device.
-}
class Geolocation g where
    getCurrentPosition :: forall eff. g
                            (Position -> Eff (location :: LOCATION | eff) Unit)
                            (
                                PositionError
                                Eff (location :: LOCATION | eff) Unit
                            )
                            PositionOptions
                            Eff (location :: LOCATION | eff) Unit

    watchPosition      :: forall eff. g
                            (Position -> Eff (location :: LOCATION | eff) Unit)
                            (
                                PositionError
                                Eff (location :: LOCATION | eff) Unit
                            )
                            PositionOptions
                            Eff (location :: LOCATION | eff) Int

    clearWatch         :: forall eff. g -> Int
                            Eff (location :: LOCATION | eff) Unit

{-|
  | Coordinates is the datatype of the coordinates of a position.
  | The geographic coordinate reference system used by the attributes in this
  | interface is the World Geodetic System (2d).
-}
newtype Coordinates = Coordinates {
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
newtype Position = Position {
    coords    :: Coordinates,
    timestamp :: Date
}

{-|
  | PositionError is the datatype of the error which might be returned by
  | getCurrentPosition() and watchPosition().
-}
newtype PositionError = PositionError {
    code    :: Int,
    message :: String
}

{-|
  | PositionOptions is the data type of the options for getCurrentPosition() and
  | watchPosition().
-}
newtype PositionOptions = PositionOptions {
    enableHighAccuracy :: Boolean,
    timeout            :: Int,
    maximumAge         :: Int
}
