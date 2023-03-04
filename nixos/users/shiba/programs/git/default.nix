_: {
  imports = [ ./gitui ];

  programs.git = {
    enable = true;
    userEmail = "dixonseanlow@protonmail.com";
    userName = "Dixon Sean Low Yan Feng";
    signing = {
      key = "A9F388161E9B90C7!";
      signByDefault = true;
    };
    extraConfig = {
      merge = {
        conflictStyle = "zdiff3";
      };
    };
  };
}
