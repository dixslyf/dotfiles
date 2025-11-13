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
      planet.neovim = {
        enable = mkEnableOption "planet neovim";
      };
    };

  config =
    let
      cfg = config.planet.neovim;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.neovim = {
        enable = true;
        vimAlias = true;
        viAlias = true;
        defaultEditor = true;
      };
    };
}
