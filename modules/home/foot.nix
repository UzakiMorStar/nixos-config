{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=9.5,Noto Sans CJK SC:size=9.5";
        pad = "12x12";
        dpi-aware = "yes";
        bold-text-in-bright = "yes";
      };

      cursor = {
        style = "block";
        blink = "yes";
      };

      scrollback = {
        lines = "3023";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      csd = {
        preferred = "none";
      };

      "colors-dark" = {
        alpha = "0.8";
        background = "111418";
        foreground = "e1e2e8";
        cursor = "111418 a1cafd";

        regular0 = "111418";
        regular1 = "ff729b";
        regular2 = "7efd8f";
        regular3 = "fff772";
        regular4 = "87b6f0";
        regular5 = "274975";
        regular6 = "a1cafd";
        regular7 = "eff6ff";

        bright0 = "989da4";
        bright1 = "ff9fbb";
        bright2 = "a5ffb2";
        bright3 = "fffaa5";
        bright4 = "b0d3ff";
        bright5 = "bedbff";
        bright6 = "d5e7ff";
        bright7 = "f8fbff";
      };
    };
  };
}
