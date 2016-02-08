import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'li',
  classNames: ['track-item'],
  attributeBindings: ['draggable'],
  draggable: true,

  didInsertElement: function() {    
    console.log(this.elementId);
    console.log(this.element);
  },

  dragStart: function(e) {
    var img = this.$(".track-image")[0];
    console.log(e);
    e.data = {
      id: 234
    };

    e.dataTransfer.setDragImage(img, 0, 0);
  },

});
