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
      planet.polybar = {
        enable = mkEnableOption "planet polybar";
        monitors = mkOption {
          type = types.listOf types.str;
          default = [ ];
          description = ''
            List of monitors to configure Polybar for.
            The first monitor in the list is the designated as the primary monitor.
          '';
        };
        bspwmIntegration = mkOption {
          type = types.bool;
          default = config.planet.bspwm.enable;
          description = "Whether to enable bspwm integration.";
        };
      };
    };

  config =
    let
      cfg = config.planet.polybar;
      inherit (lib) mkIf mkMerge lists;

      bspwmPackage = config.xsession.windowManager.bspwm.package;
      polybarPackage = pkgs.polybar.override {
        pulseSupport = true;
      };

      configFile = pkgs.replaceVars ./config.ini {
        colors = "${pkgs.pers-pkgs.catppuccin-polybar}/share/polybar/themes/catppuccin/macchiato.ini";
        bars = pkgs.writeText "polybar-bars.ini" (
          lib.concatMapStringsSep "\n\n" (monitor: ''
            [bar/${monitor}]
            inherit = bar/super
            monitor = ${monitor}
            ${lib.optionalString (monitor == lib.head cfg.monitors) ''
              modules-right = pulseaudio backlight battery time date

              tray-position = left
              tray-offset-x = 2
              tray-padding = 3
            ''}
          '') cfg.monitors
        );
      };

      optionalBspwmTarget = lists.optional cfg.bspwmIntegration "bspwm-session.target";

      # TODO: May want to make template services for Polybar instead.
      # If I add a different WM in the future and still want to use Polybar,
      # then I can at least re-use the service. For now, since I'm only using
      # bspwm, I'll just hardcode the dependency on `bspwm-session.target`.
      mkPolybarService = monitor: install: {
        Unit = {
          Description = "Polybar status bar on ${monitor}";
          PartOf = optionalBspwmTarget;
          After = optionalBspwmTarget;
          X-Restart-Triggers = [ "${configFile}" ];
        };

        Service = {
          # See HM #604fc92. TLDR; polybar executes `ping` in its network module.
          Environment = "PATH=/run/wrappers/bin";
          ExecStart = "${polybarPackage}/bin/polybar ${monitor}";
        };

        Install = mkIf install {
          WantedBy = optionalBspwmTarget;
        };
      };

      mkBspwmMarginService = monitor: {
        Unit = {
          Description = "Set bspwm margins on ${monitor} appropriately depending on whether Polybar is running";
          Requisite = [ "bspwm-session.target" ];
          PartOf = [ "polybar-${monitor}.service" ];
        };

        Service = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = [ "${bspwmPackage}/bin/bspc config -m ${monitor} top_padding 40" ];
          ExecStop = [ "${bspwmPackage}/bin/bspc config -m ${monitor} top_padding 0" ];
        };

        Install.WantedBy = [ "polybar-${monitor}.service" ];
      };
    in
    mkIf cfg.enable (mkMerge [
      {
        home.packages = [ polybarPackage ];

        xdg.configFile."polybar/config.ini".source = configFile;

        planet.tray-target = {
          enable = true;
          providers = [ "polybar-eDP-1.service" ];
        };

        systemd.user.services = lib.listToAttrs (
          map (monitor: {
            name = "polybar-${monitor}";
            value = mkPolybarService monitor (monitor == lib.head cfg.monitors);
          }) cfg.monitors
        );
      }

      (mkIf cfg.bspwmIntegration {
        systemd.user.services = lib.listToAttrs (
          map (monitor: {
            name = "bspwm-margins-polybar-${monitor}";
            value = mkBspwmMarginService monitor;
          }) cfg.monitors
        );

        # sxhxd keybinding to toggle the bar on the current monitor
        services.sxhkd.keybindings =
          let
            toggleScript = pkgs.writeShellScriptBin "toggle-current-polybar" ''
              monitor="$(${bspwmPackage}/bin/bspc query -M -m focused --names)"

              if [ "$monitor" = "eDP-1" ]; then
                wm="polybar-eDP-1_eDP-1"
              elif [ "$monitor" = "HDMI-1" ]; then
                wm="polybar-HDMI-1_HDMI-1"
              fi

              state=$(${pkgs.xwininfo}/bin/xwininfo -name "$wm" | ${pkgs.gnugrep}/bin/grep "Map State" | cut -d " " -f 5)
              if [ "$state" = "IsViewable" ]; then
                ${bspwmPackage}/bin/bspc config -m "$monitor" top_padding 0
              elif [ "$state" = "IsUnMapped" ]; then
                ${bspwmPackage}/bin/bspc config -m "$monitor" top_padding 40
              fi

              ${polybarPackage}/bin/polybar-msg -p "$(${pkgs.xprop}/bin/xprop -name "$wm" _NET_WM_PID | cut -d " " -f 3)" cmd toggle
            '';
          in
          {
            "super + d" = "${toggleScript}/bin/toggle-current-polybar";
          };
      })
    ]);
}
