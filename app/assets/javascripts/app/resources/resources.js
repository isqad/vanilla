"use strict";

angular.module("vanila.resources", ["ngResource"])
  .factory("User", function ($resource) {
    return $resource("/api/users/:id.json", {});
  })
  .factory("Profile", function ($resource) {
    return $resource("/api/profile.json", {}, {
      "save": {method: "PUT"}
    });
  })
  .factory("Post", function ($resource) {
    return $resource("/api/users/:user_id/posts.json", {}, {
      "query": {method: "GET", isArray: true}
    });
  })
  .factory("Search", function ($resource) {
    return $resource("/api/search.json", {}, {
      "query": { method: "GET", isArray: true }
    });
  })
  .factory("Friendship", function ($resource) {
    return $resource("/api/users/:user_id/friendship.json", {}, {
      "query": { method: "GET", isArray: true },
      "save": { method: "PUT" },
      "create": { method: "POST" }
    })
  })
  .factory("Socket", function ($rootScope) {
    var fayeClient;

    fayeClient = new Faye.Client(window.location.protocol + "//" + window.location.hostname + ":9292/faye")

    return {
      subscribe: function (channel, callback) {
        fayeClient.subscribe(channel, function () {
          var args = arguments;
          $rootScope.$apply(function () {
            callback.apply(fayeClient, args);
          });
        });
      },
      publish: function (channel, data) {
        fayeClient.publish(channel, data);
      }
    };
  });
