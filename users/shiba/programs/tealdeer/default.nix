_: {
  programs.tealdeer = {
    enable = true;
    settings = {
      display = {
        use_pager = true;
        compact = true;
      };
      updates = {
        auto_update = true;
        auto_update_interval_hours = 168;
      };
    };
  };
}
