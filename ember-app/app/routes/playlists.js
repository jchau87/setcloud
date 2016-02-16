import Ember from 'ember';

export default Ember.Route.extend({
  model: function () {
    var playlists = this.store.findAll('playlist');
    return playlists;
  },

  actions: {
    updatePlaylist: function(data) {
      console.log("UPDATING PLAYLIST");
      console.log(data);
      
      this.store
        .findRecord('playlist', data.playlistId)
        .then(function(playlist) {

          var tracks = playlist.get('tracks');
          tracks.push({kind: 'track', id: data.id});
          playlist.set('tracks', tracks);

          return playlist.save();
        })
        .then(function(playlist) {
          playlist.reload();
        });
    },
  },
});
