{ sources
, bspwm
, ...
}:
bspwm.overrideAttrs (_:
let src = sources.bspwm; in {
  inherit src;
  version = src.revision;
})
