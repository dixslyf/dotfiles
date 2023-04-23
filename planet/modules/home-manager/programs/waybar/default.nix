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
      planet.waybar = {
        enable = mkEnableOption "planet waybar";
        systemd.target = mkOption {
          type = types.anything;
          default = "hyprland-session.target";
          description = "The systemd target to bind to";
        };
        primaryOutput = mkOption {
          type = types.str;
          description = "The name of the primary output monitor";
        };
        externalOutput = mkOption {
          type = with types; nullOr str;
          default = null;
          description = "The name of the external output monitor, if any";
        };
      };
    };

  config =
    let
      cfg = config.planet.waybar;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
        systemd = {
          inherit (cfg.systemd) target;
          enable = true;
        };
        settings = {
          topBarPrimary = {
            output = cfg.primaryOutput;
            layer = "top";
            position = "top";
            modules-left = [ "clock#time" "clock#date" "tray" ];
            modules-center = [ "wlr/workspaces" ];
            modules-right = [ "pulseaudio" "backlight" "battery" "network" ];
            "clock#time" = {
              format = "󰅐 {:%H\:%M}";
              tooltip = false;
            };
            "clock#date" = {
              format = "󰃭 {:%e %B, %A}";
              tooltip = false;
            };
            tray = {
              icon-size = 24;
              spacing = 8;
            };
            pulseaudio = {
              format = "{icon} {volume}%";
              format-bluetooth = "{icon}󰂰 {desc} {volume}%";
              format-muted = "󰝟 muted";
              format-icons = {
                default = [ "󰕿" "󰖀" "󰕾" ];
                headphone = [ "󰋋󰕿" "󰋋󰖀" "󰋋󰕾" ];
                headset = [ "󰋎󰕿" "󰋎󰖀" "󰋎󰕾" ];
                speaker = [ "󰓃󰕿" "󰓃󰖀" "󰓃󰕾" ];
                hdmi = [ "󰡁󰕿" "󰡁󰖀" "󰡁󰕾" ];
                phone = [ "󰏲󰕿" "󰏲󰖀" "󰏲󰕾" ];
                hands-free = [ "󱠰󰕿" "󱠰󰖀" "󱠰󰕾" ];
                portable = [ "󰸐󰕿" "󰸐󰖀" "󰸐󰕾" ];
                car = [ "󰄋󰕿" "󰄋󰖀" "󰄋󰕾" ];
                hifi = [ "󰗜󰕿" "󰗜󰖀" "󰗜󰕾" ];
              };
            };
            backlight = {
              format = "{icon} {percent}%";
              format-icons = [ "󰌶" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
              on-scroll-up = "light -A 0.2";
              on-scroll-down = "light -U 0.2";
            };
            battery = {
              format = "{icon} {capacity}%";
              format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
            };
            network = {
              format-disconnected = "󰤮 No connection";
              format-ethernet = "󰈀 Ethernet";
              format-linked = "󰘘 {ifname}";
              format-wifi = "{icon} {essid} {signalStrength}%";
              format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
            };
          };
          topBarExternal = mkIf (cfg.externalOutput != null) {
            output = cfg.externalOutput;
            layer = "top";
            position = "top";
            modules-center = [ "wlr/workspaces" ];
          };
        };
        style = pkgs.substituteAll {
          src = ./style.css;
          themePath = "${pkgs.pers-pkgs.catppuccin-waybar}/share/waybar/themes/catppuccin/macchiato.css";
        };
      };
    };
}
