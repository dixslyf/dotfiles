# Delta

Delta is a ThinkPad P14s Gen 6 (14" Intel).

## System Setup

1. Clone the repository:

    ```
    git clone https://github.com/dixslyf/dotfiles.git
    cd dotfiles
    ```

1. Format the NVMe:

    ```
    sudo nix run github:nix-community/disko/latest --experimental-features "nix-command flakes" -- --mode destroy,format,mount --flake .#delta
    ```

    Note that the command above will prompt for a crypt password and then mount the partitions under `/mnt`.
    You should see `/mnt/boot`, `/mnt/nix` and `/mnt/persist`.

1. Copy over the age private keys for `sops-nix`:

    ```
    # System key
    sudo mkdir -p /mnt/persist/var/lib/sops-nix
    sudo cp -a <path to system key> /mnt/persist/var/lib/sops-nix/key.txt

    # User key
    mkdir -p /mnt/persist/home/husky/.config/sops/age
    cp -a <path to user key> /mnt/persist/home/husky/.config/sops/age/key.txt
    ```

    Once copied, check the ownership and permissions of the keys.
    The system key should be owned by `root` (UID 0)
    while the user key should be owned by UID 1000 (as set in the NixOS configuration for user `husky`).
    If they are incorrect, set them with `chown <uid> <path to key.txt>`.
    The permissions of the keys should be `0400`.
    If they are not, correct them with `chmod 0400 <path to key.txt>`.

1. Install NixOS:

    ```
    sudo nixos-install --flake .#delta
    ```

    Note that the above will prompt you to set a root password
    — since we set user passwords declaratively (using `sops-nix` to manage them),
    the password you give to the prompt will be ignored.

1. Reboot!
