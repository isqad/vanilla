angular.module("vanilla.resources", ["rails"])

app = angular.module("vanilla.resources")

app.factory("User", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/users"
    name: "user"
])

app.factory("Post", ["railsResourceFactory", "railsSerializer", (railsResourceFactory, railsSerializer) ->
  resource = railsResourceFactory
    url: "/api/users/{{user_id}}/posts/{{id}}"
    name: "post"
  resource.prototype.recover = () ->
    resource.$put(@.$url("recover"))
  return resource
])

app.factory("Profile", ["railsResourceFactory", "railsSerializer", (railsResourceFactory, railsSerializer) ->
  railsResourceFactory
    url: "/api/profile"
    name: "profile"
    serializer: railsSerializer ->
      @exclude("id", "username", "avatar", "email", "last_response_at")
])

app.factory("Friendship", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/users/{{user_id}}/friendships/{{id}}"
    name: "friendship"
])

app.factory("Friend", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/friendships"
    name: "friend"
])

app.factory("Discussion", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/discussions"
    name: "discussions"
])


###
).factory("Friendship", ($resource) ->
  $resource "/api/users/:user_id/friendship", {},
    "query":
      method: "GET"
      isArray: true
    "save":
      method: "PUT"
    "create":
      method: "POST"

).factory("Notification", ($resource) ->
  $resource "/api/profile/notifications", {},
    "query":
      method: "GET"
      isArray: true
).factory("Discussion", ($resource) ->
  $resource "/api/discussions", {},
    "query":
      method: "GET"
      isArray: true
).factory("Message", ($resource) ->
  $resource "/api/discussions/:discussion_id/messages", {},
    "query":
      method: "GET"
      isArray: true
)
###
#.factory("Socket", ($resource) ->
# fayeClient = new Faye.Client(window.location.protocol + "//" + window.location.hostname + ":9292/faye")
#
#  subscribe: (channel, callback) ->
#    fayeClient.subscribe channel, () ->
#      args = arguments
#      $rootScope.$apply ->
#        callback.apply fayeClient, args
#  publish: (channel, data) ->
#    fayeClient.publish channel, data
#
#)
