# COMPLETIONS = require('../completions.json')

module.exports =
  selector: '.source.eu4'
#  disableForSelector: 'source.eu4 .comment'
#  keywords: COMPLETIONS.keywords
#  filterSuggestions: true

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    console.log('LOG')
    suggestion =
      text: 'someText'
    [suggestion]

#    completions = []
#    if prefix
#      for keyword in @keywords when firstCharsEqual(keyword, prefix)
#        completion =
#          text: keyword
#        completions.push(completion)
#    completions
