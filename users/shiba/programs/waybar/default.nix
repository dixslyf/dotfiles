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
        modules-left = ["clock"];
        modules-right = ["pulseaudio" "backlight" "battery" "network" "tray"];
        clock = {
          format = "{:%e %B %A}";
          tooltip = false;
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
      leftBar = {
        output = "eDP-1";
        layer = "top";
        position = "left";
        modules-left = ["clock"];
        modules-center = ["wlr/workspaces"];
        clock = {
          format = "{:%H\n%M}";
          tooltip = false;
        };
      };
    };
    style = builtins.readFile ./style.css;
  };
}
