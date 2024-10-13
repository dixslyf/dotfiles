{ localFlake', ... }:
{
  config,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.sioyek = {
        enable = mkEnableOption "planet sioyek";
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [
              "application/pdf"
              "application/oxps"
              "application/epub+zip"
              "application/x-fictionbook"
              "image/vnd.djvu"
              "image/vnd.djvu+multipage"
              "application/postscript"
              "application/eps"
              "application/x-eps"
              "image/eps"
              "image/x-eps"
              "application/x-cbr"
              "application/x-cbz"
              "application/x-cb7"
              "application/x-cbt"
            ];
            description = ''
              MIME types to be the default application for.
            '';
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.sioyek;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home.packages = [ localFlake'.packages.iosevka-custom ];
      programs.sioyek = {
        enable = true;
        bindings = {
          screen_up = "<C-u>";
          screen_down = "<C-d>";
          next_page = "J";
          previous_page = "K";
        };
        config = {
          ui_font = "Iosevka Custom";
          font_size = "16";
          page_separator_width = "8";
          should_launch_new_window = "1";
          startup_commands = "toggle_custom_color";

          # https://github.com/catppuccin/sioyek/blob/3879f23da360c891ed18bb0b85537f891589c47f/themes/macchiato.config
          background_color = "#24273a";
          text_highlight_color = "#eed49f";
          visual_mark_color = "#8087a2";
          search_highlight_color = "#eed49f";
          link_highlight_color = "#8aadf4";
          synctex_highlight_color = "#a6da95";
          highlight_color_a = "#eed49f";
          highlight_color_b = "#a6da95";
          highlight_color_c = "#91d7e3";
          highlight_color_d = "#ee99a0";
          highlight_color_e = "#c6a0f6";
          highlight_color_f = "#ed8796";
          highlight_color_g = "#eed49f";
          custom_background_color = "#24273a";
          custom_text_color = "#cad3f5";
          ui_text_color = "#cad3f5";
          ui_background_color = "#363a4f";
          ui_selected_text_color = "#cad3f5";
          ui_selected_background_color = "#5b6078";
        };
      };

      xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
        lib.genAttrs cfg.defaultApplication.mimeTypes (_: "sioyek.desktop")
      );
    };
}
