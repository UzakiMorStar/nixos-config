{config, pkgs, ...}: {
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
    openPorts = false;
    rpcSecretFile = config.sops.secrets."aria2_rpc_secret".path;
    settings = {
      dir = "/srv/downloads";
      rpc-listen-all = false;
      rpc-listen-port = 6800;
      rpc-allow-origin-all = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d /srv/downloads 0770 aria2 aria2 - -"
  ];
}
