appModule.directive "onSearch", ($location) ->
  (scope, element) ->
    element.on "keydown keypress", (event) ->
      if event.which == 13 and element.val().length > 3

        query = element.val()

        scope.$apply () ->
          #redirect to search with pass parameters
          $location.url("/search?q=" + query)

        event.preventDefault()
