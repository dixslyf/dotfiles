{ lib
, modulesPath
, ...
}:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "none";
      fsType = "tmpfs";
      options = [ "size=1G" "mode=755" "noatime" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/CFAE-72EC";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/ff035932-080a-418d-860b-aec6443ac211";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/persist" =
    {
      device = "/dev/disk/by-uuid/ff035932-080a-418d-860b-aec6443ac211";
      fsType = "btrfs";
      options = [ "subvol=@persist" "compress=zstd" "noatime" ];
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/8db92cd5-1ca6-4088-9c19-36fe8ee29a25"; }];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
