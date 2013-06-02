appModule.filter "timeAgo", () ->
  (date) ->
    jQuery.timeago(date)
