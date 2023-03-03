{ pkgs
, ...
}: {
  home.packages = with pkgs; [ yuzu-mainline ];
  planet.persistence = {
    directories = [
      ".config/yuzu"
      ".local/share/yuzu"
    ];
  };
}
