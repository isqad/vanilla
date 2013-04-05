"use strict";

var appModule;

appModule = angular.module("vanila", ["vanila.resources"]);

appModule.config(function ($locationProvider) {
  $locationProvider.hashPrefix("!");
});

appModule.config(function ($httpProvider) {
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content");
});

// Global parameters
appModule.run(function ($rootScope, Profile, Socket) {
  // Get current user to global scope
  $rootScope.current_user = Profile.get();
});