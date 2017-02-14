module DOM.HTML.Navigator.Geolocation (
    NavigatorGeolocation, geolocation
) where

import Control.Monad.Aff (Aff, makeAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (error)
import DOM (DOM)
import DOM.HTML.Types (Navigator)
import Data.Date (Date)
import Data.Int (ceil)
import Data.Nullable (Nullable)
import Data.Tuple (Tuple(..))
import Global (infinity)
import Prelude (Unit)

-- | The effect type of the location side effect.
foreign import data LOCATION :: !

-- | The Geolocation API source provided by the browser.
foreign import data NavigatorGeolocation :: *

-- | A geolocation object if the current browser supports
-- | the Geolocation API; otherwise, null.
foreign import geolocation
  :: forall eff
  . Navigator
  -> Eff (dom :: DOM | eff) (Nullable NavigatorGeolocation)

-- | The FFI for the
-- | `geolocation.getCurrentPosition` function.
foreign import fGetCurrentPosition
  :: forall eff
  . PositionOptions
  ->
  ( Position
    -> Eff (location :: LOCATION | eff) Unit
  )
  ->
  ( PositionError
    -> Eff (location :: LOCATION | eff) Unit
  )
  -> NavigatorGeolocation
  -> Eff (location :: LOCATION | eff) Unit

-- | The PureScript interface to `navigator.getCurrentPosition`
getCurrentPositionAff
  :: forall eff
  .  PositionOptions
  -> NavigatorGeolocation
  -> Aff (location :: LOCATION | eff) Position
getCurrentPositionAff o g =
  makeAff \err success -> fGetCurrentPosition o success (\e -> err (error e.message)) g

-- | The FFI for `geolocation.watchPosition`
foreign import fWatchPosition
  :: forall a b eff
  . (a -> b -> Tuple a b)
  -> PositionOptions
  ->
  ( Tuple Position Int
    -> Eff (location :: LOCATION | eff) Unit
  )
  ->
  ( PositionError
    -> Eff (location :: LOCATION | eff) Unit
  )
  -> NavigatorGeolocation
  -> Eff (location :: LOCATION | eff) Unit

-- | The PureScript interface to `navigator.watchPosition`
watchPositionAff
  :: forall eff
  .  PositionOptions
  -> NavigatorGeolocation
  -> Aff (location :: LOCATION | eff) (Tuple Position Int)
watchPositionAff o g =
  makeAff \err success -> fWatchPosition Tuple o success (\e -> err (error e.message)) g

-- | The FFI for `geolocation.clearWatch`.
foreign import fClearWatch
  :: forall eff
  .  Int
  -> NavigatorGeolocation
  -> Eff (location :: LOCATION | eff) Unit

-- | Coordinates is the datatype of the coordinates of a position.
-- | The geographic coordinate reference system used by the attributes in this
-- | interface is the World Geodetic System (2d).
type Coordinates = {
    latitude         :: Number,
    longitude        :: Number,
    altitude         :: Nullable Number,
    accuracy         :: Number,
    altitudeAccuracy :: Nullable Number,
    heading          :: Nullable Number,
    speed            :: Nullable Number
}

-- | The container for the geolocation information returned by this
-- | API.
type Position = {
    coords    :: Coordinates,
    timestamp :: Date
}

-- | The error which might be returned by
-- | `getCurrentPosition` and `watchPosition`.
type PositionError = {
    code    :: Int,
    message :: String
}

-- | The options for `getCurrentPosition` and
-- | `watchPosition`.
type PositionOptions = {
    enableHighAccuracy :: Boolean,
    timeout            :: Int,
    maximumAge         :: Int
}

-- | A PositionOptions with reasonable default values.
defaultOptions :: PositionOptions
defaultOptions = {
    enableHighAccuracy: false,
    timeout           : ceil infinity,
    maximumAge        : 0
}

