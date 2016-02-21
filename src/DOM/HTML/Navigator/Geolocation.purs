module DOM.HTML.Navigator.Geolocation (
    NavigatorGeolocation, geolocation
) where

import Control.Monad.Eff (Eff)
import Data.Geolocation (
    class Geolocation, LOCATION, Position, PositionError, PositionOptions
)
import Data.Maybe (Maybe)
import DOM (DOM)
import DOM.HTML.Types (Navigator)
import Prelude (Unit)

{-|
  | fGetCurrentPosition is the foreign interface for
  | navigator.GetCurrentPosition
-}
foreign import fGetCurrentPosition :: forall eff. NavigatorGeolocation -> (
                                           Position ->
                                           Eff (location :: LOCATION | eff) Unit
                                        ) -> (
                                           PositionError ->
                                           Eff (location :: LOCATION | eff) Unit
                                        ) -> PositionOptions -> 
                                        Eff (location :: LOCATION | eff) Unit

{-|
  | fWatchPosition is the foreign interface for navigator.watchPosition
-}
foreign import fWatchPosition :: forall eff. NavigatorGeolocation -> (
                                       Position ->
                                       Eff (location :: LOCATION | eff) Unit
                                   ) -> (
                                       PositionError ->
                                       Eff (location :: LOCATION | eff) Unit
                                   ) -> PositionOptions ->
                                   Eff (location :: LOCATION | eff) Int

{-|
  | fClearWatch is the foreign interface for navigator.clearWatch
-}
foreign import fClearWatch :: forall eff. NavigatorGeolocation -> Int ->
                                Eff (location :: LOCATION | eff) Unit

{-|
  | geolocation returns a geolocation object if the current browser supports
  | the Geolocation API
-}
foreign import geolocation :: forall eff. Navigator ->
                                Eff (dom :: DOM | eff)
                                    (Maybe NavigatorGeolocation)

{-|
  | NavigatorGeolocation is a dummy type for the geolocation object. It can
  | implement the 'proper' Geolocation Class
-}
foreign import data NavigatorGeolocation :: *

{-|
  | navigatorGeolocation is an instance of Geolocation.
-}
instance navigatorGeolocation :: Geolocation NavigatorGeolocation where
    getCurrentPosition = fGetCurrentPosition
    watchPosition = fWatchPosition
    clearWatch = fClearWatch
