angular.module("vanilla.resources", ["ngResource"]).factory("User",($resource) ->
  $resource "/api/users/:id.json", {}

).factory("Profile",($resource) ->
  $resource "/api/profile.json", {},
    "save":
      method: "PUT"

).factory("Post",($resource) ->
  $resource "/api/users/:user_id/posts.json", {},
    "query":
      method: "GET"
      isArray: true

).factory("Search",($resource) ->
  $resource "/api/search.json", {},
    "query":
      method: "GET"
      isArray: true

).factory("Friendship", ($resource) ->
  $resource "/api/users/:user_id/friendship.json", {},
    "query":
      method: "GET"
      isArray: true
    "save":
      method: "PUT"
    "create":
      method: "POST"

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
