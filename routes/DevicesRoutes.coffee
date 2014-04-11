
request = require 'request'

dbserver = 'http://172.19.0.123'

#
#
#
exports.GetAll = (req, res)->
  
  idDispositivo = '%'
  
  if req.session.idCorreo?
    request.post 
      headers: 'content-type' : 'application/json'
      url: dbserver + 'Services/Json/eClaroHome/ControlDispositivos.svc/mostrarCamaras/'
      json:
        sesion:
          idCorreo: req.session.idCorreo
          idSesion: req.session.idSesion
          tipoSesion: req.session.tipoSesion
        dispositivo:
          idDispositivo: idDispositivo
      (error, rescross, body)->
        console.log error
        console.log body
        return
  
  else
    res.send msg: 'nope' 
