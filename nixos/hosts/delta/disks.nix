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
    persistSsh = true;
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
                # initrdUnlock = true;
                extraOpenArgs = [
                  "--allow-discards"
                ];
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = persistDirectory;
                  mountOptions = [
                    "defaults"
                    "relatime"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
