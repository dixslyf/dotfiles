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
      planet.prism-launcher = {
        enable = mkEnableOption "planet Prism Launcher";
      };
    };

  config =
    let
      cfg = config.planet.prism-launcher;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = with pkgs; [
        prismlauncher
      ];

      planet.persistence = {
        directories = [
          ".local/share/PrismLauncher"
        ];
      };
    };
}
