angular.module("vanilla").config ($routeProvider) ->
  $routeProvider.when("/home",

    templateUrl: "/static/home/index"
    controller: "HomeCtrl"

  ).when("/notify",

    templateUrl: "/static/notifications/index"
    controller: "NotifyCtrl"

  ).when("/messages",

    templateUrl: "/static/messages/index"

  ).when("/profile",

    templateUrl: "/static/profiles/show"
    controller: "ProfileCtrl"

  ).when("/profile/edit",

    templateUrl: "/static/profiles/edit"
    controller: "ProfileEditCtrl"

  ).when("/u/:user_id",

    templateUrl: "/static/users/show"
    controller: "UserCtrl"

  ).when("/u/:user_id/messages/new",

    controller: "MessageCtrl"

  ).when("/search",
    templateUrl: "/static/searches/index"
    controller: "SearchCtrl"

  ).when("/im",
    templateUrl: "/static/discussions/index"
    controller: "DiscussionCtrl"
  ).when("/im/:discussion_id"
    templateUrl: "/static/discussions/show"
    controller: "DiscussionCtrl"
  ).otherwise
    redirectTo: "/home"
