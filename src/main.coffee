# Load vendor and global CSS.
require 'skeleton/css/normalize.css'
require 'skeleton/css/skeleton.css'
require './style'

$ = require 'jquery'
aframe = require 'aframe'
kframe = require 'kframe'

# Hide spinner on load
$('#assets').on 'loaded', ->
  $('#spinner').hide()
