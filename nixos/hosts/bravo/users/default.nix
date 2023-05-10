{ config
, ...
}: {
  imports = [
    ./samoyed
  ];

  users = {
    mutableUsers = false;
    users.root.passwordFile = config.sops.secrets."user-passwords/root".path;
  };
}
