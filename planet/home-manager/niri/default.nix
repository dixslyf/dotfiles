{
  config,
  pkgs,
  lib,
  ...
}@args:
{
  options =
    let
      inherit (lib)
        mkEnableOption
        mkOption
        ;
    in
    {
      planet.niri = {
        enable = mkEnableOption "planet niri";
        extraConfig = mkOption {
          type = lib.types.str;
          default = "";
          description = "Extra configuration to append";
        };
      };
    };

  config =
    let
      cfg = config.planet.niri;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      assertions = [
        {
          assertion = args ? osConfig && args.osConfig.planet.niri.enable;
          message = ''
            `planet.niri` (Home Manager) can only be enabled when using NixOS and `planet.niri.enable = true` (NixOS) on the host configuration.
          '';
        }
      ];

      programs.niri = {
        config = (builtins.readFile ./config.kdl) + "\n" + cfg.extraConfig;
      };

      home.packages = [
        pkgs.xwayland-satellite-unstable
      ];
    };
}
