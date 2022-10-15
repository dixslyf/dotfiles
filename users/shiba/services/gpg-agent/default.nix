{
  config,
  lib,
  ...
}: {
  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableSshSupport = true;
  };

  programs.fish.interactiveShellInit = lib.mkIf (config.services.gpg-agent.enableFishIntegration && config.services.gpg-agent.enableSshSupport) (lib.mkAfter ''
    ${config.programs.gpg.package}/bin/gpg-connect-agent updatestartuptty /bye > /dev/null
  '');
}
