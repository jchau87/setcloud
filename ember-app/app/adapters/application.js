export default DS.JSONAPIAdapter.extend({
  buildURL: function(record, suffix) {
    var s = this._super(record, suffix);
    return s + ".json";
  }
});