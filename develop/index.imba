import './index.styl'

# ISVG = require './images/symbol-icons.svg'

# console.log( process:env:NODE_ENV )

import 'imba-router'

Imba:HTML_ATTRS:hr = 'open'

import Application from './application'
# import Sketch as Header from './header'
# import Sketch as Main from './main'
# import Sketch as Footer from './footer'

Imba.mount <Application route="/:collection*/*:document*/*">

Imba.mount <header>

Imba.mount <main route="/:collection*/*:document*/*">
	<span> "guthub.com deploy"

Imba.mount <footer>
