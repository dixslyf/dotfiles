_:

{
  fileSystems."/persist".neededForBoot = true;
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512MiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
                mountOptions = [ "defaults" ];
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
                  mountpoint = "/persist";
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
