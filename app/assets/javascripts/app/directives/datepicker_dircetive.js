"use strict";

appModule.directive('bDatepicker', function () {
    return {
      require: '?ngModel',
      restrict: 'A',
      link: function ($scope, element, attrs, controller) {
        var updateModel;
        updateModel = function (ev) {
          element.datepicker('hide');
          element.blur();
          return $scope.$apply(function () {
            return controller.$setViewValue(ev.target.value);
          });
        };
        if (controller != null && element.val().length) {
          controller.$render = function () {
            element.datepicker().data().datepicker.date = controller.$viewValue;
            element.datepicker('setValue');
            element.datepicker('update');
            return controller.$viewValue;
          };
        }
        return attrs.$observe('bDatepicker', function (value) {
          var options;
          options = {};
          if (angular.isObject(value)) {
            options = value;
          }
          if (typeof(value) === "string" && value.length > 0) {
            options = angular.fromJson(value);
          }
          return element.datepicker(options).on('changeDate', updateModel);
        });
      }
    };
  });