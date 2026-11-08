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
      planet.fish = {
        enable = mkEnableOption "planet fish";
      };
    };

  config =
    let
      cfg = config.planet.fish;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.fish =
        let
          shellInit = ''
            set -g fish_greeting
            fish_vi_key_bindings
            fish_config theme choose catppuccin-macchiato
          '';
        in
        {
          enable = true;
          loginShellInit = shellInit;
          interactiveShellInit = shellInit;
        };

      planet.persistence = {
        # For persisting history.
        directories = [ ".local/share/fish" ];
      };
    };
}
