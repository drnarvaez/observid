
_prodPATH = '../../_prod/observid/'

module.exports = (grunt)->
  grunt.initConfig
    
    #
    #
    #
    coffee: 
      # server: 
        # src:  ['server.coffee']
        # dest:  _prodPATH + 'server.js'
      all: 
        expand:  true
        cwd:  './'
        src:  ['**/*.coffee']
        dest:  _prodPATH
        ext:  '.js'
        options: 
          bare:  true
          compress:  true
    
    #
    #
    #
    copy:
      npm:
        options:
          flatten: true
        files:
          '../../_prod/observid/' : 'package.json'
      media:
        files: [
          expand: true
          cwd: './media'
          src: ['**/*.*']
          dest:   _prodPATH + 'media/'
        ]
      clientlibs: 
        files: [
          expand:  true
          cwd: './public/js/libs/'
          src: ['**/*.*']
          dest:  _prodPATH + 'public/js/libs/'
          #ext:  '.min.js'
        ]
   
        
    #
    #
    #
    jade: 
      compile: 
        options: 
          client:  false
          pretty:  true
        files: [
          expand:  true
          cwd:  './views/'
          src:  '**/*.jade'
          dest:  _prodPATH + 'views/'
          ext:  '.html'        
        ]
      

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  
  grunt.registerTask 'default' , ['coffee', 'jade']
  