COMPLETIONS = require('../completions.json')

module.exports =
  selector: '.source.eu4'
  disableForSelector: '.source.eu4 .comment'
  keyword_simple : COMPLETIONS.keyword_simple
  keyword_equal  : COMPLETIONS.keyword_equal
  keyword_bracket: COMPLETIONS.keyword_bracket
  filterSuggestions: true

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    completions = []
    if prefix
      for keyword in @keyword_simple  when keyword and firstCharsEqual(keyword, prefix)
        completion =
          displayText: keyword
          text: keyword
          type: 'keyword'
        completions.push(completion)

      for keyword in @keyword_equal   when keyword and firstCharsEqual(keyword, prefix)
        completion =
          displayText: keyword
          text: keyword + ' = '
          type: 'keyword'
        completions.push(completion)

      for keyword in @keyword_bracket when keyword and firstCharsEqual(keyword, prefix)
        completion =
          displayText: keyword
          snippet: keyword + ' = {$1}'
          type: 'keyword'
        completions.push(completion)

    completions

firstCharsEqual = (str1, str2) ->
  str1[0].toLowerCase() is str2[0].toLowerCase()
