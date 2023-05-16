{ config
, pkgs
, ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./sops
    ./users
  ];

  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "bravo";
    wireless.enable = true;
  };

  time.timeZone = "Asia/Singapore";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;

  i18n.defaultLocale = "en_SG.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05";

  planet.persistence = {
    enable = true;
    persistSystemdDirectories = true;
    persistLogs = true;
    persistSsh = true;
    persistMachineId = true;
  };

  services.cachix-agent = {
    enable = true;
    credentialsFile = config.sops.secrets."CACHIX_AGENT_TOKEN".path;
  };
}

