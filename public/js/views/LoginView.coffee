
# Rutas necesarias para iniciar la aplicación
define [
  'jquery',
  'underscore',
  'backbone',
  'text!templates/splash/LoginTemplate.html'
],


($, _, Backbone, LoginTemplate)->
  SplashView = Backbone.View.extend
    
    el: '#container'
    
    SessionModel: null
    
    AppRoutes: null
    
    incognity: true
    
    #
    # Eventos delegados de esta vista
    #
    events:
      'click #Cancel': 'hideLoginForm'
      'click #loginObservid': 'sendLoginForm'
      'click #loginFacebook': 'sendLoginFormFacebook'
    
    
    #
    # Contructor de la vista
    #
    initialize: (AppRoutes, SessionModel)->
      self = this
      this.AppRoutes = AppRoutes 
      this.SessionModel= SessionModel
      return
    
    
    #
    #render
    #
    render: ()->


      # Información de etiquetas
      lang =
        logintitle: this.isIncognity 'Iniciar Sesión'
        loginbutton: this.isIncognity 'Iniciar'
        logincancel: this.isIncognity 'Cancelar'
        logininputuserplaceholder: this.isIncognity 'Usuario'
        logininputpasswordplaceholder: this.isIncognity 'Contraseña' 
      
      
      # Información global
      data =
        user: 'sergio'
        lang: lang
      
      
      # Compilar plantilla
      compiledTemplate = _.template LoginTemplate, data
      this.$el.html compiledTemplate 
      
      
      this.$el.find('form').show().addClass 'fx_FormIn'
      this.$el.find('form').show().removeClass 'fx_FormInStatic'
      
      this.$el.height($(window).height())
      
      this.SessionModel.isLogin()
      
      return
      
 
      
    #  
    # Ocultar cambio
    #
    hideLoginForm: (e)->
      e.preventDefault()
      self = this
      
      self.$el.find('form').addClass 'fx_FormOut'
      self.$el.find('form').show().removeClass 'fx_FormInStatic'
      #self.$el.find('hgroup').addClass 'fx_HeaderIn'
      
      # Efectos controlados con css keyframes
      _.delay ()->
        self.$el.find('form').hide().removeClass 'fx_FormOut'
        self.AppRoutes.navigate '', trigger: true
        return
      , 500
    
    
           
    #
    # Enviar datos de inicio de sesion
    #  
    sendLoginForm: (e)->
      e.preventDefault()
      self = this
      $form = $(e.currentTarget).parent()
      Data = 
        'idCorreo': $form.find('input[name=email]').val()
        'password': $form.find('input[name=password]').val()
        'facebook': false
     
     
      Callback = ()->
        console.log self.SessionModel
        if self.SessionModel.get 'auth'
          self.AppRoutes.navigate 'home', trigger: true
        else
          self.$el.find('form').show().addClass 'fx_FormInStatic'
          self.$el.find('form').show().addClass 'fx_FormShake'
          _.delay ()->
            self.$el.find('form').show().removeClass 'fx_FormShake'
          , 500
        return
      
      this.SessionModel.login Data, Callback

      return
      
    
    sendLoginFormFacebook: (e)->
      e.preventDefault()
      self = this
      Data = 
        'facebook': true
      
      Callback = ()->
        if self.SessionModel.get 'auth'
          self.AppRoutes.navigate 'home', trigger: true
        else
          self.$el.find('form').show().addClass 'fx_FormInStatic'
          self.$el.find('form').show().addClass 'fx_FormShake'
          _.delay ()->
            self.$el.find('form').show().removeClass 'fx_FormShake'
          , 500
        return
      
      this.SessionModel.login Data, Callback
      
      return
    
      
    noSubmit: (e)->
      # e.preventDefault()
      
      
      
    #  
    # Only for hide in the job
    #
    isIncognity: (str)->      
      lorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris scelerisque nisi ut vestibulum fringilla. Morbi dignissim quam sed dui pulvinar, et pharetra mauris mattis. Suspendisse potenti. Vivamus eleifend elit eu felis condimentum pellentesque. Donec at magna blandit, adipiscing est at, rutrum felis. Vivamus pharetra ornare augue, id vestibulum orci viverra vitae. Donec nibh metus, dapibus in tortor sit amet, porta faucibus nulla. Proin tempor dolor et lorem eleifend mattis. Aenean eget ullamcorper neque, vitae porta quam. Nulla commodo arcu id enim aliquam volutpat. Suspendisse molestie turpis et consequat faucibus. In rhoncus augue eget ullamcorper sollicitudin. Etiam malesuada adipiscing fermentum. Mauris semper ligula nec libero egestas consectetur. Quisque varius a leo eu dignissim. Proin rutrum ac ipsum vel ornare. Sed elementum felis nec nunc egestas gravida quis et sapien. Aliquam erat volutpat. Integer a felis tortor. Nullam quis dapibus dolor, rhoncus pellentesque nisi.'

      if this.incognity
        lorem = lorem.substring 0, str.length 
      else
        lorem = str
        
      return lorem
  
  SplashView