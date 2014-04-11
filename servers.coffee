



express = require 'express'
routes = require './routes'


http = require 'http'
path = require 'path'
_ = require 'underscore'
request = require 'request'

io = require 'socket.io'

dbserver = 'http://172.19.0.172'




app = express()



app.set 'port', process.env.PORT || 3000
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

app.use express.logger 'dev'
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use express.cookieParser 'your secret here'
app.use express.session secret: 'serchserch'
app.use app.router
app.use express.static path.join(__dirname, 'public')


if 'development' == app.get 'env'
  app.use express.errorHandler()


#
# Simulation DB
#


users = [
  id: '1'
  email: 'sergio.morlan@globalcorporation.cc'
  name: 'Sergio'
  password: '123'
  lastname: 'Morlan'
  devices:[
    idDispositivo: "00408CBEEAE1"
    tipoDispositivo: "Camara"
    fechaAlta: "24/02/2014 11:08:10 a. m."
    conexionExterna: "http://187.237.42.201:20001"
    conexionInterna: "http://172.19.0.209"
    idCatCamara: "1"
    usuario: "root"
    pass: "toor"
  ,
    idDispositivo: "00408CFE6F73"
    tipoDispositivo: "Camara"
    fechaAlta: "20/02/2014 06:09:36 p. m."
    conexionExterna: "http://axis-00408cfe6f73.axiscam.net:8121"
    conexionInterna: "http://axis-00408cfe6f73.axiscam.net:8121"
    idCatCamara: "1"
    usuario: "root"
    pass: "root"
  ]
,
  id: '2'
  email: 'serch.chk@gmail.com'
  name: 'Sergio'
  password: '123'
  lastname: 'Morlan'
  devices:[
    idDispositivo: "00408CBEEAE1"
    tipoDispositivo: "Camara"
    fechaAlta: "24/02/2014 11:08:10 a. m."
    conexionExterna: "http://187.237.42.201:20001"
    conexionInterna: "http://172.19.0.209"
    idCatCamara: "1"
    usuario: "root"
    pass: "toor"
  ,
    idDispositivo: "00408CFE6F73"
    tipoDispositivo: "Camara"
    fechaAlta: "20/02/2014 06:09:36 p. m."
    conexionExterna: "http://axis-00408cfe6f73.axiscam.net:8121"
    conexionInterna: "http://axis-00408cfe6f73.axiscam.net:8121"
    idCatCamara: "1"
    usuario: "root"
    pass: "root"
  ]
,
  id: '3'
  email: 'arnolfo_ass@hotmail.com'
  name: 'Arnolfo'
  password: '321'
  lastname: 'Ass'
,
  id: '4'
  email: 'erika_m@gmail.com'
  name: 'Erika Martinez'
  password: '333'
  lastname: 'Martinez'
]






#
#
# Obtener session para Obsvd 0.1b
#
observid_GetSession = (responseview)->
  
  # Si ya ha iniciado sesión se envian los datos 
  # con auth true 
  if Data.email?
    response =
      auth: true 
      id: Data.id 
      email: Data.email
      name: Data.name
      lastname: Data.lastname
      
      #profileimg: 'http://static.bleacherreport.net/images/redesign/avatars/default-user-icon-profile.png'
  
  # Si NO ha iniciado sesión sólo se envía un auth false          
  else
    response = auth:false
  
  
      
  return response 


#
# 
# Iniciar Session para Obsvd 0.1b
#
observid_StartSession = ()->
  
  # Consulta a la base de datos 
  # buscar al usuario
  user = _.findWhere users, 
    email: request.body.email
    password: request.body.password
  
  # Si el usuario es encontrado  
  if user?
    
    # Colocar las sesiones y cookies en el cliente  
    request.session.email = request.body.email
    request.session.name = user.name
    request.session.lastname = user.lastname
    
    # Respuesta devuelta al cliente
    response.send 
      auth: true 
      id: request.session.id 
      email: request.session.email
      name: request.session.name
      lastname: request.session.lastname
      #profileimg: 'http://static.bleacherreport.net/images/redesign/avatars/default-user-icon-profile.png'
  
  # Si No es encontrado ningún usuario    
  else
    response.send auth: false

  
  return
  

#
# Terminar sessión para Obsvd 0.1b
#
#
observid_EndSession = ()->
  request.session.regenerate (err)->
    response.send auth: false
  return






#
#
# Obtener sesión para vc 1.0 con solicitud a servicios
# de SQL Server 
#
globalcc_GetSession = (requestview, responseview)->
  
  # Si ya ha iniciado sesión se envian los datos 
  # con auth true    
  if typeof requestview.session.idCorreo isnt 'undefined'
    responseview.send
      auth: true 
      id: requestview.session.id 
      idCorreo: requestview.session.idCorreo
      nombre: requestview.session.nombre
      apPaterno: requestview.session.apPaterno
      apMaterno: requestview.session.apMaterno
      idSesion: requestview.session.idSesion
      tipoSesion: requestview.session.tipoSesion
  
  # Si NO ha iniciado sesión sólo se envía un auth false    
  else
    responseview.send auth:false 

      
  return



#
#
# Iniciar Session para vc 1.0 con solicitud a servicios
# de SQL Server 
#
globalcc_StartSession = (requestview, responseview)->
  
  # Valor por defecto
  responsetosend = auth: false 
  tipoSesion = 'w'
  
  #Solicitud request a servicios SQL Server
  request.post 
    headers: 'content-type' : 'application/json'
    url: dbserver + '/Services/Json/eClaroUsuarios/ControlUsuarios.svc/login/'
    
    # Información requerida
    json:
      idCorreo: requestview.body.idCorreo
      pass: requestview.body.password
      tipoSesion: tipoSesion
      
    # Respuesta   
    (error, response, body)->
      # validacion de la respuesta del servicio
      switch body.status.codigo
      
        # Codigo 100 exito
        when 100
          console.log body
          # Colocar sesion y proyecto
          idSesion = body.result.idSesion
          idProyecto = body.result.idProyecto
          
          #
          # Obtener datos de usuario
          request.post 
            headers: 'content-type' : 'application/json'
            url: dbserver + '/Services/Json/eClaroUsuarios/ControlUsuarios.svc/mostrarDatosUsuario/'
            
            # Información requerida
            json:
              idCorreo: requestview.body.idCorreo
              idSesion: idSesion
              tipoSesion: tipoSesion
            
            (error, response, body)->
              
              console.log error
              
              
              # validacion de la respuesta del servicio
              switch body.status.codigo
                # Codigo 100 exito
                when 100
                  
                  console.log body
                  
                  # Colocar las sesiones y cookies en el cliente 
                  requestview.session.idCorreo = body.result.idCorreo 
                  requestview.session.nombre = body.result.nombre
                  requestview.session.apPaterno = body.result.apPaterno 
                  requestview.session.apMaterno = body.result.apMaterno
                  requestview.session.idSesion = idSesion
                  requestview.session.tipoSesion = tipoSesion
                  
                  responsetosend =
                    auth: true 
                    id: requestview.session.id 
                    idCorreo: requestview.session.idCorreo
                    nombre: requestview.session.nombre
                    apPaterno: requestview.session.apPaterno
                    apMaterno: requestview.session.apMaterno
                    idSesion: requestview.session.idSesion
                    tipoSesion: requestview.session.tipoSesion
                  
                    # Enviar Respuesta
                   responseview.send responsetosend
                   
                # Por defecto
                else
                  # Enviar Respuesta
                  responseview.send auth:false 
              return  
                
        # Por defecto
        else
          # Enviar Respuesta
          responseview.send auth:false 
            
      return
      
  return 
  
   
#
#
# Terminar Sesión para vc 1.0 con solicitud a servicios
# de SQL Server 
#
globalcc_EndSession = (idCorreo, idSesion, tipoSesion)->
  request.post 
    headers: 'content-type' : 'application/json'
    url: dbserver + '/Services/Json/eClaroUsuarios/ControlUsuarios.svc/logout/'
    json:
      idCorreo: idCorreo
      idSesion: idSesion
      tipoSesion: tipoSesion 
    (error, response, body)->
      # console.log error
      # console.log response 
      # console.log body
      return
  return


#
#
# Comenzar sesión con facebook sólo con email
#
facebook_StartSession = ()->
  user = _.findWhere users, 
    email: request.body.email
    #password: request.body.password
    
  request.session.email = request.body.email
  request.session.name = user.name
  request.session.lastname = user.lastname
  
  if user?
    # Respuesta devuelta al cliente
    response.send 
      auth: true 
      id: request.session.id 
      email: request.session.email
      name: request.session.name
      lastname: request.session.lastname
      #profileimg: 'http://graph.facebook.com/' + request.body.idfacebook + '/picture'
  return
   


#
# VISTAS
#

  
#  
# Principal  
app.get '/', routes.index



#
# Obtener session
app.get '/session', (req, res)->
  
  
  # Para vc  
  globalcc_GetSession req, res
  
  # Para obsvd
  # observid_GetSession Data
  
  return



#
# Colocar session
app.post '/session', (request, response)->
  
  
  # Si no es detectada ninguna solicitud
  if not request
    response.send auth: false
  
  
 
  
  # Si la solicitud no contiene ningún email
  if not request.body.idCorreo
    #console.log 'Nothing'
    response.send auth: false
    return
  
  
  
    
  # Si la solicitud es por parte de facebook
  if request.body.facebook
    facebook_StartSession()
  
  
  # Si la solicitud es por el propio sistema
  else
    
    # Para vc
    responsetosend = globalcc_StartSession request, response
        
  return
  
  



#
# Obtener dispositivos de usuario 
app.get '/device/:id', (req, res)->
  
  idDispositivo = req.params.id
  
  if req.session.idCorreo?
    request.post 
      headers: 'content-type' : 'application/json'
      url:'http://172.19.0.172/Services/Json/eClaroHome/ControlDispositivos.svc/mostrarCamaras/'
      json:
        sesion:
          idCorreo: req.session.idCorreo
          idSesion: req.session.idSesion
          tipoSesion: req.session.tipoSesion
        dispositivo:
          idDispositivo: idDispositivo
      (error, response, body)->

        res.send body
        return
  
  else
    res.send msg: 'nope' 
  
  return  

  



#
# Obtener dispositivos de usuario 
app.get '/axisapi/:url/:user/:password/:options', (req, res)->
  
  console.log req.body
  
  url = req.params.url
  user = req.params.user
  password = req.params.password
  options = decodeURIComponent req.params.options
  
  if req.session.idCorreo?
    request.get 
      
      url: 'http://'+ url + options
      
      auth:
        user: user
        pass: password
      
      (error, response, body)->
        console.log 'on error'
        console.log error
        res.send body
        return
  
  else
    res.send msg: 'nope' 
  
  return  



  
  
  
#
#
#  
app.del '/session/:id', (request, response)->
  request.session.regenerate (err)->
    response.send auth: false
  return

#
# Iniciar servidor http
#
server = http.createServer(app).listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get 'port'
 
  




serversocekt = io.listen server, log: false

###
app.get '/img', (req, res)->
  request.get 
    #url:'http://172.19.0.209/axis-cgi/jpg/image.cgi'
    url:'http://172.19.0.209/axis-cgi/mjpg/video.cgi'
    auth:
      user: 'root'
      pass: 'toor'
    (error, response, body)->
      console.log body
      #base64Image = new Buffer(body, 'binary').toString('base64');
      #console.log base64Image
      #console.log error
      #console.log response
      
      #res.send '<img src="data:image/jpg;base64,' + base64Image + '"/>'

      
      return


serversocekt = io.listen server, log: false

serversocekt.sockets.on 'connection', (socket)->
  socket.emit 'news', hello: 'ff'
  return
  
###









