require 'fluentnode'

Leanpub_Book_API = require '../src/Leanpub-Book-API'

class Create_Book_Txt
  constructor: ->
    @.leanpub_Api      = new Leanpub_Book_API()
    @.folder_Content   = @.leanpub_Api.folder_Content

  build: ()=>
    book_Txt = ""
    for part in @.get_Parts()      
      if part is '1.Frontmatter'
        book_Txt += '{frontmatter}\n\n'
        for section in @.get_Sections(part)
          book_Txt += section + '\n'
        book_Txt += '\n{mainmatter}\n'
      else
        book_Txt += '\n--------------------------\n'
        book_Txt += @.get_Part_File_Name(part) + '\n'
        book_Txt += '--------------------------\n'
        for section in @.get_Sections(part)
          book_Txt += "\n\n#{section}\n\n"
          for chapter in @.get_Chapters(part, section)
            continue if chapter is 'images'
            book_Txt += chapter + '\n'
      book_Txt += '\n'

      #console.log book_Txt
    book_Txt 

  create: ()=>
    @.leanpub_Api.folder_Manuscript.folder_Create()
    book_Txt_Contents = @.build()    
    book_Txt_Contents.save_As @.leanpub_Api.file_Book

  get_Part_File_Name: (part)->
    if part.file_Extension() is '.md'
      return part
    else
      #index = part.split('.').first()
      #file_Name = part.replace(index, '0')
      return part + '.md'

  get_Chapters: (part, section)->
    section_Path = @.folder_Content.path_Combine part
                                   .path_Combine section
    chapters = section_Path.files().concat section_Path.folders()    
    chapters.file_Names()

  get_Parts: ->
    @.folder_Content.folders().file_Names()
    
  get_Sections: (part)->
    part_Path = @.folder_Content.path_Combine part
    sections = part_Path.folders().file_Names()
    if sections.empty()
      part_Path.files().file_Names()
    else
      return sections
    
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