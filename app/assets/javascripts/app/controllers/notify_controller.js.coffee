appModule.controller "NotifyCtrl", ($scope, Notification) ->
  $scope.notifications = Notification.query()
