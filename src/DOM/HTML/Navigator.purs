module DOM.HTML.Navigator where

import Data.Geolocation
import Data.Maybe (Maybe())
import DOM (DOM())
import DOM.HTML.Types (Navigator())

{-|
  | geolocation returns a geolocation object if the current browser supports
  | the Geolocation API
-}
foreign import geolocation :: forall eff. Navigator
                                Eff (dom :: DOM | eff) Maybe NavigatorGeolocation

{-|
  | NavigatorGeolocation is a dummy type for the geolocation object. It can
  | implement the 'proper' Geolocation Class
-}
foreign import data NavigatorGeolocation :: *

{-|
  | navigatorGeolocation is an instance of Geolocation.
-}
instance navigatorGeolocation :: Geolocation NavigatorGeolocation where
    getCurrentPosition = foreign import getCurrentPosition :: forall eff.
                                                                NavigatorGeolocation
                                                                (
                                                                    Position
                                                                    Eff (location :: LOCATION | eff) Unit
                                                                )
                                                                (
                                                                    PositionError
                                                                    Eff (location :: LOCATION | eff) Unit
                                                                )
                                                                Eff (location :: LOCATION | eff) Unit

    watchPosition = foreign import watchPosition :: forall eff.
                                                      NavigatorGeolocation
                                                      (
                                                          Position
                                                          Eff (location :: LOCATION | eff) Unit
                                                      )
                                                      (
                                                          PositionError
                                                          Eff (location :: LOCATION | eff) Unit
                                                      )
                                                      Eff (location :: LOCATION | eff) Int

    clearWatch = foreign import clearWatch :: forall eff. NavigatorGeolocation
                                                Int
                                                Eff (location :: LOCATION | eff) Unit
