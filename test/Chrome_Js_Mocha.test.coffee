return 
#require 'fluentnode'

describe 'test', ->
  page        = require('../src/Chrome_Js_Mocha').create(before,after)
  base_Folder = '../'.real_Path()

  xit 'abc', (done)->

    page.chrome.open "file:///#{base_Folder}/README.md ",()->
      page.html (html,$)->
        console.log $('title').html()
        done()

  it 'watch test', (done)->
    @timeout 0
    fs = require 'fs'
    target_File = base_Folder.path_Combine 'README.md'



    #fs.watchFile target_File, (eventData)->
    #  "file was changed".log()
    #  page.chrome.open "file:///#{base_Folder}/README.md", ()->

    console.log "Hook set"
    done()
