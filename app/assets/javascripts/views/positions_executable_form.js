Fractions.Views.PositionsExecutableForm = Backbone.View.extend({
  template: JST['positions_new_form'],
  className: 'fractions-object-element fractions-object-new fractions-object-position',

  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.fraction = options.fraction;
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    var view = this;
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();
    params.position.fraction_id = this.fraction.escape('id');
    this.collection.create(params['position'], {
       wait: true,
       success: function () {
         view.remove();
       }
     });
  }
});
