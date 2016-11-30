require './style'

{Component, DOM, createElement: ce} = require 'react'
{Scene, Entity} = require 'aframe-react'
{img} = DOM

planets = require 'json!yaml!../../data/planets.yaml'
Planet = require '../Planet'

module.exports = class extends Component
  render: ->
    ce Scene, null,
      ce Entity,
        primitive: 'a-assets'
        onLoaded: @props.onLoaded
        img
          id: 'sky'
          src: 'static/sky.jpg'
      ce Entity,
        poition: [0, 0, 0]
        ce Entity,
          primitive: 'a-camera'
      ce Entity,
        primitive: 'a-sky'
        material:
          src: '#sky'
      planets.map (p, i) ->
        ce Planet, Object.assign p, key: i
