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
      #console.log book_Txt
      book_Txt.assert_Contains ['{frontmatter}', '{mainmatter}'
                                '1.Part-I.md\n',
                                '2.Change-log.md'
                                '0.Why-how-what.md\n'
                                '\n--------------------------\n']

      book_Txt.assert_Not_Contains ['images', '2.Part-II.md\n']

  it 'create', ->
    using new Create_Book_Txt(), ->
      @.leanpub_Api.file_Book.file_Delete()
      @.create()
      @.leanpub_Api.file_Book.assert_File_Exists()

  it 'fix_Md_Extension', ->
    using new Create_Book_Txt(), ->
      @.fix_Md_Extension('2.Part-II'   ).assert_Is '2.Part-II.md'
      @.fix_Md_Extension('2.Part-II.md').assert_Is '2.Part-II.md'

  it 'get_Chapters', ->
    using new Create_Book_Txt(), ->
      part    = @.get_Parts().second()
      section = @.get_Sections(part).first()
      @.get_Chapters(part, section).assert_Contains ['0.Why-how-what.md', 'x.How-this-book-is-built.md', 'x.I-realy-like-angular-1x']

  it 'get_Parts', ->
    using new Create_Book_Txt(), ->
      @.get_Parts().assert_Is [ '0.Frontmatter', '1.Part-I', '2.Part-II' ]
  
  it 'get_Sections', ->
    using new Create_Book_Txt(), ->
      parts = @.get_Parts() 
      @.get_Sections(parts.first()).assert_Contains '2.Change-log.md'
      @.get_Sections(parts.second()).assert_Contains '1.Why-how-what'
  
  it 'original_File',->
    using new Create_Book_Txt(), ->
      @.original_File().assert_Is_False()
      


