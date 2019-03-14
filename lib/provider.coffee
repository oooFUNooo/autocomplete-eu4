COMPLETIONS = require('../completions.cson')

prefixPattern = /[a-zA-Z_]+$/

module.exports =

  selector: 'source.eu4'

  filterSuggestions: true

  getSuggestions: (request) ->
    completions = null
    completions = @getCompletions(request)
    completions

  getPrefix: (editor, bufferPosition) ->
    line = editor.getTextInRange([[bufferPosition.row, 0], bufferPosition])
    prefixPattern.exec(line)?[0]

  getCompletions: ({bufferPosition, editor, prefix}) ->
    completions = []
    if prefix
      for keyword in @keywords when firstCharsEqual(keyword, prefix)
        completions.push(@buildCompletion(keyword))
    completions

  buildCompletion: (keyword) ->
    type: 'keyword'
    text: keyword
    description: 'EU4 Keyword'
