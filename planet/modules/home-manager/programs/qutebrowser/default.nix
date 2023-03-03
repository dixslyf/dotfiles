_: {
  programs.qutebrowser = {
    enable = true;
    extraConfig = ''
      config.set('content.javascript.can_access_clipboard', True, 'github.com')
    '';
  };
}
