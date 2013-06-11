appModule.controller "HomeCtrl", ($scope, Post, Friendship) ->

  current_user = $scope.current_user

  $scope.status_message =
    author_id: current_user.id
    body: ""

  $scope.posts = Post.query
    user_id: current_user.id

  $scope.friends = Friendship.query
    user_id: current_user.id

  $scope.sendStatus = () ->
    Post.save
      user_id: $scope.current_user.id
    ,
      post: $scope.status_message
    , (response) ->
      $scope.status_message.body = ""
      $scope.posts.unshift response
