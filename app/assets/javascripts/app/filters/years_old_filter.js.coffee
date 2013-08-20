angular.module("vanilla").filter "yearsOld", () ->
  (years) ->
    years + " " + I18n.t("profiles.years_old", {count: years}) if years and years > 0