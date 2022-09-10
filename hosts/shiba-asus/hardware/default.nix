{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

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
    initrd = {
      secrets = {
        "/keyfiles/boot.bin" = "/boot/keyfiles/boot.bin";
        "/keyfiles/root.bin" = "/boot/keyfiles/root.bin";
        "/keyfiles/swap.bin" = "/boot/keyfiles/swap.bin";
        "/keyfiles/home.bin" = "/boot/keyfiles/home.bin";
      };
      luks.devices = {
        "boot" = {
          keyFile = "/keyfiles/boot.bin";
          allowDiscards = true;
        };
        "root" = {
          keyFile = "/keyfiles/root.bin";
          allowDiscards = true;
        };
        "home" = {
          keyFile = "/keyfiles/home.bin";
        };
        "swap" = {
          device = "/dev/disk/by-uuid/aa90c2fe-6966-44b9-9dec-42d54c2217db";
          keyFile = "/keyfiles/swap.bin";
        };
      };
    };
  };

  fileSystems = {
    "/" = { options = [ "size=2G" "mode=755" "noatime" ]; };
    "/boot" = { neededForBoot = true; };
    "/efi" = { options = [ "noatime" ]; };
    "/nix" = { options = [ "compress=zstd" "noatime" ]; };
    "/persist" = {
      neededForBoot = true;
      options = [ "compress=zstd" "noatime" ];
    };
    "/persist/home" = {
      neededForBoot = true;
      options = [ "compress=zstd" "noatime" ];
    };
  };

  zramSwap.enable = true;

  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia = {
      modesetting.enable = true;
      # Set up nvidia prime
      prime = {
        offload.enable = true;
        # Can be found using lspci, either under 3D or VGA
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
      };
    };
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
}