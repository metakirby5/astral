# The entry point. You shouldn't touch this.

# Load vendor and global CSS.
require 'skeleton/css/normalize.css'
require 'skeleton/css/skeleton.css'
require './style'

# Load VR libs.
require 'aframe'
require 'aframe-animation-component'
require 'aframe-text-component'

{AppContainer} = require 'react-hot-loader'
{createElement: ce} = require 'react'
{render} = require 'react-dom'

# Render the root element.
root = document.getElementById 'react-root'
start = (app) -> render (ce AppContainer, null, ce app), root
start require './Root'

if module.hot
  module.hot.accept './Root', -> start require './Root'
