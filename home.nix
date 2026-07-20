{ config, pkgs, inputs, ... }:

{
  home.username = "morstar";
  home.homeDirectory = "/home/morstar";
  home.stateVersion = "26.05";

  imports = [
    inputs.dsearch.homeModules.default
    ./wechat-desktop-fix.nix
    ./bitwarden-ssh-agent.nix
    ./git-config.nix
    ./fish-greeting.nix
  ];

  programs.dsearch.enable = true;
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
    claude-code-bin
    (pkgs.writeShellApplication {
       name = "kzzi-light";
       runtimeInputs = [ (pkgs.python3.withPackages (ps: [ ps.hidapi ])) ];
       text = builtins.readFile ./kzzi_light.sh;
    })
    (pkgs.writers.writePython3Bin "kzzi-battery" {
     libraries = [ pkgs.python3Packages.hidapi ];
    } (builtins.readFile ./kzzi_battery.py))
    (pkgs.writeShellApplication {
       name = "startfacetracker";
       runtimeInputs = [ pkgs.openseeface ];
       text = builtins.readFile ./start_face_tracker.sh;
    })
  ];

  programs.home-manager.enable = true;
}
