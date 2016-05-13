Fractions.Views.FractionComponentNew = Backbone.CompositeView.extend({
  template: JST['fraction_component_new'],

  events: {
    'click button#executable': 'addSubviewForFractionComponentExecutableForm',
    // 'click button#callable': 'addSubviewForFractionComponentCallableForm',
    // 'click button#votable': 'addSubviewForFractionComponentVotableForm',
  },

  initialize: function (options) {
    this.name = _.singularize(options.name);
    this.noun = options.noun;
    this.fraction = options.fraction;
    this.addSubviewForAuthorizationButtons();
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubviewForAuthorizationButtons: function () {
    var view = new Fractions.Views.AuthorizationButtons({
      authorizer: this.fraction,
      authorization_type: _.singularize(this.noun) + '_create'
    });
    this.addSubview('.authorization-buttons', view);
  },

  addSubviewForFractionComponentExecutableForm: function () {
    var view = new Fractions.Views.ExecutableForm({
      fraction: this.fraction,
      collection: this.collection,
      noun: this.noun
    });
    this.subviews('.form-container').forEach(function (subview) {
      subview.remove();
    });
    this.addSubview('.form-container', view);
  },
});
