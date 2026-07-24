{ pkgs, ... }:

{
  xdg.configFile."autostart/bitwarden.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Bitwarden
    Comment=Bitwarden startup script
    Exec=${pkgs.bitwarden-desktop}/bin/bitwarden --autostart
    StartupNotify=false
    Terminal=false
  '';
}
