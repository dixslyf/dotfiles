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
      planet.yuzu = {
        enable = mkEnableOption "planet yuzu";
      };
    };

  config =
    let
      cfg = config.planet.yuzu;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ yuzu-mainline ];
      planet.persistence = {
        directories = [
          ".config/yuzu"
          ".local/share/yuzu"
        ];
      };
    };
}
