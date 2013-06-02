appModule.config ($routeProvider) ->
  $routeProvider.when("/home",

    templateUrl: "/static/home"
    controller: "HomeCtrl"

  ).when("/notify",

    templateUrl: "/static/notify"
    controller: "NotifyCtrl"

  ).when("/messages",

    templateUrl: "/static/messages"

  ).when("/profile",

    templateUrl: "/static/profile"
    controller: "ProfileCtrl"

  ).when("/profile/edit",

    templateUrl: "/static/profile_edit"
    controller: "ProfileEditCtrl"

  ).when("/u/:user_id",

    templateUrl: "/static/user"
    controller: "UserCtrl"

  ).when("/search",
    templateUrl: "/static/search"
    controller: "SearchCtrl"

  ).otherwise
    redirectTo: "/home"
