Generate_Book = require '../src/Generate-Book'

describe 'Generate_Book', ->

  it 'ctor', ->
    using new Generate_Book(), ->
      @.leanpub_Api.constructor.name.assert_Is 'Leanpub_Book_API'

  it 'clean_Manuscript', ->
    using new Generate_Book(), ->
      @.clean_Manuscript()
      @.leanpub_Api.folder_images.assert_Folder_Exists()

  it 'create_File_Book', ->
    using new Generate_Book(), ->
      @.create_File_Book()
      @.leanpub_Api.file_Book.assert_File_Exists()

  it 'copy_Content_Files', ->
    using new Generate_Book(), ->
      @.copy_Content_Files()
      @.leanpub_Api.folder_manuscript.files('.md').assert_Bigger_Than 6

  xit 'create_Preview' , (done)->
    slug  = 'Practical_Jni4Net'
    apikey = '{key}'
    using new Generate_Book(), ->
      @.create_Preview slug, apikey, ->
        console.log 'done'
        done()
