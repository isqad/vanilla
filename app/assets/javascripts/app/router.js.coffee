angular.module("vanilla").config [ "$routeProvider", ($routeProvider) ->
  $routeProvider.when("/home",

    templateUrl: "/static/home/index"
    controller: "HomeCtrl"

  ).when("/profile",

    templateUrl: "/static/profiles/edit"
    controller: "ProfileCtrl"

  ).when("/users",

    templateUrl: "/static/users/index",
    controller: "UsersIndexCtrl"

  ).when("/users/:user_id",

    templateUrl: "/static/users/show",
    controller: "UsersShowCtrl"

  ).when("/friends",

    templateUrl: "/static/friendships/index"
    controller: "FriendsCtrl"

  ).when("/discussions",
    templateUrl: "/static/discussions/index"
    controller: "DiscussionsIndexCtrl"
  ).otherwise
    redirectTo: "/home"
]