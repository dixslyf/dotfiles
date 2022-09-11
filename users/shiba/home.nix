{ pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./programs
  ];

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.persistence."/persist/home/shiba" = {
    directories = [
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Videos"
      ".gnupg"
      ".local/share/Steam"
      ".local/share/lutris"
      ".config/lutris"
      ".local/share/osu"
      ".local/share/qutebrowser"
      ".local/state/wireplumber"
      ".local/share/Euro Truck Simulator 2"
    ];
    allowOther = true;
  };

  systemd.user.startServices = "sd-switch";
  services = {
    gpg-agent = {
      enable = true;
      enableFishIntegration = true;
      enableSshSupport = true;
    };
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
    };
    network-manager-applet.enable = true;
  };

  home.packages = with pkgs; [
    bottom
    keepassxc
    albert
    neofetch
    xfce.thunar
    fd
    udiskie
    lutris
    vlc
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin 
    xdragon
    wofi
  ];

  programs = {
    gpg.enable = true;
    ssh.enable = true;
    git = {
      enable = true;
      userEmail = "dixonseanlow@protonmail.com";
      userName = "Dixon Sean Low Yan Feng";
      signing = {
        key = "A9F388161E9B90C7!";
        signByDefault = true;
      };
    };
    gitui = {
      enable = true;
      keyConfig =
        ''
          (
            focus_right: Some(( code: Char('l'), modifiers: ( bits: 0,),)),
            focus_left: Some(( code: Char('h'), modifiers: ( bits: 0,),)),
            focus_above: Some(( code: Char('k'), modifiers: ( bits: 0,),)),
            focus_below: Some(( code: Char('j'), modifiers: ( bits: 0,),)),
            open_help: Some(( code: F(1), modifiers: ( bits: 0,),)),
            move_left: Some(( code: Char('h'), modifiers: ( bits: 0,),)),
            move_right: Some(( code: Char('l'), modifiers: ( bits: 0,),)),
            move_up: Some(( code: Char('k'), modifiers: ( bits: 0,),)),
            move_down: Some(( code: Char('j'), modifiers: ( bits: 0,),)),
            popup_up: Some(( code: Char('p'), modifiers: ( bits: 2,),)),
            popup_down: Some(( code: Char('n'), modifiers: ( bits: 2,),)),
            page_up: Some(( code: Char('b'), modifiers: ( bits: 2,),)),
            page_down: Some(( code: Char('f'), modifiers: ( bits: 2,),)),
            home: Some(( code: Char('g'), modifiers: ( bits: 0,),)),
            end: Some(( code: Char('G'), modifiers: ( bits: 1,),)),
            shift_up: Some(( code: Char('K'), modifiers: ( bits: 1,),)),
            shift_down: Some(( code: Char('J'), modifiers: ( bits: 1,),)),
            edit_file: Some(( code: Char('I'), modifiers: ( bits: 1,),)),
            status_reset_item: Some(( code: Char('U'), modifiers: ( bits: 1,),)),
            diff_reset_lines: Some(( code: Char('u'), modifiers: ( bits: 0,),)),
            diff_stage_lines: Some(( code: Char('s'), modifiers: ( bits: 0,),)),
            stashing_save: Some(( code: Char('w'), modifiers: ( bits: 0,),)),
            stashing_toggle_index: Some(( code: Char('m'), modifiers: ( bits: 0,),)),
            stash_open: Some(( code: Char('l'), modifiers: ( bits: 0,),)),
            abort_merge: Some(( code: Char('M'), modifiers: ( bits: 1,),)),
          )
        '';
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
    };
    kitty = {
      enable = true;
      settings = {
        shell = "fish";
      };
    };
    neovim.enable = true;
    firefox = {
      enable = true;
      profiles.default = {
        settings = {
          # Hardware video acceleration
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
    };
    qutebrowser.enable = true;
    feh.enable = true;
    nnn = {
      enable = true;
    };
    waybar = {
      enable = true;
    };
  };
}
