angular.module "ui.directives", []
angular.module "ui", ["ui.directives"]

appModule = angular.module "vanilla", ["vanilla.resources", "ui"]

appModule.config ["$locationProvider", "$httpProvider", "railsSerializerProvider", ($locationProvider, $httpProvider, railsSerializerProvider) ->
  $locationProvider.hashPrefix("!")
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")

  railsSerializerProvider.underscore((v) ->
    v
  ).camelize((v) ->
    v
  )
]


appModule.run [ "$rootScope", "Profile", ($rootScope, Profile) ->
  $rootScope.notifySize = 0
  # Get current user to global scope

  Profile.get().then (user) ->
    $rootScope.current_user = user

  # subscribe to friends notify channel
  #Socket.subscribe("/friends/notify/" + $rootScope.current_user.id, function (data) {
  #  $rootScope.notifySize += 1;
  #});
]