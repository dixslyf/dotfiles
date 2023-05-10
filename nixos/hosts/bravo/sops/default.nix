{ inputs
, ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    gnupg.sshKeyPaths = [ ]; # https://github.com/Mic92/sops-nix/issues/167
    age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "CACHIX_AGENT_TOKEN" = { };
      "user-passwords/samoyed" = {
        neededForUsers = true;
      };
      "user-passwords/root" = {
        neededForUsers = true;
      };
    };
  };
}
