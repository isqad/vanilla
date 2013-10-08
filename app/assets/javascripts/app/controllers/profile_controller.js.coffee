angular.module("vanilla").controller "ProfileCtrl", ["$rootScope", "$scope", "$http", ($rootScope, $scope, $http) ->

  $scope.save = ->
    $rootScope.current_user.$put("/api/profile").then (user) ->
      $rootScope.current_user = user
      $(document).flash_message
        text: "Profile was updated"


  $scope.uploadFinished = (event, data) ->

    $rootScope.current_user.avatar = data.result.image

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