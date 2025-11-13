{
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

  nix.settings.experimental-features = "nix-command flakes";

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
}
