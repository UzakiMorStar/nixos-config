{pkgs, ...}: {
  users.users."morstar" = {
    isNormalUser = true;
    description = "morstar";
    extraGroups = ["networkmanager" "wheel" "vboxusers" "wireshark"];
    shell = pkgs.fish;
  };
}
