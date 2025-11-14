{
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age.keyFile = "/persist/var/lib/sops-nix/key.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "user-passwords/root" = {
        neededForUsers = true;
      };
      "user-passwords/husky" = {
        neededForUsers = true;
      };
    };
  };
}
