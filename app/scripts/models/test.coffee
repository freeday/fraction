define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class TestModel extends Backbone.Model
    defaults:
      numerator_first: 1
      numerator_second: 2
      denominator_first: 3
      denominator_second: 7

    getDenominatorGeneral: -> @get('denominator_first') * @get('denominator_second')
    getNumeratorFirst: -> @get('numerator_first') * @get('denominator_second')
    getNumeratorSecond: -> @get('numerator_second') * @get('denominator_first')
    getNumeratorFinaly: -> @getNumeratorFirst() + @getNumeratorSecond()

    initialize: -> do @setAttr

    setAttr: ->
      @set
        factor_first: @get('denominator_second')
        factor_second: @get('denominator_first')
        new_numerator_first: do @getNumeratorFirst
        new_numerator_second: do @getNumeratorSecond
        denominator_general: do @getDenominatorGeneral
        finaly_numerator: do @getNumeratorFinaly
        denominator_finaly: do @getDenominatorGeneral

    set: (attrs, options={validate: true}) ->
      super attrs, options

    validate: (attrs) =>
      if attrs.factor_first isnt attrs.denominator_second
        'Введите знаменатель второй дроби'
      else if attrs.factor_second isnt attrs.denominator_first
        'Введите знаменатель первой дроби'
      else if attrs.new_numerator_first isnt do @getNumeratorFirst
        'Умножь ' + attrs.numerator_first + ' на ' + attrs.denominator_second
      else if attrs.new_numerator_second isnt do @getNumeratorSecond
        'Умножь ' + attrs.numerator_second + ' на ' + attrs.denominator_first
      else if attrs.finaly_numerator isnt do @getNumeratorFinaly
        'Сложи числители'
      else if attrs.denominator_general isnt do @getDenominatorGeneral
        'Умножь ' + attrs.denominator_first + ' на ' + attrs.denominator_second
      else if attrs.denominator_finaly isnt do @getDenominatorGeneral
        'Запиши знаменеталь'
