{
  config,
  lib,
  pkgs,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.cambridge = {
        enable = mkEnableOption "planet cambridge";
        modpack = {
          enable = mkEnableOption "Install official Cambridge modpack";
        };
      };
    };

  config =
    let
      cfg = config.planet.cambridge;
      inherit (lib)
        mkIf
        mkMerge
        ;
    in
    mkIf cfg.enable (mkMerge [
      {
        home.packages = [
          pkgs.pers-pkgs.cambridge
        ];

        planet.persistence = {
          directories = [
            ".local/share/love/cambridge"
          ];
        };
      }

      (mkIf cfg.modpack.enable {
        home.file = {
          ".local/share/love/cambridge/res" = {
            source = "${pkgs.pers-pkgs.cambridge-modpack}/res";
            recursive = true;
          };

          ".local/share/love/cambridge/tetris" = {
            source = "${pkgs.pers-pkgs.cambridge-modpack}/tetris";
            recursive = true;
          };

          # NOTE: This relies on a patched Cambridge that allows reading symlinked resource packs.
          ".local/share/love/cambridge/resourcepacks" = {
            source = "${pkgs.pers-pkgs.cambridge-modpack}/skins";
            recursive = true;
          };
        };
      })
    ]);
}
