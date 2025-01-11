{
  vimUtils,
  ...
}:
let
  sources = import ./npins;
  build =
    name: value:
    vimUtils.buildVimPlugin {
      pname = name;
      version = value.revision;
      src = value;
    };
in
builtins.mapAttrs build sources
