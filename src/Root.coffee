# The base element of your app. Can be a router if you like.

{Component, DOM, createElement: ce} = require 'react'
{div} = DOM
Spinner = require './components/Spinner'

# data = require 'json!yaml!./data.yaml'

# # Constants of Earth
# YEAR = 50000 # ms
# DIAMETER = 5 # m
# DISTANCE = 50 # m

module.exports = class extends Component
  render: ->
    div null,
      ce Spinner
