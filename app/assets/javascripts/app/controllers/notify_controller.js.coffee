angular.module("vanilla").controller "NotifyCtrl", [ "$scope", "Notification", ($scope, Notification) ->
  $scope.notifications = Notification.query()

]