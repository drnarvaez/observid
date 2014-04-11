
request = require 'request'

dbserver = 'http://172.19.0.123'



#
#
#
_GetUserData = (req, res)->
  
  unless req.session.idCorreo? and req.session.idSesion? and req.session.tipoSesion?
    return null 
  
  
  request.post 
    headers: 'content-type' : 'application/json'
    url: dbserver + '/Services/Json/eClaroUsuarios/ControlUsuarios.svc/mostrarDatosUsuario/'
    
    # Información requerida
    json:
      idCorreo: req.session.idCorreo
      idSesion: req.session.idSesion
      tipoSesion: req.session.tipoSesion
      
    (error, rescross, body)->

      switch body.status.codigo
        when 100
          req.session.nombre = body.result.nombre
          req.session.apPaterno = body.result.apPaterno 
          req.session.apMaterno = body.result.apMaterno
          
          ResData = 
            auth: true
            id: req.session.id
            idCorreo: req.session.idCorreo
            nombre: req.session.nombre
            apPaterno: req.session.apPaterno
            apMaterno: req.session.apMaterno
            idSesion: req.session.idSesion
            tipoSesion: req.session.tipoSesion
          
          # Send Data
          res.send ResData 
        
        else
          res.send auth:false
      return      
      
  return



#
#
#
exports.SignIn = (req, res)->
  
  # if req is empty
  # if not req
    # res.send auth: false
  
  # Default values
  tipoSesion = 'w'
  
  
  request.post
    headers: 'content-type' : 'application/json'
    url: dbserver + '/Services/Json/eClaroUsuarios/ControlUsuarios.svc/login/'
    
    json:
      idCorreo: req.body.idCorreo
      pass: req.body.pass
      # idCorreo: 'sergio.morlan@globalcorporation.cc'
      # pass: 'sergio'
      tipoSesion: tipoSesion
  
    
    (error, rescross, body)->
      
      # Check response
      switch body.status.codigo
        
        # Success
        when 100
                  
          # Set session
          req.session.idCorreo = req.body.idCorreo
          req.session.idSesion = body.result.idSesion
          req.session.idProyecto = body.result.idProyecto
          req.session.tipoSesion = tipoSesion        
          
          _GetUserData req, res
          
        # Default  
        else
          console.log 'err code'
          res.send auth: false
      
      return







#
#
#
exports.Testit = ()->
  console.log 'in exports'      






#
#
#
exports.GetUserData = _GetUserData
  
  
