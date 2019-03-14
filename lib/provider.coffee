COMPLETIONS = require('../completions.json')

module.exports =
  selector: '.source.eu4'
  disableForSelector: '.source.eu4 .comment'
  keywords: COMPLETIONS.keywords
  filterSuggestions: true

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    completions = []
    if prefix
      for keyword in @keywords when firstCharsEqual(keyword, prefix)
        completion =
          text: keyword
        completions.push(completion)
    completions

firstCharsEqual = (str1, str2) ->
  str1[0].toLowerCase() is str2[0].toLowerCase()
