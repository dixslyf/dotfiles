{
  config,
  lib,
  pkgs,
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
      planet.gitui = {
        enable = mkEnableOption "planet gitui";
        package = mkOption {
          type = types.package;
          default = pkgs.gitui;
          description = "The `gitui` package to use.";
        };
      };
    };

  config =
    let
      cfg = config.planet.gitui;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.gitui = {
        enable = true;
        inherit (cfg) package;
        keyConfig = builtins.readFile ./key_bindings.ron;
        theme = builtins.readFile "${pkgs.pers-pkgs.catppuccin-gitui}/share/gitui/catppuccin-macchiato.ron";
      };
    };
}
