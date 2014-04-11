
# Rutas necesarias para iniciar la aplicación
define [
  'jquery',
  'underscore',
  'backbone',
  'views/SplashView',
  'views/LoginView',
  'views/HomeView'
], 


# Function
($, _, Backbone, SplashView, LoginView, HomeView)->
  
  Router = Backbone.Router.extend
    
    routes:
      '': 'showSplashView'
      'login': 'showLogInView'
      'logout': 'showLogOutView'
      'home': 'showHomeView'
      '*actions': 'defaultAction'
      
      
  initialize = (Session) ->
    
    AppRoutes = new Router
     
     
    #
    #
    #      
    AppRoutes.on 'route:showSplashView', 
      
      ()->
        if !Session.get 'auth'
          view = new SplashView AppRoutes
          view.render()
        else
          view = new HomeView Session
          view.render()
        
        return
        
    #
    #
    #   
    AppRoutes.on 'route:showLogInView', 
      ()->
        if !Session.get 'auth'
          view = new LoginView AppRoutes, Session
          view.render()
        else
          AppRoutes.navigate 'home', trigger: true
        return
    
    
    
    #
    #
    #   
    AppRoutes.on 'route:showLogOutView', 
      ()->
        if Session.get 'auth'
          Session.logout ()->
            AppRoutes.navigate 'login', trigger: true
        else
          AppRoutes.navigate 'login', trigger: true
        return
    
    
    
    #
    #
    #  
    AppRoutes.on 'route:showHomeView', 
      ()->
        if Session.get 'auth'
          view = new HomeView Session
          view.render()
        else
          AppRoutes.navigate 'login', trigger: true
        return
    
    
    
    
    
    Backbone.history.start()
    
    
    
    return
    
    
  # Regresar el contructor  
  initialize:initialize
  
  
    



  
  
  

      
    
    
      
 