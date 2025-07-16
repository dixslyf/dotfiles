{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Adapted from: https://discourse.nixos.org/t/best-way-to-handle-boot-extramodulepackages-kernel-module-conflict/30729/6
  # Allows extraModulePackages to take priority over the built-in kernel packages when there are conflicts.
  # This is needed for the r8152 driver.
  system.modulesTree = lib.mkForce [
    (
      (
        (pkgs.aggregateModules (config.boot.extraModulePackages ++ [ config.boot.kernelPackages.kernel ]))
        .override
        { name = config.boot.kernelPackages.kernel.name or "kernel" + "-modules"; }
      ).overrideAttrs
      {
        # earlier items in the list above override the contents of later items
        ignoreCollisions = true;
      }
    )
  ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };
      grub = {
        enable = true;
        efiSupport = true;
        enableCryptodisk = true;
        devices = [ "nodev" ];
      };
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages =
      let
        # Newer version of the r8152 driver for RTL8157 support.
        realtek-8152 =
          config.boot.kernelPackages.callPackage pkgs.pers-pkgs.kernelModules.realtek-r8152
            { };
      in
      [
        realtek-8152
      ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "uas"
        "sd_mod"
      ];
      kernelModules = [ ];

      secrets = {
        "/keyfiles/boot.bin" = "/boot/keyfiles/boot.bin";
        "/keyfiles/root.bin" = "/boot/keyfiles/root.bin";
        "/keyfiles/swap.bin" = "/boot/keyfiles/swap.bin";
        "/keyfiles/home.bin" = "/boot/keyfiles/home.bin";
      };

      luks.devices = {
        "boot" = {
          device = "/dev/disk/by-uuid/cbc19986-1e63-4af0-9730-bbbe2f3b28f7";
          keyFile = "/keyfiles/boot.bin";
          allowDiscards = true;
        };
        "root" = {
          device = "/dev/disk/by-uuid/b9004b54-8415-4754-81c4-61ae7c8580bd";
          keyFile = "/keyfiles/root.bin";
          allowDiscards = true;
        };
        "home" = {
          device = "/dev/disk/by-uuid/a0b00281-a8e6-4b9f-942f-5e975efc9b69";
          keyFile = "/keyfiles/home.bin";
          allowDiscards = true;
        };
        "swap" = {
          device = "/dev/disk/by-uuid/0a936449-13c7-47d5-a091-2f768b6eb3db";
          keyFile = "/keyfiles/swap.bin";
        };
      };
    };
    tmp.useTmpfs = true; # defaults to 50% of RAM
  };

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "size=8G"
        "mode=755"
        "noatime"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/40fcf0a0-13cc-47c4-83bb-f83df975df8e";
      fsType = "ext4";
      neededForBoot = true;
    };
    "/efi" = {
      device = "/dev/disk/by-uuid/CDE8-57B1";
      fsType = "vfat";
      options = [ "noatime" ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/5315a5dd-a383-409a-b8b0-33bbc9d57a17";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd:1"
        "noatime"
      ];
    };
    "/persist" = {
      device = "/dev/disk/by-uuid/5315a5dd-a383-409a-b8b0-33bbc9d57a17";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=@persist"
        "compress=zstd:1"
        "noatime"
      ];
    };
    "/persist/home" = {
      device = "/dev/disk/by-uuid/e4cc116c-4044-4b91-8618-86ee4ba59373";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "compress=zstd:2"
        "noatime"
      ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/24ea210c-9f50-4de4-8900-49a851dbe94e"; }
  ];

  # `intel_pstate` only has either `powersave` and `performance`
  # https://wiki.archlinux.org/title/CPU_frequency_scaling#Scaling_governors
  powerManagement.cpuFreqGovernor = "powersave";

  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia = {
      # Must be set explicitly since https://github.com/NixOS/nixpkgs/commit/20c5d0adfb4cd7a06b7c1251cb0852f404d93e59
      open = false;
      modesetting.enable = true;
      # Set up nvidia prime
      prime = {
        offload.enable = true;
        # Can be found using lspci, either under 3D or VGA
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
      };
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };
    bluetooth.enable = true;
    # opentabletdriver.enable = true;
  };
}
