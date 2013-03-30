"use strict";

appModule.filter("timeAgo", function () {
  return function (date) {
    return jQuery.timeago(date);
  };
});