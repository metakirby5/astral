require './style'

{Component, DOM, createElement: ce} = require 'react'
{Scene, Entity} = require 'aframe-react'
{img} = DOM

planets = require 'json!yaml!../../data/planets.yaml'
Planet = require '../Planet'

TIMEOUT = 30000

module.exports = class extends Component
  render: ->
    ce Scene, null,
      ce Entity,
        primitive: 'a-assets'
        timeout: TIMEOUT
        onLoaded: @props.onLoaded
        img  # Sky texture
          id: 'asset-sky'
          src: 'static/sky.jpg'
        planets.map (p) ->
          img  # Planet textures
            key: p.name
            id: "asset-#{p.name}"
            src: "static/planets/#{p.name}.jpg"
        planets.filter((p) -> p.rings?).map (p) ->
          img  # Ring textures
            id: "asset-#{p.name}-rings"
            src: "static/planets/#{p.name}-rings.png"
      ce Entity,
        poition: [0, 0, 0]
        ce Entity,
          primitive: 'a-camera'
      ce Entity,
        primitive: 'a-sky'
        material:
          src: '#asset-sky'
      planets.map (p) ->
        ce Planet, Object.assign {}, p,
          key: p.name
