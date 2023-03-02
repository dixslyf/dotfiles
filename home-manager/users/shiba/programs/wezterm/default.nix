{ pkgs
, ...
}: {
  programs.wezterm = {
    enable = true;
  };

  xdg.configFile."wezterm/wezterm.lua".source = pkgs.substituteAll {
    src = pkgs.runCommand "wezterm.lua" { } ''
      ${pkgs.luaPackages.fennel}/bin/fennel --compile ${./wezterm.fnl} > "$out"
    '';
    default_shell = "${pkgs.fish}/bin/fish";
  };
}
