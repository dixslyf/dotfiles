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
}
