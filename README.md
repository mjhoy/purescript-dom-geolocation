# purescript-geolocation
This is a purescript library to interact with the [Geolocation API](https://www.w3.org/TR/geolocation-API/).

### Example:
```purescript
import Control.Error.Util (hush)
import Control.Monad.Aff (attempt)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Exception (Error)
import Data.Geolocation (LOCATION, Position, PositionError, defaultOptions, getCurrentPosition)
import Data.Maybe (Maybe(..))
import Data.Nullable (toMaybe)
import Data.Traversable (sequence)
import DOM.HTML (window)
import DOM.HTML.Navigator.Geolocation (Position, defaultOptions, deviceGeolocation, geolocation, getCurrentPositionAff)
import DOM.HTML.Window (navigator)
import Prelude (Unit, (>>=), (++), ($), (<<<), bind, join, pure, show)

main = do
  deviceGeolocation :: Maybe NavigatorGeolocation <- liftEff $ window >>= navigator >>= geolocation >>= pure <<< toMaybe
  position :: Either Error (Maybe Position) <- attempt <<< sequence $ getCurrentPositionAff defaultOptions <$> deviceGeolocation
  let position' = join (hush position) :: Maybe Position
  ...
```
