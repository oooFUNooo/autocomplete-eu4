COMPLETIONS = require('../completions.cson')

provider =

  selector: 'source.eu4'
  keywords: COMPLETIONS.keywords
  filterSuggestions: true

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    completions = []
    if prefix
      for keyword in @keywords when firstCharsEqual(keyword, prefix)
        completion =
          type: 'keyword'
          text: keyword
        completions.push(completion)
    completions
