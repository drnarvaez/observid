
# Rutas necesarias para iniciar la aplicación
define [
  'jquery'
  'underscore'
  'backbone'
  'models/AuthModel'
  'collections/DeviceCollection'
],


($, _, Backbone, AuthModel, DeviceCollection) ->
  SplashView = Backbone.View.extend
    
    el: '#container'
    
    SessionModel: null
    
    incognity: true
    
    #
    # Eventos delegados de esta vista
    #
    events:
      'click button': 'login'
    
    
    #
    # Contructor de la vista
    #
    initialize: ()->
      
      this.SessionModel= AuthModel
      
      $('#videoHTML5-1, #videoHTML5-2, #videoHTML5-3').on 'loadeddata', (e)->
        console.log 'play'
        #(this)[0].play()
        
      $('#videoHTML5-1, #videoHTML5-2, #videoHTML5-3').on 'progress', (e)->
        console.log 'progress...'
        #$(this)[0].pause()
      
      $('#videoHTML5-1, #videoHTML5-2, #videoHTML5-3').on 'error', (e)->
        console.log '!error'
        $(this)[0].play()      
      
      
      # for flowplayer
      # $f 'player', 'js/libs/flowplayer.swf', clip:
        # url: 'http://localhost:3000/video/1' 
        # live: true
        # autoPlay: true
        
      return
    
    
    
    #
    #render
    #
    render: ()->      
      return
      
    
    login: (e)->
      e.preventDefault()
      self = @
      $form = $(e.currentTarget).parent()
      Data = 
        'idCorreo': $form.find('input[name=idCorreo]').val()
        'pass': $form.find('input[name=pass]').val()
        'facebook': false
      
      _Callback = ()->
        AllMyDevices = new DeviceCollection()
        
        AllMyDevices.fetch success: (Data)->
          console.log Data
          
        console.log self.SessionModel
      
      this.SessionModel.login Data, _Callback
     
      
 

  
  SplashView