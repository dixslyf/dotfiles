{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.steam = {
        enable = mkEnableOption "planet steam";
      };
    };

  config =
    let
      cfg = config.planet.steam;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
    };
}


