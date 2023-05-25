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
}
