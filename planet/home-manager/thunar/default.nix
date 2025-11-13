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
      uca = pkgs.replaceVars ./uca.xml {
        startInDirectoryScript = pkgs.writeShellScript "exec-terminal-in-directory" config.planet.default-terminal.startInDirectoryCommand;
      };
      # Remove the `thunar` user service that is activated by D-Bus.
      #
      # Unfortunately, it's not as straightforward. `pkgs.xfce.thunar` uses
      # `symlinkJoin` when there are plugins. Under the hood, `symlinkJoin`
      # uses `runCommand`, which uses the `buildCommand` argument to
      # `stdenv.mkDerivation`. Annoyingly, `buildCommand` disables the
      # usual phases, so we cannot simply override `postInstall` or any other
      # phase attribute. Instead, we have to override `buildCommand` itself.
      # More context is available in the comment below:
      # https://github.com/NixOS/nixpkgs/issues/66826#issuecomment-1675224338
      thunar =
        (pkgs.xfce.thunar.override {
          thunarPlugins = [ pkgs.xfce.thunar-archive-plugin ];
        }).overrideAttrs
          (previousAttrs: {
            buildCommand = previousAttrs.buildCommand + ''
              rm "$out/share/systemd/user/thunar.service"
              rmdir "$out/share/systemd/user"
              rmdir "$out/share/systemd"
            '';
          });
    in
    mkIf cfg.enable {
      home.packages = [ thunar ];
      xdg.configFile."Thunar/uca.xml".source = uca;
      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "thunar.desktop")
      );
    };
}
