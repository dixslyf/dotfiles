{ config
, lib
, ...
}:

{
  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.persistence = {
        enable = mkEnableOption "planet persistence";
        persistDirectory = mkOption {
          type = types.str;
          default = "/persist${config.home.homeDirectory}";
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
        allowOther = mkOption {
          # `anything` because `impermanence` will do the type checking anyway.
          # While we can copy the same type from `impermanence`, that'll just be double work.
          # Furthermore, if for some reason `impermanence` changes the type, then we won't have
          # to change anything here.
          type = types.anything;
          default = true;
          description = ''
            Whether to allow other users access to the bind mounted directories.
            See the description for the corresponding `impermanence` module option, which
            this value will be passed to.
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
      inherit (lib) mkIf lists;
    in
    mkIf cfg.enable {
      home.persistence.${cfg.persistDirectory} = {
        inherit (cfg) allowOther files;
        directories = cfg.directories ++ (lists.optionals cfg.persistXdgUserDirectories [
          "Desktop"
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Public"
          "Templates"
          "Videos"
        ]);
      };
    };
}
