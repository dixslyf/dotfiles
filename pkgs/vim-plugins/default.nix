{ sources
, vimUtils
,
}:
let
  build = name:
    vimUtils.buildVimPluginFrom2Nix rec {
      pname = name;
      version = src.revision;
      src = builtins.getAttr name sources;
    };
  plugins = [ ];
in
builtins.listToAttrs (map
  (p: {
    name = p;
    value = build p;
  })
  plugins)
