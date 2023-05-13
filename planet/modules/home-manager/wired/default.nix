{ inputs }:
{ config
, lib
, pkgs
, ...
}: {
  imports = [ inputs.wired.homeManagerModules.default ];

  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.wired = {
        enable = mkEnableOption "planet wired";
        systemd = {
          target = mkOption {
            type = types.str;
            default = "graphical-session.target";
            description = "The systemd target that will automatically start the wired service.";
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.wired;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ pers-pkgs.iosevka-custom ];

      services.wired = {
        enable = true;
        config = pkgs.substituteAll {
          src = ./wired.ron;
        };
      };

      services.sxhkd = {
        keybindings = {
          "super + n" = "wired -s 1"; # Show the last notification
        };
      };

      systemd.user.services.wired = {
        Unit.After = lib.mkForce [ cfg.systemd.target ];
        Unit.PartOf = lib.mkForce [ cfg.systemd.target ];

        Install.WantedBy = lib.mkForce [ cfg.systemd.target ];
      };
    };
}
