require './style'

{Component, createElement: ce} = require 'react'
{Entity} = require 'aframe-react'

# Constants of Earth
YEAR = 20000 # ms
RADIUS = 5 # m
DISTANCE = 50 # m

# Misc. constants
MIN_DIST = 50
MAX_TILT = 10

module.exports = class extends Component
  render: ->
    xr = Math.random() * MAX_TILT
    yr = Math.random() * 360
    zr = Math.random() * MAX_TILT
    radius = RADIUS * @props.radius
    ce Entity,
      rotation: [xr, yr, zr]
      animation:
        property: 'rotation'
        to: [xr, 360 + yr, zr].join ' '
        easing: 'linear'
        loop: true
        dur: YEAR * @props.period
      ce Entity,
        primitive: 'a-sphere'
        position: [0, 0, MIN_DIST + DISTANCE * @props.distance]
        geometry:
          radius: radius
        material:
          color: @props.color
