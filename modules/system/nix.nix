{config, ...}: {
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "26.05";

  sops = {
    age.keyFile = "/home/morstar/.config/sops/age/keys.txt";
    secrets = {
      mihomo_config = {
        sopsFile = ../../secrets/mihomo-config.yaml;
        format = "binary";
      };
    };
  };
}
