"use strict";

appModule.controller("ProfileCtrl", function ($scope) {

});

appModule.controller("ProfileEditCtrl", function ($scope, $http) {
  /*$("#inputBirthday").datepicker({
    dateFormat: "dd-mm-yy",
    yearRange: "1950:1999",
    changeYear: true,
    changeMonth: true
  });*/

  $scope.save = function () {
    $http.put("/profile.json", {
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
        $("#progressupload").hide();

        data = data.result.data;

        var avatar = {
          small: data.image.thumb_small.url,
          medium: data.image.thumb_medium.url,
          large: data.image.thumb_large.url
        };

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


