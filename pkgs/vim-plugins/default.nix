{
  inputs,
  vimUtils,
}: let
  build = name:
    vimUtils.buildVimPluginFrom2Nix rec {
      pname = name;
      version = src.lastModifiedDate;
      src = builtins.getAttr name inputs;
    };
  plugins = [];
in
  builtins.listToAttrs (map (p: {
      name = p;
      value = build p;
    })
    plugins)
