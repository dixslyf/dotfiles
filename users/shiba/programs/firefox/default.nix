{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        # Hardware video acceleration
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
      };
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      sponsorblock
      duckduckgo-privacy-essentials
      privacy-badger
      cookie-autodelete
      darkreader
      vimium
    ];
  };
}
