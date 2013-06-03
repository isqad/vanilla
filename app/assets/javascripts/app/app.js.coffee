angular.module "ui.directives", []
angular.module "ui", ["ui.directives"]

window.appModule = angular.module "vanilla", ["vanilla.resources", "ui"]

appModule.config ($locationProvider) ->
  $locationProvider.hashPrefix("!")

appModule.config ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")

appModule.run ($rootScope, Profile) ->
  $rootScope.notifySize = 0
  # Get current user to global scope
  $rootScope.current_user = Profile.get({}, (response) ->
    # subscribe to friends notify channel
    #Socket.subscribe("/friends/notify/" + $rootScope.current_user.id, function (data) {
    #  $rootScope.notifySize += 1;
    #});
    return
  )
