#!/usr/bin/env coffee

require 'fluentnode'
Generate_Book = require '../src/Generate-Book'

console.log '[Create-Book] Creating local book files'

using new Generate_Book(), ->
  @.clean_Manuscript()
  @.create_File_Book()
  @.copy_Content_Files()

console.log '[Create-Book] File generation complete'
#console.log '[Create-Book] requesting book preview'



