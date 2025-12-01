{
  config,
  pkgs,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.aerospace = {
        enable = mkEnableOption "planet aerospace";
      };
    };

  config =
    let
      cfg = config.planet.aerospace;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.aerospace = {
        enable = true;
        launchd.enable = true;
        settings = {
          automatically-unhide-macos-hidden-apps = true;

          gaps = {
            inner = {
              horizontal = 8;
              vertical = 8;
            };
            outer = {
              left = 8;
              bottom = 8;
              top = 8;
              right = 8;
            };
          };

          # Reference: https://nikitabobko.github.io/AeroSpace/commands
          mode.main.binding = {
            # Terminal
            alt-enter = ''
              exec-and-forget "${pkgs.wezterm}/bin/wezterm"
            '';

            # Layout
            alt-slash = "layout tiles horizontal vertical";
            alt-comma = "layout accordion horizontal vertical";

            # Nodes
            alt-j = "focus left --boundaries-action wrap-around-the-workspace";
            alt-k = "focus right --boundaries-action wrap-around-the-workspace";
            alt-shift-j = "move left";
            alt-shift-k = "move right";
            alt-minus = "resize smart -50";
            alt-equal = "resize smart +50";
            alt-shift-c = "close";
            alt-f = "macos-native-fullscreen";

            # Workspaces
            alt-1 = "workspace 1";
            alt-2 = "workspace 2";
            alt-3 = "workspace 3";
            alt-4 = "workspace 4";
            alt-5 = "workspace 5";
            alt-6 = "workspace 6";
            alt-7 = "workspace 7";
            alt-8 = "workspace 8";
            alt-9 = "workspace 9";
            alt-0 = "workspace 0";
            alt-q = "workspace Q";
            alt-w = "workspace W";
            alt-e = "workspace E";
            alt-r = "workspace R";
            alt-t = "workspace T";
            alt-shift-1 = "move-node-to-workspace 1";
            alt-shift-2 = "move-node-to-workspace 2";
            alt-shift-3 = "move-node-to-workspace 3";
            alt-shift-4 = "move-node-to-workspace 4";
            alt-shift-5 = "move-node-to-workspace 5";
            alt-shift-6 = "move-node-to-workspace 6";
            alt-shift-7 = "move-node-to-workspace 7";
            alt-shift-8 = "move-node-to-workspace 8";
            alt-shift-9 = "move-node-to-workspace 9";
            alt-shift-0 = "move-node-to-workspace 0";
            alt-shift-q = "move-node-to-workspace Q";
            alt-shift-w = "move-node-to-workspace W";
            alt-shift-e = "move-node-to-workspace E";
            alt-shift-r = "move-node-to-workspace R";
            alt-shift-t = "move-node-to-workspace T";

            # Monitors
            alt-i = "focus-monitor next --wrap-around";
            alt-shift-i = "move-node-to-monitor --wrap-around next";

            # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
            alt-tab = "workspace-back-and-forth";
            # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
            alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

            # Service
            alt-shift-semicolon = "mode service";
          };

          mode.service.binding = {
            esc = [
              "reload-config"
              "mode main"
            ];
            r = [
              "flatten-workspace-tree"
              "mode main"
            ];
            f = [
              "layout floating tiling"
              "mode main"
            ];
            backspace = [
              "close-all-windows-but-current"
              "mode main"
            ];

            alt-shift-h = [
              "join-with left"
              "mode main"
            ];
            alt-shift-j = [
              "join-with down"
              "mode main"
            ];
            alt-shift-k = [
              "join-with up"
              "mode main"
            ];
            alt-shift-l = [
              "join-with right"
              "mode main"
            ];

            down = "volume down";
            up = "volume up";
            shift-down = [
              "volume set 0"
              "mode main"
            ];
          };

          workspace-to-monitor-force-assignment = {
            "1" = "main";
            "2" = "main";
            "3" = "main";
            "4" = "main";
            "5" = "main";
            "6" = "main";
            "7" = "main";
            "8" = "main";
            "9" = "main";
            "0" = "main";
            Q = [
              "secondary"
              "main"
            ];
            W = [
              "secondary"
              "main"
            ];
            E = [
              "secondary"
              "main"
            ];
            R = [
              "secondary"
              "main"
            ];
            T = [
              "secondary"
              "main"
            ];
          };
        };
      };
    };
}
