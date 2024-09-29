{ localFlake', ... }:
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.emacs = {
        enable = mkEnableOption "planet emacs";
        package = mkOption {
          type = types.package;
          default = pkgs.emacs;
          description = "The `emacs` package to use.";
        };
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [ ];
            description = ''
              MIME types to be the default application for.
            '';
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.emacs;
      inherit (lib) mkIf;
      doom-local-dir = "${config.xdg.dataHome}/doom";
    in
    mkIf cfg.enable {
      programs.emacs = {
        inherit (cfg) package;
        enable = true;
      };

      home.packages = with pkgs; [
        # For the `doom` CLI utility.
        # Requires `emacs` to be in `PATH`.
        localFlake'.packages.doomemacs

        # For org-roam.
        sqlite
      ];

      # For byte-compilation and other cache-related stuff.
      # This must be set; otherwise, it defaults to a `.local` directory in the
      # folder `early-init.el` is located, which is not writable since it's in
      # the Nix store.
      home.sessionVariables.DOOMLOCALDIR = doom-local-dir;
      planet.persistence = {
        directories = [ ".local/share/doom" ];
      };

      xdg = {
        configFile = {
          "doom" = {
            source = ./doom;
          };
          "emacs" = {
            source = localFlake'.packages.doomemacs;
            recursive = true;
          };
        };

        mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
          lib.genAttrs cfg.defaultApplication.mimeTypes (_: "emacs.desktop")
        );
      };
    };
}
