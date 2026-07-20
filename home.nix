{ config, pkgs, inputs, ... }:

{
  home.username = "morstar";
  home.homeDirectory = "/home/morstar";
  home.stateVersion = "26.05";

  imports = [
    ./wechat-desktop-fix.nix
    ./bitwarden-ssh-agent.nix
    ./git-config.nix
    ./fish-greeting.nix
  ];

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
    } (builtins.readFile ./kzzi_light.py))
    (pkgs.writers.writePython3Bin "kzzi-battery" {
     libraries = [ pkgs.python3Packages.hidapi ];
    } (builtins.readFile ./kzzi_battery.py))
    (pkgs.writeShellApplication {
       name = "startfacetracker";
       runtimeInputs = [ pkgs.openseeface ];
       text = builtins.readFile ./start_face_tracker.sh;
    })
    (pkgs.callPackage ./packages/magiskboot.nix {})
    (import ./videocaptioner-config.nix pkgs)
  ];

  programs.home-manager.enable = true;
}
