{
  homeUsers,
  ...
}:
{
  users = {
    users = {
      corgi = {
        name = "dixslyf";
        home = "/Users/dixslyf";
      };
    };
  };

  home-manager = {
    users = {
      corgi = {
        imports = [
          homeUsers.corgi.homeConfiguration
        ];
      };
    };
  };
}
