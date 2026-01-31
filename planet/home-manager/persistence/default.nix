{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}:

{
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
      cfg = config.planet.persistence;
    in
    {
      planet.persistence = {
        enable = mkEnableOption "planet persistence";
        persistDirectory = mkOption {
          type = types.str;
          default = osConfig.planet.persistence.persistDirectory or "/persist";
          description = ''
            The path to the persistent storage directory.
          '';
        };
        persistXdgUserDirectories = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to persist the XDG user directories.
            This is more of a convenience option.
          '';
        };
        directories = mkOption {
          type = with types; listOf anything;
          default = [ ];
          description = ''
            List of directories to persist.
            This list will be passed to the corresponding option in the `impermanence` module.
          '';
        };
        finalDirectories = mkOption {
          type = with types; listOf anything;
          internal = true;
          default =
            cfg.directories
            ++ (lib.lists.optionals cfg.persistXdgUserDirectories [
              "Desktop"
              "Documents"
              "Downloads"
              "Music"
              "Pictures"
              "Public"
              "Templates"
              "Videos"
            ]);
          description = ''
            The final list of directories to persist.
          '';
        };
        files = mkOption {
          type = with types; listOf anything;
          default = [ ];
          description = ''
            List of files to persist.
            This list will be passed to the corresponding option in the `impermanence` module.
          '';
        };
      };
    };

  config =
    let
      cfg = config.planet.persistence;
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      home = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        persistence.${cfg.persistDirectory} = {
          inherit (cfg)
            files
            ;

          directories = cfg.finalDirectories;
        };
      };
    };
}
