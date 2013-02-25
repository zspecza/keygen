require 'flour'
{exec} = require 'child_process'

task 'build:coffee', ->
  compile 'src/KeyGen.coffee', 'lib/scripts/keygen.js'
  compile 'src/simulator.coffee', 'lib/scripts/simulator.js'

task 'build:bundle', ->
  bundle [
    'lib/scripts/keygen.js'
    'lib/scripts/simulator.js'
  ], 'keygen.js'

task 'lint', 'checks code compliance', ->
  lint 'src/*.coffee'

task 'build', 'builds the js', ->
  invoke 'build:coffee'
  invoke 'build:bundle'

task 'are:you:a:lie?', 'Tells the truth', ->
  console.log 'I am not a lie, Sincerely, Cake.'

task 'test', 'runs the tests', ->
  exec 'clear && mocha --compilers coffee:coffee-script --reporter spec --colors', (err, stdout, stderr) ->
    console.log stdout + stderr