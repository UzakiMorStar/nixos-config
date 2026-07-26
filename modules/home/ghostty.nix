{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ ghostty ];

  systemd.user.services."app-com.mitchellh.ghostty" = {
    Unit = {
      Description = "Ghostty";
      After = [ "graphical-session.target" "dbus.socket" ];
      Requires = [ "dbus.socket" ];
    };
    Service = {
      Type = "dbus";
      BusName = "com.mitchellh.ghostty";
      ExecStart = "${pkgs.ghostty}/bin/ghostty --initial-window=false";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  xdg.configFile."ghostty/config".text = ''

    # Window
    window-decoration = false
    window-inherit-working-directory = false
    working-directory = home
    gtk-single-instance = true
    quit-after-last-window-closed = false
    window-padding-x = 12
    window-padding-y = 12
    background-opacity = 0.8

    # Rendering
    alpha-blending = native

    # Scrolling
    scrollback-limit = 3023

    # Font
    font-size = 11.5
    font-family = "JetBrainsMono Nerd Font"
    font-family = "Noto Sans CJK SC"
    freetype-load-flags = no-autohint
    bold-is-bright = true

    # Cursor
    cursor-style = block
    cursor-style-blink = true

    # Mouse
    mouse-hide-while-typing = true

    copy-on-select = false

    # Colors
    background = #111418
    foreground = #e1e2e8
    cursor-color = #a1cafd
    cursor-text = #111418
    selection-background = #1a4975
    selection-foreground = #e1e2e8

    palette = 0=#111418
    palette = 1=#ff729b
    palette = 2=#7efd8f
    palette = 3=#fff772
    palette = 4=#87b6f0
    palette = 5=#274975
    palette = 6=#a1cafd
    palette = 7=#eff6ff
    palette = 8=#989da4
    palette = 9=#ff9fbb
    palette = 10=#a5ffb2
    palette = 11=#fffaa5
    palette = 12=#b0d3ff
    palette = 13=#bedbff
    palette = 14=#d5e7ff
    palette = 15=#f8fbff

    # Keybindings
    keybind = ctrl+shift+c=copy_to_clipboard
    keybind = ctrl+shift+v=paste_from_clipboard
    keybind = ctrl+shift+n=new_window
    keybind = ctrl+plus=increase_font_size:1
    keybind = ctrl+minus=decrease_font_size:1
    keybind = ctrl+0=reset_font_size
    keybind = shift+enter=text:\n
  '';
}
