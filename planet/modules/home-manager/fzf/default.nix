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
      planet.fzf = {
        enable = mkEnableOption "planet fzf";
      };
    };

  config =
    let
      cfg = config.planet.fzf;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.fzf = {
        enable = true;
        defaultCommand = "${pkgs.fd}/bin/fd --type f";
        fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
        changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
        # Shell integrations are set to true by default, so no need to enable them
      };
    };
}
