app = angular.module("vanilla")
app.controller "UsersShowCtrl", ["$rootScope", "$scope", "$routeParams", "User", "Post", "Friendship", ($rootScope, $scope, $routeParams, User, Post, Friendship) ->

  current_user = $rootScope.current_user
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

  # Add to friendlist
  $scope.addToFriendList = ->
    friendship = new Friendship
    friendship.user_id = user_id

    friendship.create().then (friendship) ->
      User.get(user_id).then (user) ->
        $scope.user = user

  $scope.removeFromFriendList = (friendship_id) ->
    friendship = new Friendship
    friendship.user_id = $scope.user.id
    friendship.id = friendship_id

    friendship.delete().then ->
      User.get(user_id).then (user) ->
        $scope.user = user

  $scope.acceptFriendList = (friendship_id) ->
    friendship = new Friendship
    friendship.user_id = $scope.user.id
    friendship.id = friendship_id
    friendship.state = "accept"

    friendship.update().then (friendship) ->
      User.get(user_id).then (user) ->
        $scope.user = user

  $scope.rejectFriendList = (friendship_id) ->
    friendship = new Friendship
    friendship.user_id = $scope.user.id
    friendship.id = friendship_id
    friendship.state = "reject"

    friendship.update().then (friendship) ->
      User.get(user_id).then (user) ->
        $scope.user = user

]
