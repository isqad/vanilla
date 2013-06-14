angular.module("vanilla.resources", ["ngResource"]).factory("User",($resource) ->
  $resource "/api/users/:id", {}

).factory("Profile",($resource) ->
  $resource "/api/profile", {},
    "save":
      method: "PUT"

).factory("Post",($resource) ->
  $resource "/api/users/:user_id/posts", {},
    "query":
      method: "GET"
      isArray: true

).factory("Search",($resource) ->
  $resource "/api/search", {},
    "query":
      method: "GET"
      isArray: true

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
