import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'li',
  classNames: ['playlist-item', 'draggable-dropzone'],
  classNameBindings: ['draggableClass', 'selected'],
  draggableClass: 'inactive',
  
  dragEnter: function(e) {
    this.set('draggableClass', 'active');
    return false;
  },

  dragLeave: function(e) {
    this.set('draggableClass', 'inactive');
    return false;
  },

  dragOver: function(e) {
    return false;
  },

  drop: function(e) {
    var data = JSON.parse(e.dataTransfer.getData('text/data'))
    data['playlistId'] = this.get('playlist').id
    this.sendAction("dropped", data)

    this.set('draggableClass', 'inactive');
    return false;
  },

});
