{
  config,
  lib,
  pkgs,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.mullvad-vpn = {
        enable = mkEnableOption "planet mullvad-vpn";
      };
    };

  config =
    let
      cfg = config.planet.mullvad-vpn;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.mullvad-vpn = {
        enable = true;
        package = pkgs.mullvad-vpn;
      };

      planet.persistence = {
        directories = [ "/etc/mullvad-vpn" ];
      };
    };
}
