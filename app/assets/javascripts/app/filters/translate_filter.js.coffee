angular.module("vanilla").filter "translate", ->
  (word) ->
    I18n.t(word)