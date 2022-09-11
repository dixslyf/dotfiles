{ ... }:

{
  programs.gitui = {
    enable = true;
    keyConfig = builtins.readFile ./key_bindings.ron;
  };
}
