{ localFlakeInputs, ... }:

_: {
  imports = [
    localFlakeInputs.sops-nix.homeManagerModules.sops
  ];

  home.persistence."/persist/home/shiba" = {
    directories = [
      ".config/sops"
    ];
  };

  sops = {
    age.keyFile = "/persist/home/shiba/.config/sops/age/keys.txt";
  };
}
