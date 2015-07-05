Fractions.Views.CharacterListItem = Backbone.View.extend({
  template: JST["character_list_item"],
  className: "character-list-item",

  events: {
    // 'click': 'show'
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ character: this.model });
    this.$el.html(content);
    return this;
  },

  // show: function (event) {
  //   Backbone.history.navigate("/characters/" + this.model.get("id"), { trigger: true });
  // }
});
