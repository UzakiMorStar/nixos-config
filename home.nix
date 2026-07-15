{ config, pkgs, ... }:

{
  home.username = "morstar";
  home.homeDirectory = "/home/morstar";
  home.stateVersion = "26.05"; # 保持与你系统版本一致

  imports = [
    ./wechat-desktop-fix.nix
  ];

  home.packages = with pkgs; [
    wechat
  ];

  programs.home-manager.enable = true;
}
