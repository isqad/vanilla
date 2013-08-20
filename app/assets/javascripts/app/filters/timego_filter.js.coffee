angular.module("vanilla").filter "timeAgo", () ->
  (date) ->
    jQuery.timeago(date) if date?
