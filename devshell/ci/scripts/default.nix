{ pkgs
, ...
}: {
  generate-deploy-spec-matrix = pkgs.resholve.writeScriptBin "generate-deploy-spec-matrix.sh"
    {
      interpreter = "${pkgs.bash}/bin/bash";
      inputs = with pkgs; [
        nix
        coreutils
        jq
        parallel
      ];
      fix = {
        # Workaround to get `resholve` to substitute the `nix` called by `parallel`
        "$NIX_COMMAND" = [ "${pkgs.nix}/bin/nix" ];
      };
      execer = [
        "cannot:${pkgs.nix}/bin/nix"
        # This is a lie, but `resholve` doesn't seem to be able to handle `parallel` properly.
        # Changing `cannot` to `can` or `might` results in an error.
        "cannot:${pkgs.parallel}/bin/parallel"
      ];
    }
    (builtins.readFile ./generate-deploy-spec-matrix.sh);

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
