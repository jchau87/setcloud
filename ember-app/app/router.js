import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: '/app/'
});

Router.map(function() {
  this.route('playlists', function(){
    this.route('playlist', { path: '/:playlist_id' });
  });
});

export default Router;
