{ inputs, ... }: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    gnupg.home = "/persist/home/shiba/.gnupg";
  };
}
