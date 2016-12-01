require './style'

{Component, createElement: ce} = require 'react'
{Entity} = require 'aframe-react'

# Earth constants
YEAR = 20000 # ms
DAY = YEAR / 2 # ms
RADIUS = 5 # m
DISTANCE = 50 # m

# Trail constants
TRAIL_COLOR = '#AAA'
TRAIL_THICKNESS = 0.0002 # coeff

# Label constants
LABEL_SIZE = 0.05 # coeff
LABEL_Y = 0.05 # coeff
LABEL_COLOR = 'white'

# Misc. constants
MIN_DIST = 50 # deg
MAX_TILT = 10 # deg

module.exports = class extends Component
  constructor: (props) ->
    super props
    @state =
      startpos: Math.random() * 360

  render: ->
    dist = MIN_DIST + DISTANCE * @props.orbit.distance
    radius = RADIUS * @props.radius
    ce Entity,  # Orbit axis
      rotation: [@props.orbit.inclination, @state.startpos, 0]
      ce Entity,  # Orbit rotation
        animation:
          property: 'rotation'
          to: '0 360 0'
          easing: 'linear'
          loop: true
          dur: YEAR * @props.orbit.period
        ce Entity,  # Trail
          primitive: 'a-torus'
          rotation: [90, 0, 0]
          geometry:
            radius: dist
            radiusTubular: TRAIL_THICKNESS * dist
          material:
            color: TRAIL_COLOR
        ce Entity,  # Planet position
          position: [0, 0, -dist]
          ce Entity,  # Rotation axis
            rotation: [@props.obliquity, 0, 0]
            ce Entity,  # Planet
              primitive: 'a-sphere'
              geometry:
                radius: radius
              material:
                color: @props.color
                src: "#asset-#{@props.name}"
              animation:
                property: 'rotation'
                to: '0 360 0'
                easing: 'linear'
                loop: true
                dur: DAY * @props.period
          ce Entity,  # Label
            position: [-radius, LABEL_Y * dist + radius, 0]
            text:
              text: @props.name
              size: LABEL_SIZE * dist
            material:
              color: LABEL_COLOR
