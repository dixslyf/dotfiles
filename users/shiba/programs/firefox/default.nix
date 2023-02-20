_: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        # Hardware video acceleration
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
      };
    };
  };

  home.persistence."/persist/home/shiba" = {
    directories = [ ".mozilla" ];
  };
}
