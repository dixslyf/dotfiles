{ inputs }:
{ config
, lib
, ...
}:

{
  imports = [
    inputs.impermanence.nixosModules.impermanence
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
        directories = mkOption {
          type = with types; listOf anything;
          default = [ ];
          description = ''
            List of directories to persist.
            This list will be passed to the corresponding option in the `impermanence` module.
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
      # Opt-in persisted root directories
      environment.persistence.${cfg.persistDirectory} = {
        inherit (cfg) hideMounts;
        directories = cfg.directories ++ (lists.optionals cfg.persistSystemdDirectories [
          "/var/lib/systemd/coredump"
          "/var/lib/systemd/timers"
        ])
          ++ (lists.optional cfg.persistSystemdBacklight "/var/lib/systemd/backlight") # for systemd-backlight to be able to restore brightness
          ++ (lists.optional cfg.persistLogs "/var/log")
          ++ (lists.optional cfg.persistSsh "/etc/ssh");
        files = cfg.files
          ++ lists.optional cfg.persistMachineId "/etc/machine-id";
      };

      programs.fuse.userAllowOther = cfg.fuseAllowOther;
    };
}
