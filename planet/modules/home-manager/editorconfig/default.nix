{ config
, lib
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.editorconfig = {
        enable = mkEnableOption "planet editorconfig";
      };
    };

  config =
    let
      cfg = config.planet.editorconfig;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      editorconfig = {
        enable = true;
        settings = {
          "*" = {
            charset = "utf-8";
            end_of_line = "lf";
            insert_final_newline = true;
            trim_trailing_whitespace = true;
            indent_style = "space";
          };
          "*.nix" = { indent_size = 2; };
          "*.lua" = { indent_size = 3; };
          "*.typ" = { indent_size = 2; };
          "*.c" = { indent_size = 2; };
          "{Makefile,makefile}" = { indent_style = "tab"; };
        };
      };
    };
}
