{
  localFlake,
  ...
}:

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
      planet.autorandr = {
        enable = mkEnableOption "planet autorandr";
        host = mkOption {
          type = types.nullOr (
            types.enum [
              "alpha"
              "delta"
            ]
          );
          default = null;
          description = "The host name, which specifies which autorandr configuration to use";
        };
      };
    };

  config =
    let
      cfg = config.planet.autorandr;
      inherit (lib) mkIf;
      bspwmPackage = config.xsession.windowManager.bspwm.package;

      alphaMonitorFingerprint = "00ffffffffffff0009e5f70700000000011c0104a51f117802fb90955d59942923505400000001010101010101010101010101010101bc398018713828403020360035ae1000001a000000000000000000000000000000000000000000fe00424f452043510a202020202020000000fe004e5631343046484d2d4e34390a00b8";
      deltaMonitorFingerprint = "00ffffffffffff000e7749140000000000220104b51f147803ff00a4554c99240e505400000001010101010101010101010101010101776a00a0a04046603020360038c310000018b29f00a0a04046603020360038c310000018000000fd00285a979729010a202020202020000000fc004d4e453530374441312d330a2001ad7020790200810015741a00000301285a0000000000005a000000008d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d490";
      homeMonitorFingerprint = "00ffffffffffff0010acf441425444412e1e010380351e78eaf995a755549c260f5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c45000f282100001e000000ff0032364a503232330a2020202020000000fc0044454c4c20533234323148530a000000fd00304b1e5311000a202020202020014102032bf14f90050403020716010611121513141f230907078301000065030c001000681a00000101304be62a4480a070382740302035000f282100001a011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f2821000018000000000000000000000000ac";

      mobilePreswitchBspwm = ''
        if systemctl is-active --user bspwm-session.target; then
          for node_id in $(${bspwmPackage}/bin/bspc query -N -m HDMI-1); do
            ${bspwmPackage}/bin/bspc node "$node_id" -m eDP-1
          done
          systemctl stop --user polybar-HDMI-1.service
          ${bspwmPackage}/bin/bspc monitor HDMI-1 -r
        fi
      '';

      dockedPostswitchBspwm = ''
        if systemctl is-active --user bspwm-session.target; then
          ${bspwmPackage}/bin/bspc monitor HDMI-1 -d h1 h2 h3 h4 h5 h6 h7 h8 h9 h0
          systemctl start --user polybar-HDMI-1.service
        fi

        # Set wallpaper
        ${pkgs.feh}/bin/feh --bg-scale ${localFlake}/planet/wallpapers/ocean-moon-stars.png
      '';

      alphaConfiguration = {
        enable = true;
        profiles = {
          mobile = {
            fingerprint = {
              eDP-1 = alphaMonitorFingerprint;
            };
            config = {
              eDP-1 = {
                enable = true;
                primary = true;
                mode = "1920x1080";
                position = "0x0";
                rate = "59.98";
              };
              HDMI-1 = {
                enable = false;
              };
            };
            hooks = {
              preswitch = mobilePreswitchBspwm;
            };
          };
          docked-home = {
            fingerprint = {
              eDP-1 = alphaMonitorFingerprint;
              HDMI-1 = homeMonitorFingerprint;
            };
            config = {
              eDP-1 = {
                enable = true;
                primary = true;
                mode = "1920x1080";
                position = "0x0";
                rate = "59.98";
              };
              HDMI-1 = {
                enable = true;
                mode = "1920x1080";
                position = "1920x0";
                rate = "60.00";
              };
            };
            hooks = {
              postswitch = dockedPostswitchBspwm;
            };
          };
        };
      };
      deltaConfiguration = {
        enable = true;
        profiles = {
          mobile = {
            fingerprint = {
              eDP-1 = deltaMonitorFingerprint;
            };
            config = {
              eDP-1 = {
                enable = true;
                primary = true;
                mode = "1920x1200";
                position = "0x0";
                rate = "59.95";
              };
              HDMI-1.enable = false;
              DP-1.enable = false;
              DP-2.enable = false;
              DP-3.enable = false;
              DP-4.enable = false;
            };
            hooks = {
              preswitch = mobilePreswitchBspwm;
            };
          };
          docked-home = {
            fingerprint = {
              eDP-1 = deltaMonitorFingerprint;
              HDMI-1 = homeMonitorFingerprint;
            };
            config = {
              eDP-1 = {
                enable = true;
                primary = true;
                mode = "1920x1200";
                position = "0x0";
                rate = "59.95";
              };
              HDMI-1 = {
                enable = true;
                mode = "1920x1080";
                position = "1920x0";
                rate = "60.00";
              };
              DP-1.enable = false;
              DP-2.enable = false;
              DP-3.enable = false;
              DP-4.enable = false;
            };
            hooks = {
              postswitch = dockedPostswitchBspwm;
            };
          };
        };
      };
    in
    mkIf cfg.enable {
      assertions = [
        {
          assertion = cfg.host != null;
          message = "`planet.autorandr.host` must be set.";
        }
      ];

      programs.autorandr = if cfg.host == "alpha" then alphaConfiguration else deltaConfiguration;
    };
}
