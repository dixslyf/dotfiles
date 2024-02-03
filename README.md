# <h1 align="center">`~/.` `dixslyf/dotfiles`</h1>

This repository contains my system configurations written in [Nix](https://nixos.org/).

Here is an overview of some characteristics and tools you might see in my configurations:
* :snowflake: [NixOS](https://nixos.org/) + [Home Manager](https://github.com/nix-community/home-manager) + [Nix flakes](https://www.tweag.io/blog/2020-05-25-flakes/) + [flake-parts](https://github.com/hercules-ci/flake-parts)
* :floppy_disk: Opt-in persistence using [tmpfs](https://en.wikipedia.org/wiki/Tmpfs) as root + [Impermanence](https://github.com/nix-community/impermanence)
* :minidisc: [btrfs](https://btrfs.readthedocs.io/en/latest/Introduction.html) with [zstd](https://en.wikipedia.org/wiki/Zstd) compression + full disk encryption via [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup)
* :key: [sops](https://github.com/mozilla/sops) + [sops-nix](https://github.com/Mic92/sops-nix) for secrets provisioning
* :cloud: Deployments with [Cachix](https://www.cachix.org/) + [GitHub Actions](https://docs.github.com/en/actions)
* :office: [devenv](https://devenv.sh/) + [direnv](https://direnv.net/) for local shell environment

Application software I use include:
* **Window Managers:** [bspwm](https://github.com/baskerville/bspwm) (Xorg), [Hyprland](https://github.com/hyprwm/Hyprland) (Wayland)
* **Compositors:** [picom](https://github.com/yshui/picom) (Xorg), [Hyprland](https://github.com/hyprwm/Hyprland) (Wayland)
* **Launchers:** [Rofi](https://github.com/davatorium/rofi) (Xorg), [Wofi](https://hg.sr.ht/~scoopta/wofi) (Wayland)
* **Bars:** [Polybar](https://github.com/polybar/polybar) (Xorg), [Waybar](https://github.com/Alexays/Waybar) (Wayland)
* **Shell:** [fish](https://github.com/fish-shell/fish-shell) :fish:
* **Terminals:** [wezterm](https://github.com/wez/wezterm), [kitty](https://github.com/kovidgoyal/kitty) :cat2:
* **Editor:** [Neovim](https://github.com/neovim/neovim)
* **File Manager:** [zoxide](https://github.com/ajeetdsouza/zoxide), [fzf](https://github.com/junegunn/fzf), `ls`, `cd`, `mv`, `cp`, `rm`; sometimes [Thunar](https://gitlab.xfce.org/xfce/thunar)
* **Web Browsers:** [qutebrowser](https://github.com/qutebrowser/qutebrowser), [Firefox](https://www.mozilla.org/en-US/firefox/browsers/)
* **Color scheme:** [Catppuccin](https://github.com/catppuccin/catppuccin)
* **Fonts:** [Mali](https://fonts.google.com/specimen/Mali), [Iosevka](https://github.com/be5invis/Iosevka), [Material Design Icons](https://github.com/Templarian/MaterialDesign)
