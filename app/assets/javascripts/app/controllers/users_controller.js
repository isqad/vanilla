"use strict";

appModule.controller("UserCtrl", function ($scope, $routeParams, User, Friendship, Socket) {

  $scope.user = User.get({id: $routeParams.user_id});

  $scope.addToFriends = function () {
    Friendship.create({user_id: $scope.user.id}, {}, function (response) {
      $scope.user.friend = 'pending';
      Socket.publish("/friends/notify/" + $scope.user.id, {text: "Hello, world!"});
    });
  };

  $scope.approveToFriends = function () {
    Friendship.save({user_id: $scope.user.id}, {status: 'approve'}, function (response) {
      $scope.user.friend = 'friend';
      Socket.publish("/friends/notify/" + $scope.user.id, {text: "Hello, world!"});
    });
  };
});