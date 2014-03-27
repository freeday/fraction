define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
], ($, _, Backbone, JST) ->
  class TestView extends Backbone.View
    template: JST['app/scripts/templates/test.hbs']

    className: 'container'

    events:
      'input #numerator_first': 'setFactorFirst'
      'input #denominator_first': 'setFactorFirst'
      'input #numerator_second': 'setFactorSecond'
      'input #denominator_second': 'setFactorSecond'
      'input #factorFirst': 'setFractionFirst'
      'input #factorSecond': 'setFractionSecond'
      'input #denomiratorGeneralFirst': 'setGeneralDenominator'
      'input #denomiratorGeneralSecond': 'setGeneralDenominator'
      'input #numeratorFinaly': 'setFinalyNumerator'
      'input #denominatorFinaly': 'setFinalyDenominator'
      'click #yes': 'newFraction'
      'click #no': 'startFraction'

    render: ->
      do @remove
      @delegateEvents @events
      do @model.setAttr
      @$el.html(@template(do @model.toJSON))
      $('body').html @$el

    setFactorFirst: (e) ->
      @model.set factor_first: Number(e.target.value)
      @nextStep(e)
    setFactorSecond: (e) ->
      @model.set factor_second: Number(e.target.value)
      @nextStep(e)
    setFractionFirst: (e) ->
      @model.set new_numerator_first: Number(e.target.value)
      @nextStep(e)
    setFractionSecond: (e) ->
      @model.set new_numerator_second: Number(e.target.value)
      @nextStep(e)
    setGeneralDenominator: (e) ->
      @model.set denominator_general: Number(e.target.value)
      @nextStep(e)
    setFinalyDenominator: (e) ->
      @model.set denominator_finaly: Number(e.target.value)
      @nextStep(e)
    setFinalyNumerator: (e) ->
      @model.set finaly_numerator: Number(e.target.value)
      @nextStep(e)

    nextStep: (e) ->
      @toggleStep e
      switch Number(@$el.find('.valid').length)
        when 4 then @$el.find('#section-first').fadeIn()
        when 8 then @$el.find('#section-finaly').fadeIn()
        when 10 then @$el.find('#confirm').fadeIn()

    toggleStep: (e) ->
      $target = $(e.target)
      $error = @$el.find('.error')
      if !@model.validationError
        $target.attr('disabled', do @model.isValid).addClass('valid').removeClass('novalid')
        $(@$el.find('.novalid')[0])[0]?.disabled = !do @model.isValid
        @$errorTop?.fadeOut() and @$errorBottom?.fadeOut()
        $target.removeClass 'field-error'
      else
        @$errorTop = $($error[0]).text(@model.validationError)
        @$errorBottom = $($error[1]).text(@model.validationError)
        width = do $error.width
        property = _.extend($target.position(), {'margin-left': -width/2})
        $target.addClass 'field-error'
        @toggleError property

    toggleError: (property) ->
      if @$el.find('.valid').length%2 is 0
        @showError property, @$errorTop
      else
        @showError property, @$errorBottom

    showError: (property, el) -> el.fadeIn().css property

    newFraction: ->
      @model.set
        numerator_first: @getRandomArbitary(1, 10)
        numerator_second: @getRandomArbitary(1, 10)
        denominator_first: @getRandomArbitary(1, 10)
        denominator_second: @getRandomArbitary(1, 10)
        {validate: false}
      do @render

    startFraction: ->
      do @model.defaults
      do @render

    getRandomArbitary: (min=1, max=null) ->
      if min? and !max?
        min
      else
        Math.floor(Math.random() * (max - min) + min)
