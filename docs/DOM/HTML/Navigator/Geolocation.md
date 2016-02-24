## Module DOM.HTML.Navigator.Geolocation

#### `geolocation`

``` purescript
geolocation :: forall eff. Navigator -> Eff (dom :: DOM | eff) (Nullable NavigatorGeolocation)
```


geolocation returns a geolocation object if the current browser supports
the Geolocation API

#### `NavigatorGeolocation`

``` purescript
data NavigatorGeolocation :: *
```


NavigatorGeolocation is a dummy type for the geolocation object. It can
implement the 'proper' Geolocation Class

##### Instances
``` purescript
Geolocation NavigatorGeolocation
```


