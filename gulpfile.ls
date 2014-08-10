require! <[gulp gulp-util express connect-livereload tiny-lr gulp-livereload path gulp-compass gulp-jade gulp-open]>

app = express!
lr = tiny-lr!

build_path = '_public'

gulp.task 'css', ->
    gulp.src 'sass/*.sass'
        .pipe gulp-compass {sass: 'sass', sourcemap: 'ture'}
        .pipe gulp.dest "#{build_path}/css"
        .pipe gulp-livereload lr

gulp.task 'html', ->
    gulp.src '*.jade'
        .pipe gulp-jade!
        .pipe gulp.dest "#{build_path}"
        .pipe gulp-livereload lr

gulp.task 'assets', ->
    gulp.src 'assets/**/*'
        .pipe gulp.dest "#{build_path}/assets"
        .pipe gulp-livereload lr

gulp.task 'js', ->
    gulp.src 'js/*.js'
        .pipe gulp.dest "#{build_path}/js"
        .pipe gulp-livereload lr

gulp.task 'server', ->
    app.use connect-livereload!
    app.use express.static path.resolve "#build_path"
    app.listen 3000
    gulp-util.log 'listening on port 3000'

gulp.task 'watch', ->
    lr.listen 35729, ->
        return gulp-util.log it if it
    gulp.watch 'sass/*.sass', <[css]>
    gulp.watch '*.jade', <[html]>
    gulp.watch 'js/*js', <[js]>

gulp.task 'build', <[html css js assets]>
gulp.task 'dev', <[build server watch]>
gulp.task 'default', <[build]>
