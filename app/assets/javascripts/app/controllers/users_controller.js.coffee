appModule.controller "UserCtrl", ($scope, $routeParams, User, Friendship, Post) ->

  user_id = $routeParams.user_id

  $scope.user = User.get
    id: user_id

  $scope.posts = Post.query
    user_id: user_id

  $scope.addToFriends = () ->
    Friendship.create
      user_id: user_id
    , {}
    , (response) ->
        $scope.user.friend = "pending"
        #Socket.publish("/friends/notify/" + $scope.user.id, {text: "Hello, world!"});

  $scope.approveToFriends = () ->
    Friendship.save
      user_id: user_id
    ,
      status: 'approve', (response) ->
        $scope.user.friend = "friend"
        #Socket.publish("/friends/notify/" + $scope.user.id, {text: "Hello, world!"});
