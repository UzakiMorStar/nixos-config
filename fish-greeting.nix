{ config, ... }:
{
  home.file.".config/fish/conf.d/greeting.fish".text = ''
    set -l trans_blue (set_color 55cdfc)
    set -l trans_pink (set_color f7a8b8)
    set -l trans_white (set_color ffffff)
    set -l reset (set_color normal)

    set -g fish_greeting "$trans_blue""Nya~~ Nya~~
    $trans_pink""MørStãr here~~
    $trans_white""I am DEFINITELY NOT femboy btw
    $trans_pink""Coding, Gaming, dressing up today~~
    $trans_blue""Still Cis Tho$reset"
  '';
}
