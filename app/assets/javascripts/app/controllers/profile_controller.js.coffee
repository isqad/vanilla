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

  # Uploading profile photo
  jQuery ($) ->
    $("#fileupload").fileupload
      dataType: "json"
      autoUpload: true
      maxNumberOfFiles: 1
      formData:
        "set_profile_photo": true
      done: (event, data) ->
        img = data.result.image

        avatar =
          small: img.small
          medium: img.medium
          large: img.large

        $("#progressupload").hide()

        $scope.$apply () ->
          $scope.current_user.avatar = avatar

        $(document).flash_message
          text: "You look amazing"
      progressall: (event, data)->
        $("#progressupload").show()

        progress = parseInt(data.loaded / data.total * 100, 10)
        $("#progressupload .bar").css("width", progress + "%")


