# The base element of your app. Can be a router if you like.

{Component, DOM, createElement: ce} = require 'react'
{div} = DOM

Spinner = require './components/Spinner'
SolarSystem = require './components/SolarSystem'

module.exports = class extends Component
  constructor: (props) ->
    super props
    @state =
      loaded: false

  render: ->
    div
      className: 'fullscreen'
      ce Spinner,
        visible: not @state.loaded
      ce SolarSystem,
        onLoaded: => @setState loaded: true
