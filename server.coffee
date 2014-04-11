

express = require 'express'

http = require 'http'
path = require 'path'

app = express()

#
VideoRoutes = require './routes/VideoRoutes'
AuthRoutes = require './routes/AuthRoutes'
DevicesRoutes = require './routes/DevicesRoutes'



app.set 'port', process.env.PORT || 3000
app.set 'views', path.join(__dirname, 'views') 

app.use express.logger 'dev'
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()

app.use express.cookieParser 'bla'
app.use express.session secret: 'ble'

app.use app.router
app.use express.static path.join(__dirname, 'public')


if 'development' == app.get 'env'
  app.use express.errorHandler()
  


# home
app.get '/', (req, res)->
  res.sendfile 'views/index.html'

# auth
app.post '/auth', AuthRoutes.SignIn


app.get '/devices', DevicesRoutes.GetAll


# webm video
app.get '/video/webm/:id', VideoRoutes.webm
  
# mp4 video
app.get '/video/mp4/:id', VideoRoutes.mp4

# ogg video
app.get '/video/ogg/:id', VideoRoutes.ogg



#
# Create http Server
#
server = http.createServer(app).listen app.get('port'), ->
  console.log 'Observid esta escuchando ' + app.get 'port'
  return