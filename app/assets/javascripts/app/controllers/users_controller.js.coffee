angular.module("vanilla").controller "UserCtrl", ["$scope", "$routeParams", "User", "Friendship", "Post", "Discussion", ($scope, $routeParams, User, Friendship, Post, Discussion) ->

  current_user = $scope.current_user
  user_id = $routeParams.user_id

  # Get user
  $scope.user = User.get
    id: user_id

  # Get user friends
  $scope.friends = Friendship.query
    user_id: current_user.id
  , (->
    recipient_ids = []
    angular.forEach $scope.friends, (friend) ->
      if friend.id == user_id
        recipient_ids.push(friend)
    # Object of new message for user
    $scope.discussion =
      recipient_ids: recipient_ids
      message: ""
  )

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
      status: "approve", (response) ->
        $scope.user.friend = "friend"
        #Socket.publish("/friends/notify/" + $scope.user.id, {text: "Hello, world!"});

  $scope.sendMessage = () ->
    discussion = $scope.discussion

    discussion.recipient_ids = discussion.recipient_ids.map (element) ->
      return element.id

    discussion.messages_attributes = [
      body: discussion.message
    ]

    delete discussion.message

    Discussion.save {},
      discussion: discussion
    , (response) ->
      console.log response
]