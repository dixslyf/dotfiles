{
  vimUtils,
  ...
}:
let
  sources = import ./npins;
  build =
    name: value:
    vimUtils.buildVimPluginFrom2Nix {
      pname = name;
      version = value.revision;
      src = value;
    };
in
builtins.mapAttrs build sources
