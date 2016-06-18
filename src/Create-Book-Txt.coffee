require 'fluentnode'

Leanpub_Book_API = require '../src/Leanpub-Book-API'

class Create_Book_Txt
  constructor: ->
    @.leanpub_Api      = new Leanpub_Book_API()
    @.folder_Content   = @.leanpub_Api.folder_Content

  build: ()=>
    book_Txt = ""
    for part in @.get_Parts()
      book_Txt += "#{part}.md\n"
    book_Txt

  create: ()=>
    @.leanpub_Api.folder_Manuscript.folder_Create()
    book_Txt_Contents = @.build()    
    book_Txt_Contents.save_As @.leanpub_Api.file_Book 

  get_Parts: ->
    @.folder_Content.folders().file_Names()
    
  get_Sections: (part)->
    part_Path = @.folder_Content.path_Combine part
    sections = part_Path.folders().file_Names()
    if sections.empty()
      return part_Path.files().file_Names()
    return sections

  get_Chapters: (section)->
    
  mappings_For_Frontmatter: ->
    frontmatter_Folder = @.folder_Content.path_Combine 'Frontmatter'
    if frontmatter_Folder.folder_Exists()
      ""
        
    
  original_File: ->
    original_File = @.leanpub_Api.folder_Content.path_Combine 'Book.txt'
    original_File.file_Exists()

  target_File: ->
    @.leanpub_Api.file_Book

  sort_Names: (names)->
    names = ['1.abc','2.vvv','4.aaaa','3.ccc','12.asd','111.asd','10.aaa']
    map = {}
    for name in names
      key = name.split('.').first()
      map[key] = name

    console.log map.keys()
    
module.exports = Create_Book_Txt