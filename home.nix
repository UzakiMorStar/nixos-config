{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "morstar";
  home.homeDirectory = "/home/morstar";
  home.stateVersion = "26.05";

  imports = [
    ./modules/home/aria2.nix
    ./modules/home/wechat.nix
    ./modules/home/git.nix
    ./modules/home/wezterm.nix
    ./modules/home/fish
    ./modules/home/gtk.nix
    ./modules/home/hyfetch.nix
    ./modules/home/khal.nix
    ./modules/home/niri/niri.nix
    ./modules/home/bitwarden.nix
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets = {
      "nix_conf" = {
        sopsFile = ./secrets/nix.conf;
        format = "binary";
      };
    };
  };

  xdg.configFile."nix/nix.conf".source = config.lib.file.mkOutOfStoreSymlink config.sops.secrets."nix_conf".path;

  home.packages = with pkgs; [
    wechat
    mpv
    remmina
    wezterm
    eza
    steam-run
    bitwarden-desktop
    libreoffice-fresh
    piliplus
    discord-ptb
    heroic
    kazumi
    chromium
    telegram-desktop
    android-tools
    bat
    inputs.sidra.packages.${pkgs.stdenv.hostPlatform.system}.default
    stockfish
    en-croissant
    claude-code
    tsukimi
    protonplus
    ariang
    wl-clipboard
    cc-switch
    (pkgs.callPackage ./packages/kzzi-light.nix {})
    (pkgs.callPackage ./packages/kzzi-battery.nix {})
    (pkgs.callPackage ./packages/startfacetracker.nix {})
    (pkgs.callPackage ./packages/magiskboot.nix {})
    (import ./packages/videocaptioner-config.nix pkgs)
  ];

  programs.home-manager.enable = true;
}
