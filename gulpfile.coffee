gulp       = require 'gulp'
coffee     = require 'gulp-coffee'
gulpIgnore = require 'gulp-ignore'
debug      = require 'gulp-debug'
watch      = require 'gulp-watch'
plumber    = require('gulp-plumber');
changed    = require('gulp-changed');
jade       = require('gulp-jade');

condition = 'node_modules/**';

gulp.task 'coffee', ()-> 
  #gulp.src ['./src/**/*.coffee']
      #.pipe(gulpIgnore.exclude(condition))
      #.pipe(coffee({bare: true}).on('error', console.log))
  #    .pipe debug({title: 'match:'})
      #.pipe gulp.dest('./public')
      
    gulp.src 'test/**/*.coffee'
        .pipe changed('./public/test', {extension: '.js'})
        .pipe plumber()
        .pipe debug({title: 'before:'})
        .pipe coffee()
        .pipe gulp.dest('./public/test')

gulp.task 'jade',  () ->
    gulp.src('src/**/*.jade')
        .pipe changed('./public', {extension: '.html'})
        .pipe debug({title: 'jade_2:'})
        .pipe jade()
        .pipe gulp.dest('./public')


gulp.task 'watch', ()->
    gulp.watch './test/**/*.coffee', ['coffee']
    gulp.watch './src/**/*.jade', ['jade']

    
gulp.task 'dev', ['coffee', 'jade', 'watch']
      
