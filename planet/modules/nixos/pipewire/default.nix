{ localFlakeInputs, ... }:
{ config
, lib
, ...
}: {
  imports = [ localFlakeInputs.nix-gaming.nixosModules.pipewireLowLatency ];
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.pipewire = {
        enable = mkEnableOption "planet pipewire";
        lowLatency = mkEnableOption "low latency";
      };
    };

  config =
    let
      cfg = config.planet.pipewire;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        lowLatency.enable = cfg.lowLatency;
      };
    };
}

