angular.module("vanilla").controller "ProfileCtrl", ($scope) ->
  return

angular.module("vanilla").controller "ProfileEditCtrl", ($scope, $http) ->
  $scope.dateOptions =
    format: "dd-mm-yyyy"

  $scope.save = () ->
    $http.put("/api/profile.json",
      profile: $scope.current_user
    ).success (response) ->
      $(document).flash_message
        text: "Profile was updated"

  $scope.uploadFinished = (event, data) ->

    $scope.current_user.avatar = data.result.image

    $(document).flash_message
      text: "You look amazing"

    $scope.upload_progress = 0

  $scope.uploadProgress = (event, data) ->
    progress = parseInt(data.loaded / data.total * 100, 10)

    $scope.upload_progress = progress

  $scope.uploadFailed = (event, data) ->
    $(document).flash_message
      text: "Failed upload"

    $scope.upload_progress = 0


