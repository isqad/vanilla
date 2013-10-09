app = angular.module("vanilla")

app.controller "FriendsCtrl", ["$scope", "Friend", ($scope, Friend) ->
  Friend.query().then (friends) ->
    $scope.friend_list = friends
]