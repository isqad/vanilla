###
angular.module("vanilla").directive("bDatepicker", () ->
  require: "?ngModel"
  restrict: "A"
  link: ($scope, element, attrs, controller) ->
    updateModel = (ev) ->
      element.datepicker("hide")
      element.blur()
      $scope.$apply () ->
        controller.$setViewValue(ev.target.value)

    if controller? and element.val().length > 0
      controller.$render = () ->
        element.datepicker().data().datepicker.date = controller.$viewValue
        element.datepicker("setValue")
        element.datepicker("update");
        controller.$viewValue

    attrs.$observe("bDatepicker", (value) ->
      options = {}
      if angular.isObject(value)
        options = value

      if typeof value is "string" and value.length > 0
        options = angular.fromJson(value)

      element.datepicker(options).on "changeDate", updateModel
    )
)
###
