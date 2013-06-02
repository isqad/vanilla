appModule.controller "HomeCtrl", ($scope, Post) ->
  $scope.status_message =
    author_id: $scope.current_user.id
    body: ""

  $scope.posts = Post.query(
    user_id: $scope.current_user.id
  )

  $scope.sendStatus = () ->
    Post.save
      user_id: $scope.current_user.id
    ,
      post: $scope.status_message
    , (response) ->
      $scope.status_message.body = ""
      $scope.posts.unshift response
