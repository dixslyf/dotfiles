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
      planet.zoxide = {
        enable = mkEnableOption "planet zoxide";
      };
    };

  config =
    let
      cfg = config.planet.zoxide;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.zoxide = {
        enable = true;
        # Shell integrations are set to true by default, so no need to enable them
      };

      planet.persistence = {
        directories = [ ".local/share/zoxide" ];
      };
    };
}
