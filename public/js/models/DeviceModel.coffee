
# Rutas necesarias para iniciar la aplicación
define [
  'jquery',
  'underscore',
  'backbone',
],

($, _, Backbone)->
  
  DeviceModel = Backbone.Model.extend
  
    #urlRoot: '/device'
    
    defaults:
      imgurl: 'http://www.digimagix.gr/VDR/assets/images/camera-motion_not_found.png'
    
    
    #
    #
    #
    initialize: ()->
      this.setDomains()
      this.set 'idCatCamara', 'Camara' if this.get('idCatCamara') is '1'
      
      this.on 'change:resoluciones', ()->
        this.getImage()
        
      return
    
    
      
    #
    #
    #
    getImage: ()->
      uri = 'http://' + this.get 'usuario'
      uri += ':' + this.get('pass')+ '@'
      uri += this.get 'DominioInterno'
      uri += '/axis-cgi/jpg/image.cgi?resolution='
      uri += this.get 'ResolucionMinima'
      
      # uri = 'http://' + this.get('usuario') + ':' + this.get('pass')+ '@' + this.get('dominioInterno') + '/axis-cgi/param.cgi?action=list&group=Properties.Image.Resolution'
      
      this.set 'imgurl' , uri
      
      this.loadImage()
      
      return
    
    
    
    #
    #
    #
    loadImage: ()->
      $img = $('<img>')
      $img.attr 'src', this.get 'imgurl'
      $img.load (s)->
        $('body').append $img
        
      
    
    
    #
    #
    #
    getReslolution: ()->
      
      self = this
      
      Options = '/axis-cgi/param.cgi?action=list&group=Properties.Image.Resolution'
      #Options = 'videostatus.cgi?status=1,2,3,4'
      
      
      uri = '/axisapi' 
      uri += '/' + this.get 'DominioInterno'
      uri += '/' + this.get 'usuario'
      uri += '/' + this.get 'pass'
      uri += '/' + encodeURIComponent Options
      
      
      GetImage = $.ajax 
        url: uri

      
      GetImage.done (Data)->
        
        # La respuesta debe tener el formato 
        # Properties.Image.Resolution=640x480,...,176x144
        
        
        # Detección de respuesta
        if Data.split("=").length <= 1
          self.set 'ResolucionMaxima' , null
          self.set 'ResolucionMinima' , null
          self.set 'Resoluciones' , null
          # En esta solicitud se detecta si esta conectada 
          # la camara
          self.set 'EstaConectada', false
          return
        
        
        Resolutions = (Data.split("=")[1]).split(",")
        ResolutionTrim = []
        
        for Resolution in Resolutions
          ResolutionTrim.push Resolution.trim()
         
        
        MaxResolution= ResolutionTrim[0]
        MinResolution = ResolutionTrim[ResolutionTrim.length-1]
        
        self.set 'ResolucionMaxima' , MinResolution
        self.set 'ResolucionMinima' , MaxResolution
        self.set 'Resoluciones' , ResolutionTrim
        self.set 'EstaConectada', true
        
        console.log self.get 'Resoluciones'
        
      GetImage.fail (Data)->
        console.log Data
            
      return
      
      
    #
    #
    #
    getURLReproduction: ()->
      
      auth = 'http://' + this.get 'usuario' + ':' + this.get 'pass' + '@'
    
      return
      
    
    #
    #
    #
    setDomains:()->
      
      $a = $('<a></a>')
      
      $a.attr 'href', this.get 'conexionInterna'
      this.set 'DominioInterno', $a[0].hostname
      
      
      $a.attr 'href', this.get 'conexionExterna'
      this.set 'DominioExterno', $a[0].hostname
      
      $a.remove()
      
      return
    
    
    #
    #
    #
    gerResolution: ()->
      return
      
      
      
    
  return DeviceModel
      
