provider = require './provider'

module.exports =

  config:

    bracket:
      title: 'Bracket insertion mode'
      description: 'Specify a way to insert brackets when a clause follows input.'
      type: 'integer'
      default: 0
      enum: [
        { value: 0, description: 'Select each time' }
        { value: 1, description: 'Single line only' }
        { value: 2, description: 'Multi lines only' }
      ]

  activate: ->
  provider: -> provider
