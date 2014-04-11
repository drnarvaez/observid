# Commands ffmpeg
# -i rtsp://root:chinitossucks@172.19.0.202:554/axis-media/media.amp?videocodec=h264 -vcodec copy -f mp4
# -f x11grab -s 1920x1200 -r 15 -i :0.0 -c:v libx264 -preset fast -pix_fmt yuv420p -s 1280x800 -threads 0 -f flv "rtsp://root:chinitossucks@172.19.0.202:554/axis-media/media.amp?videocodec=h264"
# -f dshow -i video="Virtual-Camera" -vcodec libx264 -tune zerolatency -b 900k -f mpegts "rtsp://root:chinitossucks@172.19.0.202:554/axis-media/media.amp?videocodec=h264"


# ffmpeg -re -i testo.mp4 -c copy -f flv "rtsp://root:chinitossucks@172.19.0.202:554/axis-media/media.amp?videocodec=h264"


# Almacena el video en dump.flv
#   ffmpeg -i {{}} -c copy dump.flv


# Reproducir en servidor 
# ffplay -i {{}}

# 
# 


FFmpeg = require 'fluent-ffmpeg'
child_process  = require('child_process')
params = ''
#params = '?videocodec=h264&resolution=640x480'
#rtspURL = 'rtsp://root:chinitossucks@172.19.0.202:554/axis-media/media.amp' + params
rtspURL = 'rtsp://root:ozhkarsucks@172.19.0.201:9014/axis-media/media.amp' + params



#
#
#
exec = (args, res, type, debug)->
  
  ffmpeg = child_process.spawn 'ffmpeg', args, detached: false
  ffmpeg.stdout.pipe res;
  
  if debug
    ffmpeg.stderr.on 'data', (data)->
      #res.send data
      console.log 'e:: ' + type + '--' + data 
  
    #ffmpeg.stdout.on 'data', (data)->
      #res.send data
      #console.log 'data::' + data
      #cmdres += data
    
    #ffmpeg.stdout.on 'close', (data)->
      #console.log 'close::' + cmdres
  
  # kill process
  res.on 'close', ()->
    ffmpeg.kill()

  return
    
  
  


#
#
#
exports.webm = (req, res)->
  
  res.contentType 'webm'
  
  if req.params.id is '1'
    rtspURL = 'rtsp://root:chinitossucks@172.19.0.202:554/axis-media/media.amp' + params
  if req.params.id is '2'
    rtspURL = 'rtsp://root:ozhkarsucks@172.19.0.201:9014/axis-media/media.amp' + params
  if req.params.id is '3'
    rtspURL = 'rtsp://root:Koaj6gc6@201.140.175.109:554/axis-media/media.amp' + params
  #
  # Arguments for  webm video
  #
  args = [
    '-i', rtspURL                           # Input command
    '-vcodec', 'libvpx'                     # vp8 encoding
    '-g', '0'                               # All frames are i-frames
    '-me_method' , 'zero'                   # Motion algorithms off
    '-flags2','fast',                       #
    '-preset','ultrafast',                  #
    '-tune','zerolatency',                  #
    '-r', '100'                             # Framerate 
    '-f', 'webm'                            # File format codec
    '-b:v', '1M'                            #
    '-crf', '20'                            # Quality
    'pipe:1'                                # Output on stdout
  ] 
  exec args, res, 'webm', true
  

  
  
#
#
#  
exports.mp4 = (req, res)->
  
  res.contentType 'mp4'
  
  if req.params.id is '1'
    rtspURL = 'rtsp://root:chinitossucks@172.19.0.202:554/axis-media/media.amp' + params
  if req.params.id is '2'
    rtspURL = 'rtsp://root:ozhkarsucks@172.19.0.201:9014/axis-media/media.amp' + params
  if req.params.id is '3'
    rtspURL = 'rtsp://root:Koaj6gc6@201.140.175.109:554/axis-media/media.amp' + params
    
  #
  # Arguments for  mp4 video
  # ffmpeg -i {{}} -vcodec copy -r 100 -f mp4 -movflags frag_keyframe+empty_moov pipe:1
  args = [
    '-i', rtspURL                           # Input command
    '-vcodec', 'copy'                       # copy
    '-r', '100'                             # Framerate 
    '-f', 'mp4'                             # File format codec
    '-movflags', 'frag_keyframe+empty_moov' #
    'pipe:1'                                # Output on stdout
  ] 
  
  exec args, res, 'mp4', true
 
 
  
#
#
#  
exports.ogg = (req, res)->
  
  res.contentType 'ogg'
  
  if req.params.id is '1'
    rtspURL = 'rtsp://root:chinitossucks@172.19.0.202:554/axis-media/media.amp' + params
  if req.params.id is '2'
    rtspURL = 'rtsp://root:ozhkarsucks@172.19.0.201:9014/axis-media/media.amp' + params
  if req.params.id is '3'
    rtspURL = 'rtsp://root:Koaj6gc6@201.140.175.109:554/axis-media/media.amp' + params

  #
  # Arguments for  ogg video
  #
  args = [
    '-i', rtspURL                           # Input command
    '-acodec', 'libvorbis'                  # All frames are i-frames
    '-f' , 'ogg'                            # Motion algorithms off
    'pipe:1'                                # Output on stdout
  ]
  exec args, res, 'ogg', true




#
#
#  
exports.mjpegtomp4 = (req, res)->
  
  res.contentType 'mp4'
  
  rtspURL = 'http://root:1234@190.183.222.194:8101/axis-cgi/mjpg/video.cgi'
  
 
  #
  # Arguments for  webm video
  # ffmpeg -f mjpeg -i {{}} -vcodec copy -r 100 -f mp4 -movflags frag_keyframe+empty_moov pipe:1
  args = [
    '-f', 'mjpeg'                           # 
    '-i', rtspURL                           # Input command
    '-vcodec', 'copy'                     # vp8 encoding
    #'-r', '100'                             # Framerate
    '-f', 'mp4'                           #  
    '-movflags', 'frag_keyframe+empty_moov' #
    'pipe:1'                                # Output on stdout
  ]        
  
  exec args, res, 'mjpegtomp4', false

        
