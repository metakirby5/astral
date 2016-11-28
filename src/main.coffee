# The entry point. You shouldn't touch this.

# Load vendor and global CSS.
require 'skeleton/css/normalize.css'
require 'skeleton/css/skeleton.css'
require './style'

{AppContainer} = require 'react-hot-loader'
{createElement} = require 'react'
{render} = require 'react-dom'

# Render the root element.
root = document.getElementById 'react-root'
start = (app) ->
  render (createElement AppContainer, null, createElement app), root
start require './Root'

if module.hot
  module.hot.accept './Root', -> start require './Root'
