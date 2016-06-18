require 'fluentnode'

Leanpub_Book_API = require '../src/Leanpub-Book-API'

class Generate_Book
  constructor: ->
    @.leanpub_Api = new Leanpub_Book_API()

  clean_Manuscript: =>
    using @.leanpub_Api, ->
      console.log @.folder_Manuscript
      @.folder_Manuscript.folder_Delete_Recursive()
      @.folder_Images.folder_Create()

  create_File_Book: =>
    using @.leanpub_Api, ->
      @.folder_Content.path_Combine('Book.txt').file_Copy @.file_Book

  copy_Content_Files: =>
    using @.leanpub_Api, ->
      content_Files = @.folder_Content.files_Recursive('.md')
      for file in content_Files
        file.file_Copy @.folder_Manuscript
      images_Files = @.folder_Content.files_Recursive('.jpeg').concat(@.folder_Content.files_Recursive('.jpg').concat(@.folder_Content.files_Recursive('.png')))

      for file in images_Files
        file.file_Copy @.folder_Images

  create_Preview: (slug, apikey, callback)=>
    url = @.leanpub_Api.url_Api_Preview.replace '{slug}', slug
    data = "api_key=#{apikey}&action=subset"
    #console.log data
    #console.log url
    #console.log url.http_POST
    url.http_POST data, (err, data, res)->
      console.log err
      console.log data
      console.log res.headers.status
      callback data



module.exports = Generate_Book