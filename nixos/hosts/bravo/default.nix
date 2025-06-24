{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware
    ./sops
    ./users
  ];

  boot = {
    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    swraid.enable = false; # https://github.com/NixOS/nixpkgs/issues/254807
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://dixslyf.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "dixslyf.cachix.org-1:6x8b4tr/2LBObGAlAGS1fbW3B3nK1FvL0CH9uRxjmI4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
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
    enable = false;
    credentialsFile = config.sops.secrets."CACHIX_AGENT_TOKEN".path;
  };
}
