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
      planet.fzf = {
        enable = mkEnableOption "planet fzf";
      };
    };

  config =
    let
      cfg = config.planet.fzf;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      programs.fzf = {
        enable = true;
        defaultCommand = "${pkgs.fd}/bin/fd --type f";
        fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
        changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
        colors = {
          # Macchiato from https://github.com/catppuccin/fzf
          fg = "#cad3f5";
          "fg+" = "#cad3f5";
          bg = "#24273a";
          "bg+" = "#363a4f";
          hl = "#ed8796";
          "hl+" = "#ed8796";
          spinner = "#f4dbd6";
          header = "#ed8796";
          info = "#c6a0f6";
          pointer = "#f4dbd6";
          marker = "#f4dbd6";
          prompt = "#c6a0f6";
        };
        # Shell integrations are set to true by default, so no need to enable them
      };
    };
}
