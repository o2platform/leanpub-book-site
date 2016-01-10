#!/usr/bin/env coffee

Local_Site = require '../src/Local-Site'

using new Local_Site(), ->
  @.express_Setup()
  @.start()
  console.log "Server started at #{@.url_Server()}"