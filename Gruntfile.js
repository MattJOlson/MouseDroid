module.exports = function(grunt){
  grunt.initConfig({
    mochaTest: {
      test: {
        options: {
          reporter: 'spec',
          clearRequireCache: true
        },
        src: ['test/*.js']
      },
    }
  });
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.registerTask('default', ['mocha-test']);
};
