{
  config,
  pkgs,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib)
        mkEnableOption
        ;
    in
    {
      planet.yubikey = {
        enable = mkEnableOption "YubiKey tools";
      };
    };

  config =
    let
      cfg = config.planet.yubikey;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        yubioath-flutter
        yubikey-manager
      ];
    };
}
