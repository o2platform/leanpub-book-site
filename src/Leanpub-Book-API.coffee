require 'fluentnode'

class Leanpub_Book_API
  constructor: (options)->
    @.options           = options

    @.book_Name         = 'Book_Jira_Risk_Workflow'                          # this needs to be passed as parameter
    @.root_Folder       = wallaby?.localProjectDir || __dirname.path_Combine '..'
    @.target_Folder     = @.root_Folder       .path_Combine 'book'
    @.build_Folder      = @.target_Folder     .path_Combine @.book_Name + "_Build"
    @.folder_Repo       = @.target_Folder     .path_Combine @.book_Name
    @.folder_Content    = @.folder_Repo       .path_Combine 'content'
    @.folder_Manuscript = @.build_Folder      .path_Combine 'manuscript'
    @.folder_Images     = @.folder_Manuscript .path_Combine 'images'
    @.file_Book         = @.folder_Manuscript .path_Combine 'Book.txt'
    @.url_Api_Preview   = 'https://leanpub.com/{slug}/preview.json'


module.exports =   Leanpub_Book_API
