angular.module("vanilla").directive "messageBox", ($http, $compile) ->
  restrict: "CA"
  scope:
    oncomplete: "&"
    onopen: "&"
    friends: "=colorboxFriends"
    user: "=colorboxUser"
    discussion: "=colorboxDiscussion"
    sendMessage: "=colorboxSendMessage"
  link: (scope, element, attrs) ->

    optionsObj =
      title: attrs.title || false

    if scope.oncomplete && attrs.oncomplete
      optionsObj.onComplete = () ->
        scope.$apply ->
          scope.oncomplete {}

    if scope.onopen && attrs.onopen
      optionsObj.onOpen = () ->
        scope.$apply ->
          scope.onopen {}

    element.on "click", (event) ->
      event.preventDefault()

      $http.get(attrs.href).success (data) ->

        optionsObj.html = $compile(data)(scope)

        $.colorbox optionsObj
