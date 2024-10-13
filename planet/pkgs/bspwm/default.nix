{
  src,
  bspwm,
  ...
}:
bspwm.overrideAttrs (_: {
  inherit src;
  version = src.revision;
})
