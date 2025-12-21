{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.yubikey = {
        enable = mkEnableOption "YubiKey services";
      };
    };

  config =
    let
      cfg = config.planet.yubikey;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      services.pcscd.enable = true;
    };
}
