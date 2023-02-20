{ pkgs, ... }: {
  home.packages = with pkgs; [ lutris ];
  home.persistence."/persist/home/shiba" = {
    directories = [
      ".config/lutris"
      ".local/share/lutris"
    ];
  };
}
