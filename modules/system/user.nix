{pkgs, ...}: {
  users.users."morstar" = {
    isNormalUser = true;
    description = "morstar";
    extraGroups = ["networkmanager" "wheel" "wireshark"];
    shell = pkgs.fish;
  };
}
