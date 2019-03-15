GENERAL   = require('../dictionary/general.json')
EFFECT    = require('../dictionary/effect.json')
CONDITION = require('../dictionary/condition.json')
MODIFIER  = require('../dictionary/modifier.json')
TEST      = require('../dictionary/test.json')

module.exports =
  selector: '.source.eu4'
  disableForSelector: '.source.eu4 .comment'
  filterSuggestions: true

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    completions = []
    completions = @createSuggestions(prefix, completions, GENERAL  , 'EU4 keyword: General'  , '' )
    completions = @createSuggestions(prefix, completions, EFFECT   , 'EU4 keyword: Effect'   , 'https://eu4.paradoxwikis.com/Commands' )
    completions = @createSuggestions(prefix, completions, CONDITION, 'EU4 keyword: Condition', 'https://eu4.paradoxwikis.com/Conditions' )
    completions = @createSuggestions(prefix, completions, MODIFIER , 'EU4 keyword: Modifier' , 'https://eu4.paradoxwikis.com/Modifier_list' )
    completions = @createSuggestionsFromDictionary(prefix, completions, TEST)
    completions

  createSuggestions: (prefix, completions, keywords, description, url) ->

    if prefix

      for keyword in keywords.keyword_simple  when keyword and firstCharsEqual(keyword, prefix)
        completion =
          displayText: keyword
          text: keyword
          type: 'keyword'
          description: description
          descriptionMoreURL: url
        completions.push(completion)

      for keyword in keywords.keyword_equal   when keyword and firstCharsEqual(keyword, prefix)
        completion =
          displayText: keyword
          text: keyword + ' = '
          type: 'keyword'
          description: description
          descriptionMoreURL: url
        completions.push(completion)

      for keyword in keywords.keyword_bracket when keyword and firstCharsEqual(keyword, prefix)
        completion =
          displayText: keyword + ' (single)'
          snippet: keyword + ' = { $1 }'
          type: 'keyword'
          description: description
          descriptionMoreURL: url
        completions.push(completion)
        completion =
          displayText: keyword + ' (multi)'
          snippet: keyword + ' = {\n\t$1\n}'
          type: 'keyword'
          description: description
          descriptionMoreURL: url
        completions.push(completion)

    completions

  createSuggestionsFromDictionary: (prefix, completions, dictionary) ->

    if prefix

      for index, entry of dictionary when entry.keyword and firstCharsEqual(entry.keyword, prefix)
        completion =
          displayText: entry.keyword
          text: entry.keyword
          type: 'keyword'
          description: entry.description
          descriptionMoreURL: 'https://ck2.paradoxwikis.com/Conditions'
        completions.push(completion)

    completions

firstCharsEqual = (str1, str2) ->
  str1[0].toLowerCase() is str2[0].toLowerCase()
