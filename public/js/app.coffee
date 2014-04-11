
# Rutas necesarias para iniciar la aplicación
define [
  'jquery',
  'underscore',
  'backbone',
  'router',
],

($, _, Backbone, Router, io,SessionModel) ->

  initialize = ()->
    

    Router.initialize(SessionModel)
  
  initialize: initialize
  
