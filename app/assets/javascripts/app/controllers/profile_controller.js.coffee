angular.module("vanilla").controller "ProfileCtrl", [ "$scope", "$http", ($scope, $http) ->

  $scope.save = ->
    $scope.current_user.$put("/api/profile").then (user) ->
      $scope.current_user = user
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
]