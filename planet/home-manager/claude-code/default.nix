{
  config,
  pkgs,
  lib,
  ...
}:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      planet.claude-code = {
        enable = mkEnableOption "planet claude-code";
      };
    };

  config =
    let
      cfg = config.planet.claude-code;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          claude-code
        ];

        # https://github.com/anthropics/claude-code/issues/1455
        sessionVariables = {
          CLAUDE_CONFIG_DIR = "${config.home.homeDirectory}/.config/claude";
        };

        file = {
          # Annoying, but this doesn't live in the config dir, so
          # we'll manually symlink.
          ".claude.json".source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.CLAUDE_CONFIG_DIR}/.claude.json";
        };
      };

      planet.persistence = {
        directories = [
          # We still need to persist ~/.claude because claude-code still uses it for some things
          # even after setting CLAUDE_CONFIG_DIR.
          # https://github.com/anthropics/claude-code/issues/1455
          ".claude"
          ".config/claude"
        ];
      };
    };
}
