{ pkgs, ... }: {
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
  ];
  planet.persistence = {
    directories = [
      "/var/lib/libvirt"
    ];
  };
}
