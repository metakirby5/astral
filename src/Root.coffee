# The base element of your app. Can be a router if you like.

{Component, DOM, createElement: ce} = require 'react'
{div} = DOM

Splash = require './components/Splash'
SolarSystem = require './components/SolarSystem'

module.exports = class extends Component
  constructor: (props) ->
    super props
    @state =
      loaded: false

  render: ->
    div className: 'fullscreen',
      if not @state.loaded
        ce Splash, msg: [
          '(loading)', 'made with love for', 'Kyle Correia'
        ].map (s, i) ->
          div key: i, s
      ce SolarSystem,
        onLoaded: => @setState loaded: true
