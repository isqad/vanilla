angular.module("vanilla").controller "UsersIndexCtrl", ($scope, User) ->

  $scope.show_online = false

  # Get users
  User.query().then (users) ->
    $scope.users = users

  $scope.showOnline = (bool) ->
    User.query(
      online: bool
    ).then (users) ->
      $scope.users = users
      $scope.show_online = bool