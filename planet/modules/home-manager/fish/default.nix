{ self' }:
{ config
, lib
, ...
}: {
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
            fish_vi_key_bindings
            fish_config theme choose "Catppuccin Macchiato"
          '';
        in
        {
          enable = true;
          loginShellInit = shellInit;
          interactiveShellInit = shellInit;
        };

      xdg.configFile."fish/themes" = {
        source = "${self'.packages.catppuccin-fish}/share/fish/themes";
        recursive = true;
      };
    };
}
