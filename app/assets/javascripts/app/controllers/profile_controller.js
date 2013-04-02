"use strict";

appModule.controller("ProfileCtrl", function ($scope) {

});

appModule.controller("ProfileEditCtrl", function ($scope, $http) {

  $scope.dateOptions = { format: "dd-mm-yyyy" };

  $scope.save = function () {
    $http.put("/api/profile.json", {
      profile: $scope.current_user
    }).success(function (response) {
      $(document).flash_message({text: "Profile was updated"});
    });
  };

  // Uploading profile photo
  $(function (){
    $("#fileupload").fileupload({
      dataType: "json",
      autoUpload: true,
      maxNumberOfFiles: 1,
      formData: {
        "set_profile_photo": true
      },
      done: function (event, data) {
        var img, avatar;

        img = data.result.image;

        avatar = {
          small: img.small,
          medium: img.medium,
          large: img.large
        };

        $("#progressupload").hide();

        $scope.$apply(function () {
          $scope.current_user.avatar = avatar;
        });

        $(document).flash_message({text: "You look amazing"});
      },
      progressall: function (event, data) {
        $("#progressupload").show();

        var progress = parseInt(data.loaded / data.total * 100, 10);
        $("#progressupload .bar").css("width", progress + "%");
      }
    });
  });

});


