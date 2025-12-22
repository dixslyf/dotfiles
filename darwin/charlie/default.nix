{
  config,
  pkgs,
  localFlake,
  ...
}:
{
  imports = [
    ./users
  ];

  environment.systemPackages = with pkgs; [
    neovim
  ];

  planet = {
    nix.enable = true;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = localFlake.rev or localFlake.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
  };

  # Required to bring in Nix's environment into fish.
  programs.fish = {
    enable = true;
  };

  nix-homebrew = {
    enable = true;
    user = config.users.users.corgi.name;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    casks = [
      "logseq"
      "zen"
      "unnaturalscrollwheels"
      "autoraiseapp"
      "yubico-authenticator"
      "keepassxc"
    ];
  };
}
