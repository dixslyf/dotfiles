{ pkgs, ... }: {
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
    virtiofsd
  ];
  planet.persistence = {
    directories = [
      "/var/lib/libvirt"
    ];
  };
}
