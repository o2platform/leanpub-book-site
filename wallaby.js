
module.exports = function (wallaby) {

  //console.dir(wallaby)
  process.env.localProjectDir = wallaby.localProjectDir
  console.log('[in Wallaby]');
  return {
    files: [
             'src/**/*.coffee',
             'views/**/*.jade'
           ],

    tests: [
            "test/**/*.coffee"
           ],

    env: {
      type: 'node',
    }
  };
};
