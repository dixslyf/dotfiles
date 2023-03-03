{ pkgs
, ...
}: {
  home.packages = with pkgs; [ citra-nightly ];
  planet.persistence = {
    directories = [
      ".config/citra-emu"
      ".local/share/citra-emu"
    ];
  };
}
