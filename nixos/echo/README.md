# Echo

Echo is a desktop PC (Aftershock Hypergate M):

- **Chassis:** NZXT H3 Flow
- **Motherboard:** ASUS TUF Gaming B850M-Plus
- **Processor:** AMD Ryzen 7 7700
- **GPU:** Radeon RX 9060 XT
- **RAM:** 2x 16GB DDR5 6400MHz CL32
- **Storage:** 2TB Gen4 SSD
- **Cooling:** Thermalright Peerless Assassin 120 SE
- **Power supply:** Deepcool PQ850G

## System Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/dixslyf/dotfiles.git
   cd dotfiles
   ```

1. Format the NVMe:

   ```bash
   sudo nix run github:nix-community/disko/latest \
       --experimental-features "nix-command flakes" \
       -- \
       --mode destroy,format,mount \
       --flake ".#echo"
   ```

   Note that the command above will prompt for a crypt password and then mount the partitions under `/mnt`.
   You should see `/mnt/boot`, `/mnt/nix` and `/mnt/persist`.

1. Copy over the age private keys for `sops-nix`:

   ```bash
   # System key
   sudo mkdir -p /mnt/persist/var/lib/sops-nix
   sudo cp -a <path to system key> /mnt/persist/var/lib/sops-nix/key.txt

   # User key
   mkdir -p /mnt/persist/home/akita/.config/sops/age
   cp -a <path to user key> /mnt/persist/home/akita/.config/sops/age/key.txt
   ```

   Once copied, check the ownership and permissions of the keys.
   The system key should be owned by `root` (UID 0)
   while the user key should be owned by UID 1000 (as set in the NixOS configuration for user `akita`).
   If they are incorrect, set them with `chown <uid> <path to key.txt>`.
   The permissions of the keys should be `0400`.
   If they are not, correct them with `chmod 0400 <path to key.txt>`.

1. Install NixOS:

   ```bash
   sudo nixos-install \
       --option extra-substituters "https://dixslyf.cachix.org" \
       --option extra-trusted-public-keys "dixslyf.cachix.org-1:6x8b4tr/2LBObGAlAGS1fbW3B3nK1FvL0CH9uRxjmI4=" \
       --flake ".#echo"
   ```

   The above will prompt you to set a root password
   — since we set user passwords declaratively (using `sops-nix` to manage them),
   the password you give to the prompt will be ignored.

1. Reboot!
