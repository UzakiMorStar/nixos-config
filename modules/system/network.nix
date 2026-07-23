{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    checkReversePath = false;
  };

  services.openssh.enable = true;

  services.mihomo = {
    enable = true;
    configFile = config.sops.secrets."mihomo_config".path;
    tunMode = true;
    webui = pkgs.zashboard;
  };
}
