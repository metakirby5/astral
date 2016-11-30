# Load vendor and global CSS.
require 'skeleton/css/normalize.css'
require 'skeleton/css/skeleton.css'
require './style'

$ = require 'jquery'
aframe = require 'aframe'
kframe = require 'kframe'

data = require 'json!yaml!./data.yaml'

# Constants of Earth
YEAR = 50000 # ms
DIAMETER = 5 # m
DISTANCE = 50 # m

# Selectors
$spinner = $ '#spinner'
$scene = $ 'scene'
$assets = $ '#assets'

# Hide spinner on load
$assets.on 'loaded', ->
  $spinner.hide()
