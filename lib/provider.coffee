GENERAL   = require('../dictionary/general.json')
EFFECT    = require('../dictionary/effect.json')
CONDITION = require('../dictionary/condition.json')
MODIFIER  = require('../dictionary/modifier.json')
SCOPE     = require('../dictionary/scope.json')
WIKIURL   = 'https://eu4.paradoxwikis.com/'

module.exports =
  selector: '.source.eu4'
  disableForSelector: '.source.eu4 .comment'
#  filterSuggestions: true

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    completions = []
    entries = []

    completions = @searchText(prefix, completions, GENERAL  , ''         , ''              )
    completions = @searchText(prefix, completions, EFFECT   , 'effect'   , 'Commands'      )
    completions = @searchText(prefix, completions, CONDITION, 'condition', 'Conditions'    )
    completions = @searchText(prefix, completions, MODIFIER , 'modifier' , 'Modifier_list' )
    completions = @searchText(prefix, completions, SCOPE    , 'scope'    , 'Scopes'        )

    completions.sort(@compareCompletions)

    completions = @searchDesc(prefix, completions, GENERAL  , ''         , ''              )
    completions = @searchDesc(prefix, completions, EFFECT   , 'effect'   , 'Commands'      )
    completions = @searchDesc(prefix, completions, CONDITION, 'condition', 'Conditions'    )
    completions = @searchDesc(prefix, completions, MODIFIER , 'modifier' , 'Modifier_list' )
    completions = @searchDesc(prefix, completions, SCOPE    , 'scope'    , 'Scopes'        )

    completions

  searchText: (prefix, completions, dictionary, label, url) ->

    if prefix
      regex = new RegExp(prefix, 'i')

      for index, entry of dictionary.simple when entry.displayText and regex.test(entry.displayText)
        completion =
          text: entry.text
          displayText: entry.displayText
          type: 'snippet'
          rightLabel: label
          iconHTML: '<i class="icon-move-right"></i>'
          description: entry.description
          descriptionMoreURL: WIKIURL + url
          pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
        completions.push(completion)

      for index, entry of dictionary.equal when entry.displayText and regex.test(entry.displayText)
        completion =
          text: entry.text + ' = '
          displayText: entry.displayText
          type: 'snippet'
          rightLabel: label
          iconHTML: '<i class="icon-move-right"></i>'
          description: entry.description
          descriptionMoreURL: WIKIURL + url
          pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
        completions.push(completion)

      for index, entry of dictionary.bracket when entry.displayText and regex.test(entry.displayText)

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
              pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
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
              pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
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
              pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
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
              pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
            completions.push(completion)

    completions

  searchDesc: (prefix, completions, dictionary, label, url) ->

    if prefix
      regex = new RegExp(prefix, 'i')

      for index, entry of dictionary.simple when entry.description and regex.test(entry.description)

        repeat = false
        for index2, entry2 of completions when entry.displayText is entry2.displayText
          repeat = true
          break

        if not repeat
          completion =
            text: entry.text
            displayText: entry.displayText
            type: 'class'
            rightLabel: label
            iconHTML: '<i class="icon-search"></i>'
            description: entry.description
            descriptionMoreURL: WIKIURL + url
            pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
          completions.push(completion)

      for index, entry of dictionary.equal when entry.description and regex.test(entry.description)

        repeat = false
        for index2, entry2 of completions when entry.displayText is entry2.displayText
          repeat = true
          break

        if not repeat
          completion =
            text: entry.text + ' = '
            displayText: entry.displayText
            type: 'class'
            rightLabel: label
            iconHTML: '<i class="icon-search"></i>'
            description: entry.description
            descriptionMoreURL: WIKIURL + url
            pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
          completions.push(completion)

      for index, entry of dictionary.bracket when entry.description and regex.test(entry.displayText)

        repeat = false
        for index2, entry2 of completions when entry.displayText is entry2.displayText
          repeat = true
          break

        if not repeat
          switch atom.config.get('autocomplete-eu4.bracket')

            when 0
              completion =
                snippet: entry.text + ' = { $1 }$2'
                displayText: entry.displayText
                type: 'class'
                leftLabel: 'single'
                rightLabel: label
                iconHTML: '<i class="icon-search"></i>'
                description: entry.description
                descriptionMoreURL: WIKIURL + url
                pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
              completions.push(completion)

              completion =
                snippet: entry.text + ' = {\n\t$1\n}'
                displayText: entry.displayText
                type: 'class'
                leftLabel: 'multi'
                rightLabel: label
                iconHTML: '<i class="icon-search"></i>'
                description: entry.description
                descriptionMoreURL: WIKIURL + url
                pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
              completions.push(completion)

            when 1
              completion =
                snippet: entry.text + ' = { $1 }$2'
                displayText: entry.displayText
                type: 'class'
                rightLabel: label
                iconHTML: '<i class="icon-search"></i>'
                description: entry.description
                descriptionMoreURL: WIKIURL + url
                pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
              completions.push(completion)

            when 2
              completion =
                snippet: entry.text + ' = {\n\t$1\n}'
                displayText: entry.displayText
                type: 'class'
                rightLabel: label
                iconHTML: '<i class="icon-search"></i>'
                description: entry.description
                descriptionMoreURL: WIKIURL + url
                pos: entry.displayText.toLowerCase().indexOf(prefix.toLowerCase())
              completions.push(completion)

    completions

  compareCompletions: (a, b) ->
    a.pos - b.pos
