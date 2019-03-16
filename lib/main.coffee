provider = require './provider'

module.exports =

  config:

    bracket:
      title: 'Bracket insertion'
      description: 'Specify a way to insert brackets when a clause follows input.'
      type: 'integer'
      default: 0
      enum: [
        { value: 0, description: 'Select each time' }
        { value: 1, description: 'Single line only' }
        { value: 2, description: 'Multi lines only' }
      ]

    includedesc:
      title: 'Include descriptions'
      description: 'Specify whether word matching includes descriptions or not.'
      type: 'boolean'
      default: true
      enum: [
        { value: true , description: 'Include descriptions' }
        { value: false, description: 'Not include descriptions' }
      ]

  activate: ->
  provider: -> provider
