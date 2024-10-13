{ localFlakeInputs, ... }:
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ localFlakeInputs.hyprland.homeManagerModules.default ];

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
        swaybg
        grim
        slurp
        swappy
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        package = null; # Required to use the NixOS module to install hyprland
        recommendedEnvironment = false; # If `true`, `NIXOS_OZONE_WL` is set to 1, but most packages that require already set it for themselves
        # Use extraConfig so that the hyprland flake still adds in the lines for systemd integration
        extraConfig =
          let
            hyprland-config = pkgs.substituteAll {
              src = ./hyprland.conf;
              setCursor = ''exec-once=hyprctl setcursor "${config.home.pointerCursor.name}" ${toString config.home.pointerCursor.size}'';
              nvidiaVariables = lib.strings.optionalString cfg.nvidiaVariables ''
                env = LIBVA_DRIVER_NAME,nvidia
                env = XDG_SESSION_TYPE,wayland
                env = GBM_BACKEND,nvidia-drm
                env = __GLX_VENDOR_LIBRARY_NAME,nvidia
                env = WLR_NO_HARDWARE_CURSORS,1
              '';
              workspaceBindings =
                let
                  keys = [
                    "grave"
                    "1"
                    "2"
                    "3"
                    "4"
                    "5"
                    "6"
                    "7"
                    "8"
                    "9"
                    "0"
                    "minus"
                    "equal"
                    "q"
                    "w"
                    "e"
                    "r"
                    "t"
                    "y"
                    "u"
                    "i"
                    "o"
                    "p"
                    "bracketleft"
                    "bracketright"
                    "backslash"
                    "a"
                    "s"
                    "d"
                    "f"
                    "g"
                    "h"
                    "j"
                    "k"
                    "l"
                    "semicolon"
                    "apostrophe"
                    "z"
                    "x"
                    "c"
                    "v"
                    "b"
                    "n"
                    "m"
                    "comma"
                    "period"
                    "slash"
                  ];
                in
                "\n"
                + builtins.concatStringsSep "\n" (
                  builtins.map (
                    key:
                    let
                      keyUpper = lib.strings.toUpper key;
                    in
                    ''
                      bind = ,${key},moveworkspacetomonitor,name:${keyUpper} current
                      bind = ,${key},workspace,name:${keyUpper}
                      bind = SHIFT,${key},movetoworkspacesilent,name:${keyUpper}
                    ''
                  ) keys
                );
            };
          in
          builtins.readFile "${hyprland-config}";
      };
    };
}
