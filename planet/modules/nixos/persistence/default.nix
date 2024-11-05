{ localFlakeInputs, ... }:
{
  config,
  lib,
  ...
}:

{
  imports = [
    localFlakeInputs.impermanence.nixosModules.impermanence
  ];

  options =
    let
      inherit (lib) mkEnableOption mkOption types;
    in
    {
      planet.persistence = {
        enable = mkEnableOption "planet persistence";
        persistDirectory = mkOption {
          type = types.str;
          default = "/persist";
          description = ''
            The path to the persistent storage directory.
          '';
        };
        hideMounts = mkOption {
          type = types.bool;
          default = true;
          description = ''
            Whether to hide bind mounts from showing up as mounted drives in file managers.
            See the description for the corresponding `impermanence` module option, which
            this value will be passed to.
          '';
        };
        fuseAllowOther = mkOption {
          type = types.bool;
          default = true;
          description = ''
            Allow non-root users to specify the allow_other or allow_root mount options, see mount.fuse3(8).
          '';
        };
        persistVarLibNixos = mkOption {
          type = types.bool;
          default = true;
          description = ''
            Whether to persist the `/var/lib/nixos` directory.
            Needed to persist UIDs and GIDs.
            This is more of a convenience option.
          '';
        };
        persistSystemdDirectories = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to persist the following systemd directories:
              - `/var/lib/systemd/coredump`
              - `/var/lib/systemd/timers`
            This is more of a convenience option.
          '';
        };
        persistMachines = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to persist the following directory:
              - `/var/lib/machines`
              - `/etc/systemd/nspawn`
            This is more of a convenience option.
          '';
        };
        persistSystemdBacklight = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to persist the `/var/lib/systemd/backlight` directory.
            This is more of a convenience option.
          '';
        };
        persistLogs = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to persist the `/var/log` directory.
            This is more of a convenience option.
          '';
        };
        persistSsh = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to persist the `/etc/ssh` directory.
            This is more of a convenience option.
          '';
        };
        persistMachineId = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to persist the `/etc/machine-id` file.
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
      inherit (lib) mkIf mkMerge lists;

      getUserPersistence = user: config.home-manager.users.${user}.planet.persistence;
      users = builtins.attrNames config.home-manager.users;
      target-users = builtins.filter (
        user:
        let
          user-persistence = getUserPersistence user;
        in
        user-persistence.enable && user-persistence.useBindMounts
      ) users;
    in
    mkIf cfg.enable (mkMerge [
      {
        # Opt-in persisted root directories
        environment.persistence.${cfg.persistDirectory} = {
          inherit (cfg) hideMounts;

          directories =
            cfg.directories
            ++ (lists.optionals cfg.persistSystemdDirectories [
              "/var/lib/systemd/coredump"
              "/var/lib/systemd/timers"
            ])
            ++ (lists.optional cfg.persistVarLibNixos "/var/lib/nixos")
            ++ (lists.optionals cfg.persistMachines [
              "/var/lib/machines"
              "/etc/systemd/nspawn"
            ])
            ++ (lists.optional cfg.persistSystemdBacklight "/var/lib/systemd/backlight") # for systemd-backlight to be able to restore brightness
            ++ (lists.optional cfg.persistLogs "/var/log")
            ++ (lists.optional cfg.persistSsh "/etc/ssh");

          files = cfg.files ++ lists.optional cfg.persistMachineId "/etc/machine-id";

          users = lib.attrsets.genAttrs target-users (
            user:
            let
              user-persistence = getUserPersistence user;
            in
            {
              inherit (user-persistence) files;
              directories = user-persistence.finalDirectories;
            }
          );
        };

        programs.fuse.userAllowOther = cfg.fuseAllowOther;
      }

      # Work around https://github.com/nix-community/impermanence/issues/229
      (mkIf cfg.persistMachineId {
        boot.initrd.systemd.suppressedUnits = [ "systemd-machine-id-commit.service" ];
        systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
      })
    ]);
}
