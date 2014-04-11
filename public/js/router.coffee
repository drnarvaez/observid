
# Rutas necesarias para iniciar la aplicación
define [
  'jquery'
  'underscore'
  'backbone'
  'views/SplashView'
], 


# Function
($, _, Backbone, SplashView)->
  
  Router = Backbone.Router.extend
    
    routes:
      '': 'showSplashView'
      
      
  initialize = (Session) ->
    
    AppRoutes = new Router
     
     
    #
    #
    #      
    AppRoutes.on 'route:showSplashView', 
      
      ()->
        view = new SplashView
        view.render()        
        return
        
  
    

    
    
    
    
    Backbone.history.start()
    
    
    
    return
    
    
  # Regresar el contructor  
  initialize:initialize
  
  
    



  
  
  

      
    
    
      
 