{
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "size=1G"
        "mode=755"
        "noatime"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/CFAE-72EC";
      fsType = "vfat";
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/ff035932-080a-418d-860b-aec6443ac211";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd"
        "noatime"
      ];
    };
    "/persist" = {
      device = "/dev/disk/by-uuid/ff035932-080a-418d-860b-aec6443ac211";
      fsType = "btrfs";
      options = [
        "subvol=@persist"
        "compress=zstd"
        "noatime"
      ];
      neededForBoot = true;
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/8db92cd5-1ca6-4088-9c19-36fe8ee29a25"; }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  nixpkgs.hostPlatform = "aarch64-linux";
}
