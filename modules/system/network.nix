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

  environment.etc."sing-box-dashboard".source = pkgs.sing-box-dashboard;

  services.sing-box = {
    enable = true;
    package = pkgs.sing-box-ref1nd;
    settings = {
      _secret = config.sops.secrets."sing-box-config".path;
      quote = false;
    };
  };
}
