{ pkgs
, ...
}: {
  configure-git-user = pkgs.resholve.writeScriptBin "configure-git-user.sh"
    {
      interpreter = "${pkgs.bash}/bin/bash";
      inputs = with pkgs; [
        coreutils
        git
      ];
      execer = [
        "cannot:${pkgs.git}/bin/git"
      ];
    }
    (builtins.readFile ./configure-git-user.sh);
}
