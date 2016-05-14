Fractions.Views.PositionShow = Backbone.CompositeView.extend({
  template: JST['position_show'],
  className: 'fractions-object show position',

  events: {

  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);

    this.addSubviewForCharacters();
  },

  render: function () {
    var content = this.template({
      position: this.model
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubviewForCharacters: function () {
    var view = new Fractions.Views.List({
      collection: this.model.members()
    });
    this.addSubview('#characters-list', view);
  },
});
