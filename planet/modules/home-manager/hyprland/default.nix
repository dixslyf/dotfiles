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
      planet.hyprland = {
        enable = mkEnableOption "planet Hyprland";
        nvidiaVariables = mkOption {
          type = types.bool;
          description = "Whether to set variables for better Nvidia support.";
          default = false;
        };
      };
    };

  config =
    let
      cfg = config.planet.hyprland;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        wofi
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false; # Must be disabled to use with UWSM.
        extraConfig =
          let
            hyprland-config = pkgs.substituteAll {
              src = ./hyprland.conf;
              setCursor = ''exec-once=hyprctl setcursor "${config.home.pointerCursor.name}" ${toString config.home.pointerCursor.size}'';
              nvidiaVariables = lib.strings.optionalString cfg.nvidiaVariables ''
                env = LIBVA_DRIVER_NAME,nvidia
                env = __GLX_VENDOR_LIBRARY_NAME,nvidia
              '';
            };
          in
          builtins.readFile "${hyprland-config}";
      };
    };
}
