"use strict";

angular.module("vanila.resources", ["ngResource"])
  .factory("User", function ($resource) {
    return $resource("/api/users/:id.json", {});
  })
  .factory("Post", function ($resource) {
    return $resource("/api/users/:user_id/posts.json", {}, {
      "query": {method: "GET", isArray: true}
    });
  });
