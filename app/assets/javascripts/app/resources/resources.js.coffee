angular.module("vanilla.resources", ["rails"])

angular.module("vanilla.resources").factory("User", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/users"
    name: "user"
])

angular.module("vanilla.resources").factory("Post", ["railsResourceFactory", "railsSerializer", (railsResourceFactory, railsSerializer) ->
  resource = railsResourceFactory
    url: "/api/users/{{user_id}}/posts/{{id}}"
    name: "post"
  resource.prototype.recover = () ->
    resource.$put(@.$url("recover"))
  return resource
])

angular.module("vanilla.resources").factory("Profile", ["railsResourceFactory", "railsSerializer", (railsResourceFactory, railsSerializer) ->
  railsResourceFactory
    url: "/api/profile"
    name: "profile"
    serializer: railsSerializer ->
      @exclude("id", "username", "avatar", "email", "last_response_at")
])

angular.module("vanilla.resources").factory("Friendship", ["railsResourceFactory", (railsResourceFactory) ->
  railsResourceFactory
    url: "/api/users/{{user_id}}/friendships/{{id}}"
    name: "friendship"
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
