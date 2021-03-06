module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    connect:
      server:
        options:
          port: 8080
          base: './dist'
          keepalive: true
    watch:
      scripts:
        files: ['src/scripts/**/*.coffee', 'lib/scripts/**/*.coffee']
        tasks: ['browserify']
      templates:
        files: [
          'src/templates/**/*.mustache'
          'lib/templates/**/*.mustache'
        ]
        tasks: ['hogan', 'browserify']
      stylesheets:
        files: [
          'src/stylesheets/**/*.less'
          'node_modules/backbone/less/*'
          'lib/stylesheets/**/*.less'
        ]
        tasks: ['less']
      livereload:
        files: ['dist/main.css']
        options:
          livereload: true
    hogan:
      main:
        dest: 'src/templates/templates.js'
        src: 'src/templates/**/*.mustache'
      lib:
        dest: 'lib/templates/templates.js'
        src: 'lib/templates/**/*.mustache'
      options:
        commonJsWrapper: true
        defaultName: (filename) -> 
          filename
            .replace('src/templates/', '')
            .replace('lib/templates/', '')
            .replace('.mustache', '')
    less:
      main:
        files:
          'dist/main.css': 'src/stylesheets/main.less'
    browserify:
      shipping:
        src: 'src/scripts/shipping.coffee'
        dest: 'dist/shipping.js'
      options:
        transform: ['coffeeify']
        debug: true

  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-browserify')
  grunt.loadNpmTasks('grunt-contrib-hogan')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-notify')
  
  # Default task(s).
  grunt.registerTask('default', ['less', 'hogan', 'browserify'])
