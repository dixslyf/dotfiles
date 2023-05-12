{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.gpg-agent = {
        enable = mkEnableOption "planet gpg-agent";
      };
    };

  config =
    let
      cfg = config.planet.gpg-agent;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.gpg-agent = {
        enable = true;
        enableFishIntegration = config.planet.fish.enable;
        enableSshSupport = true;
      };
    };
}
