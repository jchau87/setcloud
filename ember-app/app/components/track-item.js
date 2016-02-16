import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'li',
  classNames: ['track-item'],
  attributeBindings: ['draggable'],
  draggable: true,

  // didInsertElement: function() {    
  // },

  dragStart: function(e) {
    // Set track id
    var track = this.get('track');
    e.dataTransfer.setData('text/data', JSON.stringify({ id: track.id }));

    // Set draggable image
    var img = this.$(".track-image")[0];
    e.dataTransfer.setDragImage(img, 0, 0); 
  },
});
