{ config
, lib
, pkgs
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.thunar = {
        enable = mkEnableOption "planet thunar";
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [ "inode/directory" ];
            description = ''
              MIME types to be the default application for.
            '';
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.thunar;
      inherit (lib) mkIf;
      uca = pkgs.substituteAll {
        src = ./uca.xml;
        startInDirectoryScript = pkgs.writeShellScript "exec-terminal-in-directory" config.planet.default-terminal.startInDirectoryCommand;
      };
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        (xfce.thunar.override { thunarPlugins = [ xfce.thunar-archive-plugin ]; })
      ];
      xdg.configFile."Thunar/uca.xml".source = uca;
      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "thunar.desktop")
      );
    };
}
