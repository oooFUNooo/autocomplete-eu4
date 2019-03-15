GENERAL   = require('../dictionary/general.json')
EFFECT    = require('../dictionary/effect.json')
CONDITION = require('../dictionary/condition.json')
MODIFIER  = require('../dictionary/modifier.json')

module.exports =
  selector: '.source.eu4'
  disableForSelector: '.source.eu4 .comment'
  keyword_general  : GENERAL
  keyword_effect   : EFFECT
  keyword_condition: CONDITION
  keyword_modifier : MODIFIER
  filterSuggestions: true

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    completions = []
    completions = @createSuggestions(prefix, completions, GENERAL  , 'EU4 keyword: General'   )
    completions = @createSuggestions(prefix, completions, EFFECT   , 'EU4 keyword: Effect'    )
    completions = @createSuggestions(prefix, completions, CONDITION, 'EU4 keyword: Condition' )
    completions = @createSuggestions(prefix, completions, MODIFIER , 'EU4 keyword: Modifier'  )
    completions

  createSuggestions: (prefix, completions, keywords, description) ->

    if prefix

      for keyword in keywords.keyword_simple  when keyword and firstCharsEqual(keyword, prefix)
        completion =
          displayText: keyword
          text: keyword
          type: 'keyword'
          description: description
        completions.push(completion)

      for keyword in keywords.keyword_equal   when keyword and firstCharsEqual(keyword, prefix)
        completion =
          displayText: keyword
          text: keyword + ' = '
          type: 'keyword'
          description: description
        completions.push(completion)

      for keyword in keywords.keyword_bracket when keyword and firstCharsEqual(keyword, prefix)
        completion =
          displayText: keyword + ' (single)'
          snippet: keyword + ' = { $1 }'
          type: 'keyword'
          description: description
        completions.push(completion)
        completion =
          displayText: keyword + ' (multi)'
          snippet: keyword + ' = {\n\t$1\n}'
          type: 'keyword'
          description: description
        completions.push(completion)

    completions

firstCharsEqual = (str1, str2) ->
  str1[0].toLowerCase() is str2[0].toLowerCase()
