Create_Book_Txt = require '../src/Create-Book-Txt'

describe 'Generate_Book', ->

  it 'ctor', ->
    using new Create_Book_Txt(), ->
      @.leanpub_Api.constructor.name.assert_Is 'Leanpub_Book_API'
      @.constructor.name.assert_Is 'Create_Book_Txt'
      @.folder_Content.assert_Is @.leanpub_Api.folder_Content
      @.folder_Content.assert_Folder_Exists()

  it 'build', ->
    using new Create_Book_Txt(), ->
      book_Txt = @.build()
      console.log book_Txt.assert_Contains ['Frontmatter.md','Part-I', 'Part-II']
  it 'get_Parts', ->
    using new Create_Book_Txt(), ->
      @.get_Parts().assert_Is [ 'Frontmatter', 'Part-I', 'Part-II' ]
    
  
  it 'original_File',->
    using new Create_Book_Txt(), ->
      @.original_File().assert_Is_False()

