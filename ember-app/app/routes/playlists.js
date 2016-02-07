import Ember from 'ember';

export default Ember.Route.extend({
  model: function () {
    var playlists = this.store.findAll('playlist');
    return playlists;
  },
});
