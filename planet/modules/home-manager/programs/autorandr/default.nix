{ config
, pkgs
, ...
}:

let
  bspwmPackage = config.xsession.windowManager.bspwm.package;
in
{
  programs.autorandr = {
    enable = true;
    profiles = {
      mobile = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0009e5f70700000000011c0104a51f117802fb90955d59942923505400000001010101010101010101010101010101bc398018713828403020360035ae1000001a000000000000000000000000000000000000000000fe00424f452043510a202020202020000000fe004e5631343046484d2d4e34390a00b8";
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
          preswitch = ''
            if systemctl is-active --user bspwm-session.target; then
              for node_id in $(${bspwmPackage}/bin/bspc query -N -m HDMI-1); do
                ${bspwmPackage}/bin/bspc node "$node_id" -m eDP-1
              done
              systemctl stop --user polybar-HDMI-1.service
              ${bspwmPackage}/bin/bspc monitor HDMI-1 -r
            fi
          '';
        };
      };
      docked = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0009e5f70700000000011c0104a51f117802fb90955d59942923505400000001010101010101010101010101010101bc398018713828403020360035ae1000001a000000000000000000000000000000000000000000fe00424f452043510a202020202020000000fe004e5631343046484d2d4e34390a00b8";
          HDMI-1 = "00ffffffffffff0010acf441425444412e1e010380351e78eaf995a755549c260f5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c45000f282100001e000000ff0032364a503232330a2020202020000000fc0044454c4c20533234323148530a000000fd00304b1e5311000a202020202020014102032bf14f90050403020716010611121513141f230907078301000065030c001000681a00000101304be62a4480a070382740302035000f282100001a011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f2821000018000000000000000000000000ac";
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
          postswitch = ''
            if systemctl is-active --user bspwm-session.target; then
              ${bspwmPackage}/bin/bspc monitor HDMI-1 -d h1 h2 h3 h4 h5 h6 h7 h8 h9 h0
              systemctl start --user polybar-HDMI-1.service
            fi
            ${pkgs.hsetroot}/bin/hsetroot -solid "#363a4f"
          '';
        };
      };
    };
  };
}
