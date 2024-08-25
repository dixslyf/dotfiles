{ iosevka
, spacing ? "normal"
, ...
}:
let
  names =
    if spacing == "normal"
    then [ "Custom" "Custom" ]
    else if spacing == "term"
    then [ "TermCustom" "Term Custom" ]
    else throw "Unsupported spacing";
  set = builtins.head names;
  set-family = builtins.elemAt names 1;
in
iosevka.override {
  inherit set;
  privateBuildPlan = ''
    [buildPlans.Iosevka${set}]
    family = "Iosevka ${set-family}"
    spacing = "${spacing}"
    serifs = "sans"
    noCvSs = true
    exportGlyphNames = true

      [buildPlans.Iosevka${set}.variants]
      inherits = "ss05"

        [buildPlans.Iosevka${set}.variants.design]
        capital-d = "standard-serifless"
        capital-k = "straight-serifless"
        capital-q = "detached-bend-tailed"
        f = "tailed"
        q = "earless-rounded-diagonal-tailed-serifless"
        long-s = "flat-hook-tailed"
        capital-gamma = "serifless"
        zero = "dotted"
        number-sign = "slanted-open"
        ampersand = "upper-open"
        at = "compact"
        dollar = "interrupted-cap"
        percent = "dots"
        bar = "natural-slope"
        lig-neq = "more-slanted"
        lig-equal-chain = "without-notch"
        lig-hyphen-chain = "with-notch"
        lig-double-arrow-bar = "without-notch"
        lig-single-arrow-bar = "without-notch"

      [buildPlans.Iosevka${set}.ligations]
      inherits = "dlig"
      enables = ["hash-hash"]
      disables = [
        "tilde-tilde",
        "underscore-underscore",
        "minus-minus"
      ]
  '';
}
