{ config, pkgs, inputs, ... }:

{
  home.username = "morstar";
  home.homeDirectory = "/home/morstar";
  home.stateVersion = "26.05";

  imports = [
    ./modules/home/wechat.nix
    ./modules/home/git.nix
    inputs.sops-nix.homeManagerModules.sops
    ./modules/home/alacritty.nix
    ./modules/home/fish.nix
    ./modules/home/gtk.nix
    ./modules/home/hyfetch.nix
    ./modules/home/khal.nix
    ./modules/home/niri.nix
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets = {
      "claude_settings" = {
        sopsFile = ./secrets/claude-settings.json;
        format = "binary";
      };
      "nix_conf" = {
        sopsFile = ./secrets/nix.conf;
        format = "binary";
      };
    };
  };

  home.file.".claude/settings.json".source = config.lib.file.mkOutOfStoreSymlink config.sops.secrets."claude_settings".path;
  xdg.configFile."nix/nix.conf".source = config.lib.file.mkOutOfStoreSymlink config.sops.secrets."nix_conf".path;

  home.packages = with pkgs; [
    wechat
    mpv
    remmina
    alacritty
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
    inputs.sidra.packages.${pkgs.stdenv.hostPlatform.system}.default
    stockfish
    en-croissant
    claude-code
    (pkgs.writers.writePython3Bin "kzzi-light" {
     libraries = [ pkgs.python3Packages.hidapi ];
    } (builtins.readFile ./scripts/kzzi_light.py))
    (pkgs.writers.writePython3Bin "kzzi-battery" {
     libraries = [ pkgs.python3Packages.hidapi ];
    } (builtins.readFile ./scripts/kzzi_battery.py))
    (pkgs.writeShellApplication {
       name = "startfacetracker";
       runtimeInputs = [ pkgs.openseeface ];
       text = builtins.readFile ./scripts/start_face_tracker.sh;
    })
    (pkgs.callPackage ./packages/magiskboot.nix {})
    (import ./videocaptioner-config.nix pkgs)
  ];

  programs.home-manager.enable = true;
}
