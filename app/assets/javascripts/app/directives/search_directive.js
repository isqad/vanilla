"use strict";

appModule.directive("onSearch", function ($location) {
  return function (scope, element, attrs) {
    element.bind("keydown keypress", function (event) {
      if (event.which === 13 && element.val().length > 3) {
        var query;

        query = element.val();

        scope.$apply(function (){
          //redirect to search with pass parameters
          $location.url("/search?q=" + query)
        });

        event.preventDefault();
      }
    });
  };
});