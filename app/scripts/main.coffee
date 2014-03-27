#/*global require*/
'use strict'

require.config
  shim:
    underscore:
      exports: '_'
    backbone:
      deps: [
        'underscore'
        'jquery'
      ]
      exports: 'Backbone'
    handlebars:
      exports: 'Handlebars'
  paths:
    jquery: '../bower_components/jquery/jquery'
    backbone: '../bower_components/backbone/backbone'
    underscore: '../bower_components/underscore/underscore'
    handlebars: '../bower_components/handlebars/handlebars'

require [
  'backbone'
  'models/test'
  'views/test'
], (Backbone, Model, Test) ->
  Backbone.history.start()
  model = new Model
  test = new Test model: model
  do test.render
