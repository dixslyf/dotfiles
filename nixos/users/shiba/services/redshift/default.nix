{ pkgs, ... }: {
  home.packages = with pkgs; [ redshift ];
  xdg.configFile."redshift/redshift.conf".source = ./redshift.conf;
}
