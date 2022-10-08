{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      topBar = {
        output = "eDP-1";
        layer = "top";
        position = "top";
        modules-left = ["clock#time" "clock#date" "tray"];
        modules-center = ["wlr/workspaces"];
        modules-right = ["pulseaudio" "backlight" "battery" "network"];
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
            default = ["󰕿" "󰖀" "󰕾"];
            headphone = ["󰋋󰕿" "󰋋󰖀" "󰋋󰕾"];
            headset = ["󰋎󰕿" "󰋎󰖀" "󰋎󰕾"];
            speaker = ["󰓃󰕿" "󰓃󰖀" "󰓃󰕾"];
            hdmi = ["󰡁󰕿" "󰡁󰖀" "󰡁󰕾"];
            phone = ["󰏲󰕿" "󰏲󰖀" "󰏲󰕾"];
            hands-free = ["󱠰󰕿" "󱠰󰖀" "󱠰󰕾"];
            portable = ["󰸐󰕿" "󰸐󰖀" "󰸐󰕾"];
            car = ["󰄋󰕿" "󰄋󰖀" "󰄋󰕾"];
            hifi = ["󰗜󰕿" "󰗜󰖀" "󰗜󰕾"];
          };
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["󰌶" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
          on-scroll-up = "light -A 0.2";
          on-scroll-down = "light -U 0.2";
        };
        battery = {
          format = "{icon} {capacity}%";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        network = {
          format-disconnected = "󰤮 No connection";
          format-ethernet = "󰈀 Ethernet";
          format-linked = "󰘘 {ifname}";
          format-wifi = "{icon} {essid} {signalStrength}%";
          format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
        };
      };
    };
    style = pkgs.substituteAll {
      src = ./style.css;
      themePath = "${pkgs.pvtpkgs.catppuccin-waybar}/share/waybar/themes/catppuccin/macchiato.css";
    };
  };
}
