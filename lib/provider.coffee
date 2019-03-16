GENERAL   = require('../dictionary/general.json')
EFFECT    = require('../dictionary/effect.json')
CONDITION = require('../dictionary/condition.json')
MODIFIER  = require('../dictionary/modifier.json')
SCOPE     = require('../dictionary/scope.json')
WIKIURL   = 'https://eu4.paradoxwikis.com/'

module.exports =
  selector: '.source.eu4'
  disableForSelector: '.source.eu4 .comment'
  filterSuggestions: true

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    completions = []
    completions = @createSuggestions(prefix, completions, GENERAL  , ''         , ''              )
    completions = @createSuggestions(prefix, completions, EFFECT   , 'effect'   , 'Commands'      )
    completions = @createSuggestions(prefix, completions, CONDITION, 'condition', 'Conditions'    )
    completions = @createSuggestions(prefix, completions, MODIFIER , 'modifier' , 'Modifier_list' )
    completions = @createSuggestions(prefix, completions, SCOPE    , 'scope'    , 'Scopes'        )
    completions

  createSuggestions: (prefix, completions, dictionary, label, url) ->

    if prefix

      for index, entry of dictionary.simple when entry.displayText and firstCharsEqual(entry.displayText, prefix)
        completion =
          text: entry.text
          displayText: entry.displayText
          type: 'snippet'
          rightLabel: label
          iconHTML: '<i class="icon-move-right"></i>'
          description: entry.description
          descriptionMoreURL: WIKIURL + url
        completions.push(completion)

      for index, entry of dictionary.equal when entry.displayText and firstCharsEqual(entry.displayText, prefix)
        completion =
          text: entry.text + ' = '
          displayText: entry.displayText
          type: 'snippet'
          rightLabel: label
          iconHTML: '<i class="icon-move-right"></i>'
          description: entry.description
          descriptionMoreURL: WIKIURL + url
        completions.push(completion)

      for index, entry of dictionary.bracket when entry.displayText and firstCharsEqual(entry.displayText, prefix)

        switch atom.config.get('autocomplete-eu4.bracket')

          when 0
            completion =
              snippet: entry.text + ' = { $1 }$2'
              displayText: entry.displayText
              type: 'snippet'
              leftLabel: 'single'
              rightLabel: label
              iconHTML: '<i class="icon-move-right"></i>'
              description: entry.description
              descriptionMoreURL: WIKIURL + url
            completions.push(completion)

            completion =
              snippet: entry.text + ' = {\n\t$1\n}'
              displayText: entry.displayText
              type: 'snippet'
              leftLabel: 'multi'
              rightLabel: label
              iconHTML: '<i class="icon-move-right"></i>'
              description: entry.description
              descriptionMoreURL: WIKIURL + url
            completions.push(completion)

          when 1
            completion =
              snippet: entry.text + ' = { $1 }$2'
              displayText: entry.displayText
              type: 'snippet'
              rightLabel: label
              iconHTML: '<i class="icon-move-right"></i>'
              description: entry.description
              descriptionMoreURL: WIKIURL + url
            completions.push(completion)

          when 2
            completion =
              snippet: entry.text + ' = {\n\t$1\n}'
              displayText: entry.displayText
              type: 'snippet'
              rightLabel: label
              iconHTML: '<i class="icon-move-right"></i>'
              description: entry.description
              descriptionMoreURL: WIKIURL + url
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
