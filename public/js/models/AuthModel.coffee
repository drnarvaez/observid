
# Deps
define [
  'jquery',
  'underscore',
  'backbone',
  'facebook',
],

($, _, Backbone, Facebook)->
  
  Model = Backbone.Model.extend
    
    urlRoot: '/auth'
    logged: false
    FB: null
    
    #
    # 
    #
    initialize: ()->
      
      # Inicializar facebook
      this.FB = FB
      this.FB.init
        appId : '743196062358714'
        status: true
        cookie: true
        xfbml: true
      
   
      return
      
      
 
    # 
    # Se envian las credenciales por metodo post
    # creds = email: 'serch@gmail.com', password:'123'
    #  
    login: (Creds, Callback)->
      self = this
      #console.log FB
      _.defaults 
        facebook: false
        observid_get: true
      , Creds
      # Si el usuario entro con facebook
      if Creds.facebook? and Creds.facebook is true
        
        #
        # Evento que escucha cuando cambia el estado de la sesion
        # iniciar / terminar sesion
        #
        self.FB.login (response)->
          
          if response.status is 'connected'
            FB.api '/me', (response)->
              #console.log response
              Creds.email = response.email
              Creds.name = response.first_name
              Creds.lastname = response.last_name
              Creds.idfacebook = response.id
              console.log response
              self.save Creds, 
                success: ()->
                  Callback()
                  return true
                error: (e)->
                  return false 
              return 
          
          else if response.status is 'not_authorized'
            # console.log 'not_authorized'
            
          else
            # console.log 'not_connected'
            
            
          return
        , scope: 'email'
              
     # Si el usuario NO entro con facebook       
      else
        self.save Creds, 
        success: (model)->
          # Eliminar la propiedad password para que no sea visible en el modelo
          model.unset 'pass',  silent: true 
          Callback()
          return true
        error: (e)->
          return false
          
      return
    
    
    #
    #
    #
    isLogin: ()->
      self = this
      #
      # Verificar el estado actual de sesión
      ###
      self.FB.getLoginStatus (response)->
        if response.status is 'connected'
          console.log 'connected'
          console.log response         
          
        else if response.status is 'not_authorized'
          # Si esta loggeado y pero NO permite la aplicación
          console.log 'not_authorized'
          console.log response
        else
          # No esta loggeado
          console.log 'no connected'
          console.log response
        return
      ###  
      return  
    
    
    
    
    #
    # 
    #
    logout: (Callback)->
      self = this
      
      if this.get('facebook')? and this.get('facebook') is true
        self.FB.logout (response)->
          return
      
     
      this.destroy success:(model, response)->
        model.clear()
        model.id = null
        self.set auth: false
        Callback()
        return
      return
      
      
      
    #
    # 
    #
    getAuth: (Callback)->
      self = this
      this.fetch success: ()->
        
        # Eliminar la propiedad password para que no sea visible en el modelo
        #model.unset 'password',  silent: true 
        
        Callback()
        return
      return
    
  return new Model()
    
      
