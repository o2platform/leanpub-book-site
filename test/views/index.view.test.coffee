Local_Site = require '../../src/Local-Site'

describe 'index (view)', ->

  local_Site = null

  beforeEach ->
    using new Local_Site(), ->
      local_Site = @
      @.port+= 1000.random()
      @.express_Setup()
      @.start()

  afterEach (done)->
    local_Site.stop done

  it 'check content', (done)->
    using local_Site, ->
      @.url_Server_GET '/', (html, $)=>
        $('title').html().assert_Is 'Practical Book'
        $('html head link').attr().assert_Is { rel: 'stylesheet', href: '/css/bootstrap.css' }
        @.url_Server_GET $('html head link').attr().href, (data)->
          data.assert_Contains 'Bootstrap v3.3.6'
          done()
