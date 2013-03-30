"use strict";

var appModule = angular.module("vanila", ["vanila.resources"]);

appModule.config(function ($locationProvider) {
  $locationProvider.hashPrefix("!");
});

appModule.config(function ($httpProvider) {
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content");
});