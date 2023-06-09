{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.xmonad = {
        enable = mkEnableOption "planet xmonad";
      };
    };

  config =
    let
      cfg = config.planet.xmonad;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      xsession.windowManager.xmonad = {
        enable = true;
        config = ./haskell/Main.hs;
      };

      systemd.user.targets.xmonad-session = {
        Unit = {
          Description = "xmonad session";
          BindsTo = [ "graphical-session.target" ];
          Wants = [ "graphical-session-pre.target" ];
          After = [ "graphical-session-pre.target" ];
        };
      };
    };
}
