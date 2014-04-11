###
#
# Pure JavaScript
#
window.fbAsyncInit = ()->
  FB.init
    appId : ''
    status: true
    cookie: true
    xfbml: true
  
  FB.Event.suscribe 'auth.authResponseChange', (response)->
    if response.status is 'connected'
      testAPI()
    else if response.status is 'not_authorized'
      FB.login()
    else
      FB.login()


    
(d)->
  id = 'facebook-jssdk'
  ref = d.getElementByTagName('script')[0]
  if d.getElementById id 
    return
  
  js = d.createElement 'script'
  js.id = id
  js.async = true
  js.scr = "//connect.facebook.net/en_US/all.js"
  ref.parentNode.insertBefore js, ref
(document)

testAPI = ()->
  console.log 'Welcome! Fetching your infromation...'
  FB.api '/me', (response)->
    console.log 'Good to see you' + response.name + '.'

###

#
# jQuery
#


$ ()->
  
  #
  # Funcion que se ejecutará al cargar por completo la api
  #
  fbAsyncInit = ()->
    
    #
    # Inicializar api de facebook
    #
    FB.init
      appId : '743196062358714'
      status: true
      cookie: true
      xfbml: true
   
    
    
    #
    # Verificar el estado actual de sesión
    #
    FB.getLoginStatus (response)->
      if response.status is 'connected'
        # Si esta loggeado y además permite la aplicación
      else if response.status is 'not_authorized'
        # Si esta loggeado y pero NO permite la aplicación
      else
        # No esta loggeado
      return
        
    #
    # Evento que escucha cuando cambia el estado de la sesion
    # iniciar / terminar sesion
    #
    FB.Event.subscribe 'auth.authResponseChange', (response)->
      if response.status is 'connected'
        # Si esta loggeado y además permite la aplicación
        
        # Obtención de datos del usuario
        FB.api '/me', (response)->
          console.log 'Tu nombre es' + response.name

      else if response.status is 'not_authorized'
        # Si esta loggeado y pero NO permite la aplicación
        # mandar autorización de la aplicación
        FB.login()
      else
        # No esta loggeado 
        # mandar loggeo       
        FB.login()
      return
 
    return  
  
  
  #
  # Cargar asincronamente facebook api
  #
  $.ajaxSetup cache: true
  $.getScript '//connect.facebook.net/en_US/all.js', (Data)->
    # Procedimientos al momento de inciar sesion
    fbAsyncInit()
    return
  
  return
