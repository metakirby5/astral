# By convention, code goes in components/component_name/index.coffee.

require './style'

{createClass, DOM} = require 'react'
{div, input, ul, li, a} = DOM

# Lifted from http://gaearon.github.io/react-hot-loader/

BEST_JS_LIBS = [
  {name: 'Backbone.js', url: 'http://backbonejs.org/'},
  {name: 'AngularJS', url: 'https://angularjs.org/'},
  {name: 'jQuery', url: 'http://jquery.com/'},
  {name: 'Prototype', url: 'http://www.prototypejs.org/'},
  {name: 'React', url: 'http://facebook.github.io/react/'},
  {name: 'Ember', url: 'http://emberjs.com/'},
  {name: 'Knockout.js', url: 'http://knockoutjs.com/'},
  {name: 'Dojo', url: 'http://dojotoolkit.org/'},
  {name: 'Mootools', url: 'http://mootools.net/'},
  {name: 'Underscore', url: 'http://underscorejs.org/'},
  {name: 'Lodash', url: 'http://lodash.com/'},
  {name: 'Moment', url: 'http://momentjs.com/'},
  {name: 'Express', url: 'http://expressjs.com/'},
  {name: 'Koa', url: 'http://koajs.com/'}
]

module.exports = createClass
  getInitialState: ->
    query: ''

  handleChange: (e) ->
    @setState query: e.target.value

  render: ->
    libs = BEST_JS_LIBS
    query = @state.query.trim().toLowerCase()

    if query.length
      libs = libs.filter (lib) -> lib.name.toLowerCase().match query

    div
      className: 'example-container'
      div
        className: 'example-main'
        input
          type: 'text'
          value: @state.query
          onChange: @handleChange
          placeholder: 'Type to search'
        ul null,
          libs.map (lib) ->
            li
              key: lib.name
              a
                href: lib.url
                target: '_blank'
                lib.name
