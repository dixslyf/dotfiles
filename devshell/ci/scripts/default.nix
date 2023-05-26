{ pkgs
, ...
}: {
  generate-deploy-spec-matrix = pkgs.resholve.writeScriptBin "generate-deploy-spec-matrix.sh"
    {
      interpreter = "${pkgs.bash}/bin/bash";
      inputs = with pkgs; [
        coreutils
        nix-eval-jobs
        jq
      ];
    }
    (builtins.readFile ./generate-deploy-spec-matrix.sh);

  generate-cache-key = pkgs.resholve.writeScriptBin "generate-cache-key.sh"
    {
      interpreter = "${pkgs.bash}/bin/bash";
      inputs = with pkgs; [
        coreutils
        jq
      ];
    }
    (builtins.readFile ./generate-cache-key.sh);

  generate-npins-matrix = pkgs.resholve.writeScriptBin "generate-npins-matrix.sh"
    {
      interpreter = "${pkgs.bash}/bin/bash";
      inputs = with pkgs; [
        coreutils
        jq
      ];
    }
    (builtins.readFile ./generate-npins-matrix.sh);

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

  commit-and-format-patch = pkgs.resholve.writeScriptBin "commit-and-format-patch.sh"
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
    (builtins.readFile ./commit-and-format-patch.sh);
}
