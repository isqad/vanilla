"use strict";

appModule.directive("onCtrlEnter", function () {
  return function(scope, element, attrs) {
    element.bind("keydown keypress", function(event) {
      if(event.which === 13  && event.ctrlKey) {
        scope.$apply(function(){
            scope.$eval(attrs.onCtrlEnter);
        });

        event.preventDefault();
      }
    });
  };
});