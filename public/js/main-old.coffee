require.config
  
  paths:
    # Librerias basicas para el funcionamiento del sistema 
    # core
    jquery: 'libs/jquery/jquery.min'
    underscore: 'libs/underscore.js/underscore-min'
    backbone: 'libs/backbone.js/backbone-min'
    text: 'libs/require-text/text.min'
    socketio: '../socket.io/socket.io'
    # Librerías extras 
    slimscroll: 'libs/jQuery-slimScroll/jquery.slimscroll.min'
    hammerCore: 'libs/hammer/hammer'
    hammer: 'libs/hammer/jquery.hammer'
    facebook: '//connect.facebook.net/en_US/all'
    #facebook: 'libs/facebook/facebook'
  
  shim:
    
    backbone:
      deps: [
        'underscore', 
        'jquery'
        ]
      exports: 'Backbone'
      
    underscore:
      exports: '_'
    
    socketio:
      exports: 'io'
    
    hammer:
      deps:[
        'hammerCore', 
        'jquery']
      exports: 'hammer'
      
    facebook:
      exports: 'FB'
        



require ['app'], 
  (App)->
    App.initialize()
 