Leanpub_Book_API = require '../src/Leanpub-Book-API'

describe 'Leanpub_Book_API', ->
  it 'ctor', ->
    Leanpub_Book_API.assert_Is_Function()
    using new Leanpub_Book_API(), ->
      @.folder_repo                     .assert_Folder_Exists()
      @.folder_repo.path_Combine('.git').assert_Folder_Exists()
      @.folder_content                  .assert_Folder_Exists()
      @.folder_manuscript               .assert_Folder_Exists()
      @.file_Book                       .assert_File_Exists()


