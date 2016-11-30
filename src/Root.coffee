# The base element of your app. Can be a router if you like.

{Component, DOM, createElement: ce} = require 'react'
{div} = DOM

Spinner = require './components/Spinner'
Scene = require './components/Scene'

module.exports = class extends Component
  constructor: (props) ->
    super props
    @state =
      loaded: false

  render: ->
    div
      className: 'fullscreen'
      ce Spinner,
        loaded: @state.loaded
      ce Scene,
        onLoaded: => @setState loaded: true
