require 'fluentnode'

if not process.env.localProjectDir        # handle Wallby hack to find source folder
  process.env.localProjectDir = '.'

class Leanpub_Book_API
  constructor: ->
    @.folder_repo       = process.env.localProjectDir.path_Combine '..'
    @.folder_content    = @.folder_repo              .path_Combine 'content'
    @.folder_manuscript = @.folder_repo              .path_Combine 'manuscript'
    @.folder_images     = @.folder_manuscript        .path_Combine 'images'
    @.file_Book         = @.folder_manuscript        .path_Combine 'Book.txt'
    @.url_Api_Preview   = 'https://leanpub.com/{slug}/preview.json'


module.exports =   Leanpub_Book_API