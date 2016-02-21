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
newtype Coordinates
```


Coordinates is the datatype of the coordinates of a position.
The geographic coordinate reference system used by the attributes in this
interface is the World Geodetic System (2d).

#### `Position`

``` purescript
newtype Position
```


Postion is the container for the geolocation information returned by this
API.

#### `PositionError`

``` purescript
newtype PositionError
```


PositionError is the datatype of the error which might be returned by
getCurrentPosition() and watchPosition().

#### `PositionOptions`

``` purescript
newtype PositionOptions
```


PositionOptions is the data type of the options for getCurrentPosition() and
watchPosition().


