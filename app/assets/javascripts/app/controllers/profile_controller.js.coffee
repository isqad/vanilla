appModule.controller "ProfileCtrl", ($scope) ->
  return

appModule.controller "ProfileEditCtrl", ($scope, $http) ->
  $scope.dateOptions =
    format: "dd-mm-yyyy"

  $scope.save = () ->
    $http.put("/api/profile.json",
      profile: $scope.current_user
    ).success (response) ->
      $(document).flash_message
        text: "Profile was updated"

  $scope.uploadFinished = (event, data) ->
    img = data.result.image

    avatar =
      small: img.small
      medium: img.medium
      large: img.large

    $scope.$apply () ->
      $scope.current_user.avatar = avatar

    $(document).flash_message
      text: "You look amazing"

  $scope.uploadProgress = (event) ->
    console.log(event)
    progress = parseInt(event.loaded / event.total * 100, 10)

    $scope.$apply () ->
      $scope.upload_progress = progress


