{ pkgs, ... }:

let
  scripts = import ./scripts { inherit pkgs; };
in
{
  packages = with pkgs; [ npins ] ++ (pkgs.lib.attrValues scripts);
}
