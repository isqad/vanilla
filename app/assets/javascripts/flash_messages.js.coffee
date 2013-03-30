$ = jQuery

$.fn.extend
  flash_message: (options) ->
    $("<div/>", {id: "notifications"}).html($("<div/>", {class:"text"}).html(options.text)).prependTo(document.body)
    $("#notifications").addClass("expose")