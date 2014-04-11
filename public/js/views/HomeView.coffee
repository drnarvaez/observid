
# Rutas necesarias para iniciar la aplicación
define [
  'jquery',
  'underscore',
  'backbone',
  'models/DeviceModel'
  'collections/DeviceCollection'
  'text!templates/HomeTemplate.html'
  'text!templates/DeviceTemplate.html'
],


($, _, Backbone, DeviceModel, DeviceCollection, HomeTemplate, DeviceTemplate)->
  HomeView = Backbone.View.extend
    
    el: '#container'   
    Devices: []
    
    events:
      'click ul li a' : 'PlayItem' 
    
    
    # Contructor de la vista
    initialize: (Session)->
      
      self = this
      
      TemplateData =
        Name          : Session.get 'nombre'
        LastName      : Session.get 'apPaterno'
        ProfileImgSrc : Session.get 'profileimg'
      
      CompiledTemplate = _.template HomeTemplate, TemplateData
      
      this.$el.html CompiledTemplate
      
     
      Devices = new DeviceCollection pathdefault : "/%25"
      Devices.fetch 
        success: (DataFetch)->
          
          self.Devices = DataFetch
          
          for Device in DataFetch.models
            console.log Device
            
            TemplateData =
              idDispositivo   : Device.get 'idDispositivo'
              nombre          : Device.get 'nombre'
              GrupoDispositivo: Device.get 'GrupoDispositivo'
            
            CompiledTemplate = _.template DeviceTemplate, TemplateData
            self.$el.find('ul').append CompiledTemplate
            
            Device.getReslolution()
            

              
            
          return
        
      #console.log Devices
  
      #console.log $('#player').load("http://root:chinitos@172.19.0.202/axis-cgi/param.cgi?action=list&group=Properties.Image.Resolution" )
      
      return
    
    PlayItem: (e)->
      
      
      e.preventDefault()
      
      Id = $(e.target).attr('href').substring 1 
            
      CurrentDevice = this.Devices.findWhere 'idDispositivo' : Id     
      
      $('#player').html CurrentDevice.getImage()
      
      
      
      return
    
      
      
   
      
  HomeView