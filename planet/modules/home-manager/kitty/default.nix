{ localFlake', ... }:
{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.kitty = {
        enable = mkEnableOption "planet kitty";
        defaultTerminal = mkEnableOption "kitty as the default terminal";
      };
    };
  config =
    let
      cfg = config.planet.kitty;
      inherit (lib)
        mkIf
        mkMerge;
    in
    mkIf cfg.enable (mkMerge [
      {
        home.packages = [ localFlake'.packages.iosevka-term-custom ];
        programs.kitty = {
          enable = true;
          settings = {
            shell = "fish";
            window_margin_width = "12 24";
          };
          font = {
            name = "Iosevka Term Custom";
            size = 16;
          };
          theme = "Catppuccin-Macchiato";
        };
      }

      (mkIf cfg.defaultTerminal {
        planet.default-terminal = {
          startCommand = ''
            ${config.programs.kitty.package}/bin/kitty -- "$@"
          '';
          startInDirectoryCommand = ''
            ${config.programs.kitty.package}/bin/kitty --directory "$@"
          '';
        };
      })
    ]);
}
