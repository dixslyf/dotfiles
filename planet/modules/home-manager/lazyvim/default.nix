{ localFlake', ... }:
{ config
, lib
, pkgs
, ...
}: {
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.lazyvim = {
        enable = mkEnableOption "planet lazyvim";
        package = mkOption {
          type = types.package;
          default = pkgs.neovim-unwrapped;
          description = "The `neovim` package to use.";
        };
        defaultApplication = {
          enable = mkEnableOption "MIME default application configuration";
          mimeTypes = mkOption {
            type = types.listOf types.str;
            default = [ "text/plain" ];
            description = ''
              MIME types to be the default application for.
            '';
          };
        };
      };
    };

  config =
    let
      cfg = config.planet.lazyvim;
      inherit (lib) mkIf;

      plugin-list = import ./plugin-list.nix {
        inherit lib;
        inherit (pkgs) vimPlugins;
        localFlakePackages' = localFlake'.packages;
      };

      plugin-dirs-lua = pkgs.writeText "plugin-dirs.lua" ''
        return {
          ${
            lib.concatStrings (builtins.map (desc: ''
              {
                "${desc.shortUrl}",
                name = "${desc.name}",
                dir = "${desc.plugin}",
              },
            '') plugin-list)
          }
        }
      '';
    in
    mkIf cfg.enable {
      xdg = {
        configFile = {
          "nvim/.neoconf.json".source = ./.neoconf.json;
          "nvim/lua".source = ./lua;
        };
        mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
          lib.genAttrs cfg.defaultApplication.mimeTypes (_: "nvim.desktop")
        );
      };

      programs.neovim = {
        inherit (cfg) package;
        enable = true;
        vimAlias = true;
        viAlias = true;
        defaultEditor = true;
        extraLuaConfig = builtins.readFile (pkgs.substituteAll {
          src = ./init.lua;
          lazy_nvim_path = "${pkgs.vimPlugins.lazy-nvim}";
          plugin_dirs_lua_path = "${plugin-dirs-lua}";
        });
      };
    };
}
