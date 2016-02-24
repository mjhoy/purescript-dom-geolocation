# purescript-geolocation
This is a purescript library to interact with the [Geolocation API](https://www.w3.org/TR/geolocation-API/).

### Example:
```purescript
import Control.Monad.Eff (Eff())  
import Control.Monad.Eff.Console (CONSOLE, log)  
import Data.Geolocation (LOCATION, Position, PositionError, defaultOptions, getCurrentPosition)
import Data.Maybe.Unsafe (fromJust)
import Data.Nullable (toMaybe) 
import DOM (DOM())
import DOM.HTML (window)                                                         
import DOM.HTML.Navigator.Geolocation (geolocation) 
import DOM.HTML.Window (navigator)
import Prelude (Unit, (>>=), (++), ($), bind, show)

callback :: forall eff. Position -> Eff (console :: CONSOLE | eff) Unit 
callback position = log $ show position.coords.latitude ++ ", "  ++ show position.coords.longitude

errorCallback :: forall eff. PositionError -> Eff (console :: CONSOLE | eff) Unit
errorCallback error = log error.message

main :: forall eff. Eff (console :: CONSOLE, dom :: DOM, location :: LOCATION | eff) Unit
main = do
  -- Get the 'geolocation' object from the navigator
  location <- window >>= navigator >>= geolocation  
  
  -- If the browser doesn't support geolocation, the object will be null
  let geo = fromJust $ toMaybe location
  
  -- 'callback' gets called on success, 'errorCallback' on error
  getCurrentPosition geo callback errorCallback defaultOptions 
```
