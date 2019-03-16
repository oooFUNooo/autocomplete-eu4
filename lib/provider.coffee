GENERAL   = require('../dictionary/general.json')
EFFECT    = require('../dictionary/effect.json')
CONDITION = require('../dictionary/condition.json')
MODIFIER  = require('../dictionary/modifier.json')
SCOPE     = require('../dictionary/scope.json')
COUNTRY   = require('../dictionary/country.json')
WIKIURL   = 'https://eu4.paradoxwikis.com/'


module.exports =

  selector: '.source.eu4'
  disableForSelector: '.source.eu4 .comment'


  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->

    completions = []
    completions = @searchText(0, prefix, completions, GENERAL  , ''         , ''              )
    completions = @searchText(0, prefix, completions, EFFECT   , 'effect'   , 'Commands'      )
    completions = @searchText(0, prefix, completions, CONDITION, 'condition', 'Conditions'    )
    completions = @searchText(0, prefix, completions, MODIFIER , 'modifier' , 'Modifier_list' )
    completions = @searchText(0, prefix, completions, SCOPE    , 'scope'    , 'Scopes'        )
    completions = @searchText(1, prefix, completions, COUNTRY  , 'country'  , 'Countries'     )

    completions.sort(@compareCompletions)

    if atom.config.get('autocomplete-eu4.includedesc')

      completions = @searchText(2, prefix, completions, GENERAL  , ''         , ''              )
      completions = @searchText(2, prefix, completions, EFFECT   , 'effect'   , 'Commands'      )
      completions = @searchText(2, prefix, completions, CONDITION, 'condition', 'Conditions'    )
      completions = @searchText(2, prefix, completions, MODIFIER , 'modifier' , 'Modifier_list' )
      completions = @searchText(2, prefix, completions, SCOPE    , 'scope'    , 'Scopes'        )

    completions


  searchText: (mode, prefix, completions, dictionary, label, url) ->

    if prefix
      completions = @searchBlock(mode, 0, prefix, completions, dictionary.simple , label, url)
      completions = @searchBlock(mode, 1, prefix, completions, dictionary.equal  , label, url)
      completions = @searchBlock(mode, 2, prefix, completions, dictionary.bracket, label, url)

    completions


  searchBlock: (mode, block, prefix, completions, dictionary, label, url) ->

    bracket = atom.config.get('autocomplete-eu4.bracket')

    for index, entry of dictionary

      if not entry.displayText or (mode == 2 and not entry.description)
        continue

      if mode < 2
        haystack = entry.displayText
      else
        haystack = entry.description

      haystack = haystack.toLowerCase().replace('_', '')
      needle   = prefix  .toLowerCase().replace('_', '')
      regex    = new RegExp(needle)

      if regex.test(haystack)

        disp  = entry.displayText
        desc  = entry.description
        url   = WIKIURL + url
        right = label
        pos   = haystack.indexOf(needle)

        switch mode

          when 0
            type = 'snippet'
            icon = 'icon-move-right'

          when 1
            type = 'function'
            icon = 'icon-location'

          when 2
            type = 'class'
            icon = 'icon-search'

        switch block

          when 0
            snippet = entry.text

          when 1
            snippet = entry.text + ' = '

          when 2
            switch bracket

              when 0
                snippet = entry.text + ' = { $1 }$2'
                left = 'single'
                completions = @createCompletion(mode, block, completions, snippet, disp, type, left, right, icon, desc, url, pos)
                snippet = entry.text + ' = {\n\t$1\n}'
                left = 'multi'

              when 1
                snippet = entry.text + ' = { $1 }$2'

              when 2
                snippet = entry.text + ' = {\n\t$1\n}'

        completions = @createCompletion(mode, block, completions, snippet, disp, type, left, right, icon, desc, url, pos)

    completions


  createCompletion: (mode, block, completions, snippet, disp, type, left, right, icon, desc, url, pos) ->

    completion =
      snippet: snippet
      displayText: disp
      type: type
      leftLabel: left
      rightLabel: right
      iconHTML: '<i class=\"' + icon + '\"></i>'
      description: desc
      descriptionMoreURL: url
      pos: pos
    completions.push(completion)

    completions


  compareCompletions: (a, b) ->
    comp = a.pos - b.pos
    if comp == 0
      labela = a.rightLabel
      labelb = b.rightLabel
      if ( labela > labelb )
        comp =  1
      else if ( labela < labelb )
        comp = -1
      else
        texta = a.displayText
        textb = b.displayText
        if ( texta > textb )
          comp =  1
        else if ( texta < textb )
          comp = -1
    comp
