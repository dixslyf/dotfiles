{ localFlakeInputs, ... }:
{
  config,
  lib,
  ...
}@args:

{
  imports = [
    localFlakeInputs.impermanence.nixosModules.home-manager.impermanence
  ];

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
        useBindMounts = mkOption {
          type = types.bool;
          default = false;
          description = ''
            By default, `impermanence`'s `home-manager` module uses `bindfs` and not
            regular bind mounts because regular users cannot create them.

            When this option is enabled, regular bind mounts will be used instead
            through `impermanence`'s NixOS module. `planet.persistence` in the NixOS
            configuration must be enabled, otherwise no mounts will be created.

            Note that if attrsets are specified in the list of directories, they must
            only contain keys that are recognised by `impermanence`'s NixOS module.
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
      inherit (lib) mkMerge mkIf;
    in
    mkMerge [
      {
        assertions = [
          {
            assertion = !cfg.useBindMounts || args ? osConfig && args.osConfig.planet.persistence.enable;
            message = ''
              `planet.persistence.useBindMounts` (`home-manager`) can only be enabled when
              using NixOS and `planet.persistence.enable = true` (NixOS) on the host configuration.
            '';
          }
        ];
      }

      (mkIf (cfg.enable && !cfg.useBindMounts) {
        home.persistence.${cfg.persistDirectory} = {
          inherit (cfg) allowOther files;
          directories = cfg.finalDirectories;
        };
      })
    ];
}
