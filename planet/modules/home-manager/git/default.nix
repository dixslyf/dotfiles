{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib)
        mkEnableOption
        mkOption
        types
        ;
    in
    {
      planet.git = {
        enable = mkEnableOption "planet git";
        sign = mkOption {
          type = types.bool;
          default = true;
          description = ''
            Configure signing with GPG.
          '';
        };
      };
    };

  config =
    let
      cfg = config.planet.git;
      inherit (lib)
        mkIf
        mkMerge
        ;
    in
    mkIf cfg.enable (mkMerge [
      {
        programs.git = {
          enable = true;
          lfs.enable = true;
          settings = {
            user = {
              name = "Dixon Sean Low Yan Feng";
              email = "root@dixslyf.dev";
            };
            merge = {
              conflictStyle = "zdiff3";
              ff = false;
            };
            pull = {
              rebase = "merges";
            };
          };
        };
      }
      (mkIf cfg.sign {
        programs.git.signing = {
          key = "A9F388161E9B90C7!";
          signByDefault = true;
        };
      })
    ]);
}
