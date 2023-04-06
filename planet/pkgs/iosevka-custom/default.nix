{ pkgs
, iosevka
, spacing ? "normal"
, ...
}:
let
  names =
    if spacing == "normal"
    then [ "custom" "Custom" ]
    else if spacing == "term"
    then [ "term-custom" "Term Custom" ]
    else throw "Unsupported spacing";
  set = builtins.head names;
  set-family = builtins.elemAt names 1;
  plan = pkgs.substituteAll {
    src = ./private-build-plans.toml;
    inherit set set-family spacing;
  };
in
iosevka.override {
  inherit set;
  privateBuildPlan = builtins.readFile plan;
}
