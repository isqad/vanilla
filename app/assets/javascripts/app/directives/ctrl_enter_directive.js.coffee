appModule.directive "onCtrlEnter", () ->
  (scope, element, attrs) ->
    element.on "keydown keypress", (event) ->
      if event.which == 13 and event.ctrlKey
        scope.$apply () ->
          scope.$eval attrs.onCtrlEnter

        event.preventDefault()
