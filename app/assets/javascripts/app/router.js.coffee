appModule.config ($routeProvider) ->
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

  ).when("/search",
    templateUrl: "/static/searches/index"
    controller: "SearchCtrl"

  ).otherwise
    redirectTo: "/home"
