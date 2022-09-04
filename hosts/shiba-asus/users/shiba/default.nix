{ ... }:

{
  users = {
    users = {
      shiba = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "video" "wheel" ];
        initialPassword = "";  # temporary
      };
    };
  };

  home-manager = {
    users = {
      shiba = import ./home.nix;
    };
  };
}
