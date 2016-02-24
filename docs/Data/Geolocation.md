## Module Data.Geolocation

#### `Geolocation`

``` purescript
class Geolocation g where
  getCurrentPosition :: forall eff. g -> (Position -> Eff (location :: LOCATION | eff) Unit) -> (PositionError -> Eff (location :: LOCATION | eff) Unit) -> PositionOptions -> Eff (location :: LOCATION | eff) Unit
  watchPosition :: forall eff. g -> (Position -> Eff (location :: LOCATION | eff) Unit) -> (PositionError -> Eff (location :: LOCATION | eff) Unit) -> PositionOptions -> Eff (location :: LOCATION | eff) Int
  clearWatch :: forall eff. g -> Int -> Eff (location :: LOCATION | eff) Unit
```


The Geolocation object is used by scripts to programmatically determine the
location information associated with the hosting device.

#### `LOCATION`

``` purescript
data LOCATION :: !
```


The effect type of the location side effect.

#### `Coordinates`

``` purescript
type Coordinates = { latitude :: Number, longitude :: Number, altitude :: Maybe Number, accuracy :: Number, altitudeAccuracy :: Maybe Number, heading :: Maybe Number, speed :: Maybe Number }
```


Coordinates is the datatype of the coordinates of a position.
The geographic coordinate reference system used by the attributes in this
interface is the World Geodetic System (2d).

#### `Position`

``` purescript
type Position = { coords :: Coordinates, timestamp :: Date }
```


Postion is the container for the geolocation information returned by this
API.

#### `PositionError`

``` purescript
type PositionError = { code :: Int, message :: String }
```


PositionError is the datatype of the error which might be returned by
getCurrentPosition() and watchPosition().

#### `PositionOptions`

``` purescript
type PositionOptions = { enableHighAccuracy :: Boolean, timeout :: Int, maximumAge :: Int }
```


PositionOptions is the data type of the options for getCurrentPosition() and
watchPosition().

#### `defaultOptions`

``` purescript
defaultOptions :: PositionOptions
```


defaultOptions is an PositionOptions object with the defaults.


