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
      planet.tetrio-desktop = {
        enable = mkEnableOption "planet tetrio-desktop";
      };
    };

  config =
    let
      cfg = config.planet.tetrio-desktop;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      # FIXME: re-enable when tetrio plus is compatible with tetrio 9.0.0
      # Original warning: `withTetrioPlus: Currently unsupported with tetrio-desktop 9.0.0. Please remove this attribute.`
      # home.packages = with pkgs; [ (tetrio-desktop.override { withTetrioPlus = true; }) ];
      home.packages = with pkgs; [ tetrio-desktop ];
      planet.persistence = {
        directories = [ ".config/tetrio-desktop" ];
      };
    };
}
