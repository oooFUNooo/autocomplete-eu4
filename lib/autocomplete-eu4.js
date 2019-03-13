'use babel';

import AutocompleteEu4View from './autocomplete-eu4-view';
import { CompositeDisposable } from 'atom';

export default {

  autocompleteEu4View: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.autocompleteEu4View = new AutocompleteEu4View(state.autocompleteEu4ViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.autocompleteEu4View.getElement(),
      visible: false
    });

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'autocomplete-eu4:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.autocompleteEu4View.destroy();
  },

  serialize() {
    return {
      autocompleteEu4ViewState: this.autocompleteEu4View.serialize()
    };
  },

  toggle() {
    console.log('AutocompleteEu4 was toggled!');
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
