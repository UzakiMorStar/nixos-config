{ config, ... }:

let
  nixos2Ascii = ''
            __    ____    __
           /  \   \   \  /  \
           \   \   \   \/   /
         ___\   \___\      /
        /            \    /   /\
       /______________\   \  /  \
            /   /      \   \/   /
     ______/   /        \  /   /___
    /         /          \/        \
    \____    /\          /   ______/
        /   /  \        /   /
       /   /\   \______/___/_____
       \  /  \   \              /
        \/   /    \____    ____/
            /      \   \   \
           /   /\   \   \   \
           \__/  \___\   \__/
  '';
in
{
  home.file = {
    ".config/hyfetch/nixos2.ascii".text = nixos2Ascii;
    ".config/hyfetch.json".text = builtins.toJSON {
      preset = "transgender";
      mode = "rgb";
      auto_detect_light_dark = true;
      light_dark = "dark";
      lightness = 0.65;
      color_align.mode = "horizontal";
      backend = "fastfetch";
      args = "--disable-linewrap";
      distro = null;
      pride_month_disable = false;
      custom_ascii_path = "/home/morstar/.config/hyfetch/nixos2.ascii";
      custom_presets = null;
      palette_glyph = null;
      palette_type = null;
    };
  };
}
