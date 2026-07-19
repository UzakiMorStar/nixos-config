{ config, ... }:
{
  home.file.".config/fish/conf.d/greeting.fish".text = ''
    set -g fish_greeting "MorStar Here! Definitely NOT femboy, nya~~~"
  '';
}
