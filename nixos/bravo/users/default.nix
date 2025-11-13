{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./samoyed
  ];

  users = {
    mutableUsers = false;
    users.root.hashedPasswordFile = config.sops.secrets."user-passwords/root".path;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
