{pkgs, ...}: {
  # Niri compositor (Wayland).
  programs.niri.enable = true;

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    systemd.enable = true;
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/morstar";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
  ];

  fonts.fontconfig.subpixel.rgba = "rgb";

  fonts.fontconfig.localConf = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <alias binding="same"><family>monospace</family><prefer><family>Noto Color Emoji</family></prefer></alias>
    </fontconfig>
  '';

  environment.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    GTK_ICON_THEME = "Papirus-Dark";
  };

  environment.systemPackages = with pkgs; [
    git
    xdg-utils
    wget
    curl
    cups-pk-helper
    fastfetch
    hyfetch
    gcc
    unzip
    file
    zip
    vulkan-tools
    xwayland-satellite
    adwaita-icon-theme
    hicolor-icon-theme
    papirus-icon-theme
    catppuccin-cursors.macchiatoDark
    usbutils
  ];
}
