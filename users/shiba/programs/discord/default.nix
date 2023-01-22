{pkgs, ...}: {
  home.packages = with pkgs; [
    pvtpkgs.discord
  ];

  home.persistence."/persist/home/shiba".directories = [
    ".config/discord"
  ];
}
