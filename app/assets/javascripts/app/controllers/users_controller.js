"use strict";

appModule.controller("UserCtrl", function ($scope, $routeParams, User) {

  $scope.user = User.get({id: $routeParams.user_id});
});