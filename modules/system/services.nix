{pkgs, ...}: {
  programs.fish.enable = true;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    usbmon.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.obs-studio.enable = true;
}
