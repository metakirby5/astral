require './style'

{Component, DOM} = require 'react'
{div} = DOM

module.exports = class extends Component
  render: ->
    div className: 'fullscreen splash',
      div className: 'spinner'
      @props.msg
