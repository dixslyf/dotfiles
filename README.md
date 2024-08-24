# <h1 align="center">`~/.` `dixslyf/dotfiles`</h1>

This repository contains [Nix](https://nixos.org/) configuration and dotfiles for my systems.

Overview:

- :snowflake: [NixOS](https://nixos.org/) + [Home Manager](https://github.com/nix-community/home-manager) + [Nix flakes](https://www.tweag.io/blog/2020-05-25-flakes/) + [flake-parts](https://github.com/hercules-ci/flake-parts)
- :floppy_disk: Opt-in persistence using [tmpfs](https://en.wikipedia.org/wiki/Tmpfs) as root + [Impermanence](https://github.com/nix-community/impermanence)
- :minidisc: [btrfs](https://btrfs.readthedocs.io/en/latest/Introduction.html) with [zstd](https://en.wikipedia.org/wiki/Zstd) compression + full disk encryption via [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup)
- :key: [sops](https://github.com/mozilla/sops) + [sops-nix](https://github.com/Mic92/sops-nix) for secrets provisioning
- :hammer: [GitHub Actions](https://docs.github.com/en/actions) + [Cachix](https://www.cachix.org/) for building and caching
- :office: [devenv](https://devenv.sh/) + [direnv](https://direnv.net/) for local shell environment

Software I use include:

- **Window Manager:** [bspwm](https://github.com/baskerville/bspwm)
- **Compositor:** [picom](https://github.com/yshui/picom)
- **Launcher:** [Rofi](https://github.com/davatorium/rofi)
- **Bar:** [Polybar](https://github.com/polybar/polybar)
- **Shell:** [fish](https://github.com/fish-shell/fish-shell) :fish:
- **Terminal:** [wezterm](https://github.com/wez/wezterm) + [Zellij](https://zellij.dev/)
- **Editor:** [Neovim](https://github.com/neovim/neovim)
- **File Manager:** [zoxide](https://github.com/ajeetdsouza/zoxide), [fzf](https://github.com/junegunn/fzf), `ls`, `cd`, `mv`, `cp`, `rm`; sometimes [Thunar](https://gitlab.xfce.org/xfce/thunar)
- **Web Browsers:** [Firefox](https://www.mozilla.org/en-US/firefox/browsers/), [qutebrowser](https://github.com/qutebrowser/qutebrowser)
- **Color scheme:** [Catppuccin](https://github.com/catppuccin/catppuccin)
- **Fonts:** [Iosevka](https://github.com/be5invis/Iosevka), [Material Design Icons](https://github.com/Templarian/MaterialDesign), [Mali](https://fonts.google.com/specimen/Mali)
