{ config, ... }:
{
  home.file.".config/fish/conf.d/greeting.fish".text = ''
    function fish_greeting
        set -l trans_blue (set_color 55cdfc)
        set -l trans_pink (set_color f7a8b8)
        set -l trans_white (set_color ffffff)
        set -l reset (set_color normal)

        set -l lines \
            "Nya~~ Nya~~" \
            "MørStãr here~~" \
            "I am DEFINITELY NOT femboy btw" \
            "Coding, Gaming, dressing up today~~" \
            "Still Cis Tho"

        set -l colors \
            $trans_blue \
            $trans_pink \
            $trans_white \
            $trans_pink \
            $trans_blue

        set -l cols (tput cols 2>/dev/null; or echo 80)

        for i in (seq (count $lines))
            set -l text $lines[$i]
            set -l color $colors[$i]
            set -l visible_len (string length -- $text)
            set -l pad (math "floor(($cols - $visible_len) / 2)")

            if test $pad -gt 0
                echo -n (string repeat -n $pad ' ')
            end
            echo $color$text$reset
        end
    end
  '';
}
