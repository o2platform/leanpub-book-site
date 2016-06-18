Leanpub_Book_API = require '../src/Leanpub-Book-API'

describe 'Leanpub_Book_API', ->
  it 'ctor', ->
    Leanpub_Book_API.assert_Is_Function()
    using new Leanpub_Book_API(), ->
      @.book_Name         .assert_Is 'Book_Practical_AngularJS'
      @.target_Folder     .assert_Is @.root_Folder      .path_Combine 'book'
      @.folder_Repo       .assert_Is @.target_Folder    .path_Combine @.book_Name
      @.folder_Content    .assert_Is @.folder_Repo      .path_Combine 'content'
      @.folder_Manuscript .assert_Is @.target_Folder    .path_Combine 'manuscript'
      @.folder_Images     .assert_Is @.folder_Manuscript.path_Combine 'images'
      @.file_Book         .assert_Is @.folder_Manuscript.path_Combine 'Book.txt'
      @.url_Api_Preview   .assert_Is 'https://leanpub.com/{slug}/preview.json'

      @.root_Folder                    .assert_Folder_Exists()
      @.root_Folder.path_Combine('src').assert_Folder_Exists()
      @.folder_Repo.path_Combine('.git').assert_Folder_Exists()


