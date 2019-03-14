# COMPLETIONS = require('../completions.json')

provider =

  selector: 'source.eu4'
#  disableForSelector: 'source.eu4 .comment'
#  keywords: COMPLETIONS.keywords
  filterSuggestions: true

  getSuggestions: ({prefix}) ->
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

module.exports =
  activate: ->
  provide: -> @provider
