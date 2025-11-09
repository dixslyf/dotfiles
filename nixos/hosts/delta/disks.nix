_:

let
  persistDirectory = "/persist";
in
{
  planet.persistence = {
    enable = true;
    inherit persistDirectory;
    persistSystemdDirectories = true;
    persistMachines = true;
    persistSystemdBacklight = true;
    persistLogs = true;
    persistMachineId = true;
  };

  fileSystems.${persistDirectory}.neededForBoot = true;

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "size=16G"
        "mode=755"
        "noatime"
      ];
    };
    # Other filesystem configuration is mostly handled by disko.
  };

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            cryptroot = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypt";
                askPassword = true;
                extraOpenArgs = [
                  "--allow-discards"
                ];
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                      ];
                    };
                    "@persist" = {
                      mountpoint = persistDirectory;
                      mountOptions = [
                        "compress=zstd:1"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
