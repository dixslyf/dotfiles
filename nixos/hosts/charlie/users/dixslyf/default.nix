{
  config,
  homeUsers,
  ...
}:
{
  users = {
    users = {
      dixslyf = {
        name = "dixslyf";
        home = "/Users/dixslyf";
      };
    };
  };

  home-manager = {
    users = {
      dixslyf = {
        imports = [
          homeUsers.dixslyf.homeConfiguration
        ];
      };
    };
  };
}
