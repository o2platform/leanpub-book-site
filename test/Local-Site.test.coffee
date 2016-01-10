Local_Site = require '../src/Local-Site'

describe 'Local-Site', ->

  local_Site = null

  beforeEach ->
    using new Local_Site(), ->
      local_Site = @
      @.port+= 1000.random()

  afterEach (done)->
    if local_Site.server
      local_Site.stop done
    else
      done()

  it 'constructor', ->
    using new Local_Site(), ->
      @.leanpub_Api.constructor.name.assert_Is 'Leanpub_Book_API'
      assert_Is_Null @.app

  it 'express_Setup', ->
    using local_Site, ->
      @.express_Setup()
      @.app.assert_Is_Not_Null()

  it 'start, stop url_Server', (done)->
    using local_Site, ->
      @.express_Setup()
      @.start()
      console.log @.url_Server()
      @.url_Server().GET (data)=>
        data.assert_Contains '<head>'
        @.stop =>
          @.url_Server().GET (data)=>
            assert_Is_Null data
            done()

  it 'should host content files', (done)->
    using local_Site, ->
      @.express_Setup()
      @.start()
      @.url_Server_GET '/Book.txt', (data)=>
        data.assert_Contains '1.Introduction.md'
        @.url_Server_GET '/css/bootstrap.css', (data)=>
          data.assert_Contains 'Bootstrap v3.3.6'
          @.url_Server_GET '/', (html, $)=>
            #$.html().assert_Is html
            $('title').html().assert_Is_String()
            done()

