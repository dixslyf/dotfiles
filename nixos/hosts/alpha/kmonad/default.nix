{ inputs
, ...
}: {
  imports = [
    inputs.kmonad.nixosModules.default
  ];

  services.kmonad = {
    enable = true;
    keyboards = {
      duckyOne2Mini = {
        device = "/dev/input/by-id/usb-Ducky_Ducky_One2_Mini_DK-V1.11-190819-event-kbd";
        defcfg.enable = true;
        config = builtins.readFile ./ducky-one-2-mini.kbd;
      };
    };
  };
}
