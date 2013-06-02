appModule.controller "UserCtrl", ($scope, $routeParams, User, Friendship) ->
  $scope.user = User.get
    id: $routeParams.user_id

  $scope.addToFriends = () ->
    Friendship.create
      user_id: $scope.user.id
    , {}
    , (response) ->
      $scope.user.friend = "pending"
  #Socket.publish("/friends/notify/" + $scope.user.id, {text: "Hello, world!"});

  $scope.approveToFriends = () ->
    Friendship.save
      user_id: $scope.user.id
    ,
      status: 'approve', (response) ->
      $scope.user.friend = "friend"
#Socket.publish("/friends/notify/" + $scope.user.id, {text: "Hello, world!"});
