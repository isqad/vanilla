angular.module("vanilla").controller "UsersShowCtrl", ($scope, $routeParams, User, Post) ->

  current_user = $scope.current_user
  user_id = $routeParams.user_id

  $scope.message_wall =
    body: ""

  # Get user
  User.get(user_id).then (user) ->
    $scope.user = user

    # Get posts
    Post.query(
      null
    ,
      user_id: user_id
    ).then (posts) ->
      $scope.posts = posts

  # Send wall post
  $scope.sendWallMessage = ->
    post = new Post(
      post: $scope.message_wall
    )
    post.user_id = user_id

    post.create().then (post) ->
      $scope.message_wall.body = ""
      $scope.posts.unshift post

  # Delete post
  $scope.removePost = (post) ->
    post.remove().then (post) ->
      $scope.posts = jQuery.map $scope.posts, (item) ->
        item.deleted_at = new Date() if item.id is post.id
        return item

  # Recover post
  $scope.recoverPost = (post) ->
    post.recover().then ->
      $scope.posts = jQuery.map $scope.posts, (item) ->
        item.deleted_at = null if item.id is post.id
        return item

