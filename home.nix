{ config, pkgs, inputs, ... }:

{
  home.username = "morstar";
  home.homeDirectory = "/home/morstar";
  home.stateVersion = "26.05"; # 保持与你系统版本一致

  imports = [
    ./wechat-desktop-fix.nix
    ./bitwarden-ssh-agent.nix
  ];

  programs.git = {
  enable = true;
  signing = {
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAtct7KhFGEfKWFH8Sup3g1bW6VZv7iz2EPrhRW3ZMT8";
    signByDefault = true;
  };
  settings = {
    gpg.format = "ssh";
  };
};

  home.packages = with pkgs; [
    wechat
    mpv
    remmina
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
