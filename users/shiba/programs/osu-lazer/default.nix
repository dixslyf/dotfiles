{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin];
  home.persistence."/persist/home/shiba".directories = [".local/share/osu"];
}
