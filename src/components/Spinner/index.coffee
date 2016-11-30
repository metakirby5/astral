require './style'

{Component, DOM} = require 'react'
{div} = DOM

module.exports = class extends Component
  render: -> div (className: 'spinner' unless @props.loaded)
