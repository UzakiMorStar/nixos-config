{ config, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        decorations = "None";
        padding = { x = 12; y = 12; };
        opacity = 0.8;
      };

      scrolling.history = 3023;

      cursor = {
        style.shape = "Block";
        style.blinking = "On";
        blink_interval = 500;
        unfocused_hollow = true;
      };

      mouse.hide_when_typing = true;

      selection.save_to_clipboard = false;

      bell.duration = 0;

      keyboard.bindings = [
        { key = "C";      mods = "Control|Shift"; action = "Copy"; }
        { key = "V";      mods = "Control|Shift"; action = "Paste"; }
        { key = "N";      mods = "Control|Shift"; action = "SpawnNewInstance"; }
        { key = "Equals"; mods = "Control|Shift"; action = "IncreaseFontSize"; }
        { key = "Minus";  mods = "Control";       action = "DecreaseFontSize"; }
        { key = "Key0";   mods = "Control";       action = "ResetFontSize"; }
        { key = "Enter";  mods = "Shift";         chars = "\\n"; }
        { key = "Return"; mods = "Shift";         chars = "\\u001B\\r"; }
      ];

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
      };

      colors = {
        primary = {
          background = "#111418";
          foreground = "#e1e2e8";
        };
        selection = {
          text = "#e1e2e8";
          background = "#1a4975";
        };
        cursor = {
          text = "#111418";
          cursor = "#a1cafd";
        };
        normal = {
          black   = "#111418";
          red     = "#ff729b";
          green   = "#7efd8f";
          yellow  = "#fff772";
          blue    = "#87b6f0";
          magenta = "#274975";
          cyan    = "#a1cafd";
          white   = "#eff6ff";
        };
        bright = {
          black   = "#989da4";
          red     = "#ff9fbb";
          green   = "#a5ffb2";
          yellow  = "#fffaa5";
          blue    = "#b0d3ff";
          magenta = "#bedbff";
          cyan    = "#d5e7ff";
          white   = "#f8fbff";
        };
      };
    };
  };
}
