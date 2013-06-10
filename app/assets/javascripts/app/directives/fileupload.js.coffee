appModule.directive "fileupload", () ->
  restrict: "A"
  scope:
    done: "&"
    progressall: "&"
  link: (scope, element, attrs) ->
    opts =
      dataType: "json"
      autoUpload: true
      maxNumberOfFiles: 1
      formData:
        "set_profile_photo": true

    if scope.done
      opts.done = () ->
        scope.$apply () ->
          scope.done
            event: event
            data: data

    if scope.progressall
      opts.progressall = () ->
        scope.$apply () ->
          scope.progressall
            event: event

    element.fileupload(opts)
