
# Rutas necesarias para iniciar la aplicación
define [
  'jquery',
  'underscore',
  'backbone',
  'router',
  'socketio',
  'models/SessionModel',
],

($, _, Backbone, Router, io,SessionModel) ->

  initialize = ()->
    
    # Test socket
    socket = io.connect 'http://observid.com/'
    
    socket.on 'news', (Data)->
      console.log Data
    
    
    SessionModel.getAuth ()->
      Router.initialize(SessionModel)
  
  initialize: initialize
  
