require 'fluentnode'

Leanpub_Book_API = require '../src/Leanpub-Book-API'

class Generate_Book
  constructor: ->
    @.leanpub_Api = new Leanpub_Book_API()

  clean_Manuscript: =>
    using @.leanpub_Api, ->
      @.folder_manuscript.folder_Delete_Recursive()
      @.folder_images.folder_Create()

  create_File_Book: =>
    using @.leanpub_Api, ->
      @.folder_content.path_Combine('Book.txt').file_Copy @.file_Book

  copy_Content_Files: =>
    using @.leanpub_Api, ->
      content_Files = @.folder_content.files_Recursive('.md')
      for file in content_Files
        file.file_Copy @.folder_manuscript
      images_Files = @.folder_content.files_Recursive('.jpg').concat @.folder_content.files_Recursive('.png')
      for file in images_Files
        file.file_Copy @.folder_images

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