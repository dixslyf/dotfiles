{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.git = {
        enable = mkEnableOption "planet git";
      };
    };

  config =
    let
      cfg = config.planet.git;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.git = {
        enable = true;
        lfs.enable = true;
        userEmail = "root@dixslyf.dev";
        userName = "Dixon Sean Low Yan Feng";
        signing = {
          key = "A9F388161E9B90C7!";
          signByDefault = true;
        };
        extraConfig = {
          merge = {
            conflictStyle = "zdiff3";
            ff = false;
          };
          pull = {
            rebase = "merges";
          };
        };
      };
    };
}
