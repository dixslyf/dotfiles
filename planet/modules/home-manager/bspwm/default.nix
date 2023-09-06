{ osConfig
, config
, lib
, pkgs
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.bspwm = {
        enable = mkEnableOption "planet bspwm";
        primaryMonitor = mkOption {
          type = types.str;
          description = "The name of the primary monitor";
        };
      };
    };

  config =
    let
      cfg = config.planet.bspwm;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      planet.sxhkd.enable = true;
      # Note that xsession.enable = false so that home-manager doesn't create ~/.xsession.
      # More details: https://github.com/NixOS/nixpkgs/issues/190442
      xsession.windowManager.bspwm = {
        # This shouldn't actually change anything since it only controls the bspwm binary in ~/.xsession,
        # but just in case, I'm setting it.
        inherit (osConfig.planet.sessions.bspwm) package;
        enable = true;
        monitors = {
          ${cfg.primaryMonitor} = [ "p1" "p2" "p3" "p4" "p5" "p6" "p7" "p8" "p9" "p0" ];
        };
        rules = {
          "Steam" = {
            desktop = "eDP-1:^2";
          };
          "Qutebrowser" = {
            desktop = "eDP-1:^1";
          };
          "Firefox" = {
            desktop = "eDP-1:^4";
          };
          "Zathura" = {
            state = "tiled";
          };
        };
        settings = {
          border_width = 2;
          normal_border_color = "#969896";
          active_border_color = "#81a2be";
          focused_border_color = "#b294bb";
          window_gap = 12;
          gapless_monocle = true;
          borderless_monocle = true;
          single_monocle = true;
          focus_follows_pointer = true;
          pointer_follows_focus = true;
          pointer_follows_monitor = true;
        };
        extraConfig = ''
          ${pkgs.autorandr}/bin/autorandr --change

          # TODO: figure out how to set this for all X window managers
          ${pkgs.xorg.xsetroot}/bin/xsetroot -cursor_name left_ptr
        '';
      };
    };
}
