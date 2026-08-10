{pkgs, config, ...}: {
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

  services.aria2 = {
    enable = true;
    rpcSecretFile = config.sops.secrets.aria2_rpc_token.path;
    settings = {
      dir = "/home/morstar/Downloads";
      rpc-listen-port = 6800;
      max-concurrent-downloads = 3;
      max-connection-per-server = 4;
      split = 4;
      continue = true;
    };
  };
}
