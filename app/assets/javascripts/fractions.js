window.Fractions = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new Fractions.Routers.Router($('#main'));
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Fractions.initialize();
});
