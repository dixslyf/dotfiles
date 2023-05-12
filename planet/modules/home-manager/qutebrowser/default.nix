{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.qutebrowser = {
        enable = mkEnableOption "planet qutebrowser";
      };
    };

  config =
    let
      cfg = config.planet.qutebrowser;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.qutebrowser = {
        enable = true;
        extraConfig = ''
          config.set('content.javascript.can_access_clipboard', True, 'github.com')
        '';
      };

      planet.persistence = {
        directories = [ ".local/share/qutebrowser" ];
      };
    };
}
