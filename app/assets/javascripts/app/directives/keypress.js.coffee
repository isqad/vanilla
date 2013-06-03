angular.module("ui.directives").factory "keypressHelper", ["$parse", keypress = ($parse) ->
  keysByCode =
    8: "backspace"
    9: "tab"
    13: "enter"
    27: "esc"
    32: "space"
    33: "pageup"
    34: "pagedown"
    35: "end"
    36: "home"
    37: "left"
    38: "up"
    39: "right"
    40: "down"
    45: "insert"
    46: "delete"

  capitaliseFirstLetter = (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)

  (mode, scope, elm, attrs) ->
    params = scope.$eval(attrs['ui' + capitaliseFirstLetter(mode)])
    combinations = []

    angular.forEach params, (v, k) ->
      combination = undefined
      expression = $parse(v)

      angular.forEach k.split(" "), (variation) ->
        combination =
          expression: expression
          keys: {}

        angular.forEach variation.split("-"), (value) ->
          combination.keys[value] = true

        combinations.push combination

    elm.bind mode, (event) ->
      altPressed = !!(event.metaKey || event.altKey)
      ctrlPressed = !!event.ctrlKey
      shiftPressed = !!event.shiftKey
      keyCode = event.keyCode

      keyCode -= 32 if mode is "keypress" and not shiftPressed and keyCode >= 97 and keyCode <= 122

      angular.forEach combinations, (combination) ->
        mainKeyPressed = combination.keys[keysByCode[event.keyCode]] or combination.keys[event.keyCode.toString()]

        altRequired = !!combination.keys.alt
        ctrlRequired = !!combination.keys.ctrl
        shiftRequired = !!combination.keys.shift

        if mainKeyPressed and altRequired == altPressed and ctrlRequired == ctrlPressed and shiftRequired == shiftPressed
          scope.$apply ->
            combination.expression scope,
              "$event": event
]

angular.module("ui.directives").directive "uiKeydown", ["keypressHelper", (keypressHelper) ->
  link: (scope, elm, attrs) ->
    keypressHelper "keydown", scope, elm, attrs
]

angular.module("ui.directives").directive "uiKeypress", ["keypressHelper", (keypressHelper) ->
  link: (scope, elm, attrs) ->
    keypressHelper "keypress", scope, elm, attrs
]

angular.module("ui.directives").directive "uiKeyup", ["keypressHelper", (keypressHelper) ->
  link: (scope, elm, attrs) ->
    keypressHelper "keyup", scope, elm, attrs
]
