angular.module("vanilla").controller "SearchCtrl", ["$scope", "$route", "$routeParams", "Search", ($scope, $route, $routeParams, Search) ->
  query = $routeParams.q

  if typeof query isnt "undefined" and query.length > 3
    $scope.results = Search.query
      q: query, (result) ->
        $scope.search_results = result
]