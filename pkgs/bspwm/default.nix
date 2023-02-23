{ inputs
, bspwm
, ...
}:
bspwm.overrideAttrs (_: {
  src = inputs.bspwm;
})
