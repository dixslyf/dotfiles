{ config
, lib
, pkgs
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.rofi = {
        enable = mkEnableOption "planet rofi";
      };
    };

  config =
    let
      cfg = config.planet.rofi;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [ pers-pkgs.mali ];
      programs.rofi = {
        enable = true;
        configPath = "${config.xdg.configHome}/rofi/home-manager.rasi";
        font = "Mali 16";
        terminal = "${pkgs.wezterm}/bin/wezterm";
        theme = "${pkgs.pers-pkgs.catppuccin-rofi}/share/rofi/themes/catppuccin-basic/catppuccin-macchiato.rasi";
        extraConfig = {
          m = -1;
          steal-focus = true;
          kb-row-up = "Up,Alt+k";
          kb-row-down = "Down,Alt+j";
          kb-row-left = "Alt+h";
          kb-row-right = "Alt+l";
        };
      };

      xdg.configFile."rofi/config.rasi".text = ''
        @import "${config.programs.rofi.configPath}"
        ${builtins.readFile "${pkgs.pers-pkgs.catppuccin-rofi}/share/rofi/themes/catppuccin-basic/config.rasi"}
      '';
    };
}
