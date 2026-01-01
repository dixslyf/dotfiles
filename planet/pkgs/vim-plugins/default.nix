{
  lib,
  vimUtils,
  ...
}:
let
  sources = lib.filterAttrs (name: _value: name != "__functor") (import ./npins);
  build =
    name: value:
    vimUtils.buildVimPlugin {
      pname = name;
      version = value.revision;
      src = value;
    };
in
builtins.mapAttrs build sources
