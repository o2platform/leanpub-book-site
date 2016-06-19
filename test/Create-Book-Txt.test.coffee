Create_Book_Txt = require '../src/Create-Book-Txt'

describe 'Create-Book-Txt', ->

  it 'ctor', ->
    using new Create_Book_Txt(), ->
      @.leanpub_Api.constructor.name.assert_Is 'Leanpub_Book_API'
      @.constructor.name.assert_Is 'Create_Book_Txt'
      @.folder_Content.assert_Is @.leanpub_Api.folder_Content
      @.folder_Content.assert_Folder_Exists()

  it 'build', ->
    using new Create_Book_Txt(), ->
      book_Txt = @.build()
      book_Txt.assert_Contains ['0.Frontmatter.md\n','0.Part-I.md\n', '0.Part-II.md\n']
              .assert_Contains ['0.Why-how-what.md\n']

  it 'create', ->
    using new Create_Book_Txt(), ->
      @.leanpub_Api.file_Book.file_Delete()
      @.create()
      @.leanpub_Api.file_Book.assert_File_Exists()

  it 'get_Part_File_Name', ->
    using new Create_Book_Txt(), ->
      @.get_Part_File_Name('2.Part-II').assert_Is '0.Part-II.md'
      
  it 'get_Parts', ->
    using new Create_Book_Txt(), ->
      @.get_Parts().assert_Is [ '1.Frontmatter', '2.Part-I', '3.Part-II' ]
  
  it 'get_Sections', ->
    using new Create_Book_Txt(), ->
      parts = @.get_Parts() 
      @.get_Sections(parts.first()).assert_Contains '2.Change-log.md'
      @.get_Sections(parts.second()).assert_Contains '1.Why-how-what'
  
  it 'original_File',->
    using new Create_Book_Txt(), ->
      @.original_File().assert_Is_False()
      


