angular.module("vanilla").controller "HomeCtrl", [ "$scope", "Post", ($scope, Post) ->

  current_user = $scope.current_user

  $scope.status_message =
    body: ""

  # Get posts
  Post.query(
    null
  ,
    user_id: current_user.id
  ).then (posts) ->
    $scope.posts = posts

  #$scope.friends = Friendship.query
  #  user_id: current_user.id

  # Create post
  $scope.sendStatus = ->

    post = new Post(
      post: $scope.status_message
    )
    post.user_id = current_user.id

    post.create().then (post) ->
      $scope.status_message.body = ""
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
]