angular.module("ui.directives").directive "uiFileupload", () ->
  restrict: "A"
  link: (scope, element, attrs) ->
    params = scope.$eval(attrs["uiFileupload"])

    defaultOpts = angular.extend params,
      dataType: "json"
      autoUpload: true
      maxNumberOfFiles: 1

    defaultOpts.progressall = (event, data) ->
      scope.$apply ->
        scope.uploadProgress(event, data)

    defaultOpts.done = (event, data) ->
      scope.$apply ->
        scope.uploadFinished(event, data)

    defaultOpts.fail = (event, data) ->
      scope.$apply ->
        scope.uploadFailed(event, data)

    element.fileupload(defaultOpts)
