{
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "CACHIX_AGENT_TOKEN" = { };
      "user-passwords/shiba" = {
        neededForUsers = true;
      };
      "user-passwords/root" = {
        neededForUsers = true;
      };
    };
  };
}
