{pkgs, ...}: {
  users.users."morstar" = {
    isNormalUser = true;
    description = "morstar";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "kvm" "wireshark" "aria2"];
    shell = pkgs.fish;
  };
}
