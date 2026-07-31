{ config, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;

    settings = {
      font_size = 11.0;
      enable_tab_bar = false;
      window_padding = {
        left = 12;
        right = 12;
        top = 12;
        bottom = 12;
      };
      window_background_opacity = 0.8;
      default_cursor_style = "SteadyBlock";
      cursor_blink_rate = 500;
      scrollback_lines = 3023;
      hide_mouse_cursor_when_typing = true;
      freetype_load_target = "Light";

      colors = {
        foreground = "#e1e2e8";
        background = "#111418";
        cursor_bg = "#a1cafd";
        cursor_fg = "#111418";
        ansi = [
          "#111418"
          "#ff729b"
          "#7efd8f"
          "#fff772"
          "#87b6f0"
          "#274975"
          "#a1cafd"
          "#eff6ff"
        ];
        brights = [
          "#989da4"
          "#ff9fbb"
          "#a5ffb2"
          "#fffaa5"
          "#b0d3ff"
          "#bedbff"
          "#d5e7ff"
          "#f8fbff"
        ];
      };
    };

    extraConfig = ''
      config.font = wezterm.font_with_fallback {
        "JetBrainsMono Nerd Font",
        "Noto Sans CJK SC",
      }
    '';
  };
}
