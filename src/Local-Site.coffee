require 'fluentnode'
express = require 'express'
cheerio = require 'cheerio'
marked  = require('marked');

Leanpub_Book_API = require '../src/Leanpub-Book-API'

class Local_Site
  constructor: ->
    @.leanpub_Api = new Leanpub_Book_API()
    @.app         = null
    @.server      = null
    @.port        = 8181

  express_Setup: =>
    @.app = new express()
    @.app.use express.static @.leanpub_Api.folder_content
    @.app.use '/css', express.static @.leanpub_Api.folder_repo + '/editor-ui/bower_components/bootstrap/dist/css'
    @.app.set 'views', @.leanpub_Api.folder_repo + '/editor-ui/views'
    @.app.set 'view engine', 'jade'
    @.map_Routes()

  map_Routes: =>
    render = (res, file_Name)=>
      file_Path = @.leanpub_Api.folder_content + file_Name
      if file_Name.file_Extension() is '.jpg' or file_Name.file_Extension() is '.png'
        return res.sendFile file_Path.real_Path()

      files =
        for file in @.leanpub_Api.folder_content.files_Recursive()
          if file.file_Extension() and ['.jpg', '.png', '.DS_Store'].not_Contains file.file_Extension()
            file.remove(@.leanpub_Api.folder_content.real_Path())

      if file_Name.file_Extension() is '.txt'
        content = '<pre>' + file_Path.file_Contents() + '</pre>'
      else
        content = marked(file_Path.file_Contents())

      viewModel =
        title  : file_Name
        files  : files
        content: content

      res.render 'index', viewModel

    @.app.get '/', (req, res)=>
      render res, '/README.md'

    @.app.get '/content/*', (req, res)=>
      render res, req.url.after('/content')

  start: =>
    @.server = @.app.listen(@.port)

  stop: (callback)=>
    @.server.close =>
      @.server = null
      callback()

  url_Server: ()->
    "http://localhost:#{@.port}"

  url_Server_GET: (path, callback)=>
    @.url_Server().add(path).GET (data)->
      callback data, cheerio.load(data)

module.exports = Local_Site