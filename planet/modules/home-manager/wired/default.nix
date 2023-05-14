{ localFlakeInputs
, localFlake'
, localFlakeInputs'
, ...
}:

{ config
, lib
, pkgs
, ...
}: {
  imports = [ localFlakeInputs.wired.homeManagerModules.default ];

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
      home.packages = [ localFlake'.packages.iosevka-custom ];

      services.wired = {
        enable = true;
        package = localFlakeInputs'.wired.packages.default;
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
