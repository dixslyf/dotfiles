{ config
, lib
, pkgs
, inputs
, ...
}: {
  imports = [ inputs.hyprland.homeManagerModules.default ];

  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.hyprland = {
        enable = mkEnableOption "planet Hyprland";
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
        wl-clipboard
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        package = null; # required to use the nixOS module to install hyprland
        xwayland.enable = true;
        recommendedEnvironment = false; # handled in wrapper
        # use extraConfig so that the hyprland flake still adds in the lines for systemd integration
        extraConfig =
          let
            hyprland-config = pkgs.substituteAll {
              src = ./hyprland.conf;
              setCursor = ''exec-once=hyprctl setcursor "${config.home.pointerCursor.name}" ${toString config.home.pointerCursor.size}'';
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
                + builtins.concatStringsSep "\n" (builtins.map
                  (key:
                    let
                      keyUpper = lib.strings.toUpper key;
                    in
                    ''
                      bind = ,${key},moveworkspacetomonitor,name:${keyUpper} current
                      bind = ,${key},workspace,name:${keyUpper}
                      bind = SHIFT,${key},movetoworkspacesilent,name:${keyUpper}
                    '')
                  keys);
            };
          in
          builtins.readFile "${hyprland-config}";
      };
    };
}
