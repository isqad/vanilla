"use strict";

appModule.controller("SearchCtrl", function ($scope, $route, $routeParams, Search) {
  var query;

  query = $routeParams.q;

  if (typeof query !== "undefined" && query.length > 3) {
    $scope.results = Search.query({q: query}, function (result) {
      $scope.search_results = result;
    });
  }
});