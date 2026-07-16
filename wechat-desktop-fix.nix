{ config, pkgs, ... }:

{
  xdg.desktopEntries.wechat = {
    name = "WeChat";
    genericName = "WeChat";
    exec = "env WAYLAND_DISPLAY= DISPLAY=:0 QT_QPA_PLATFORM=xcb GTK_IM_MODULE=fcitx QT_IM_MODULE=fcitx XMODIFIERS=@im=fcitx wechat %U";
    terminal = false;
    categories = [ "Utility" "Network" ];
    icon = "wechat";
    comment = "Wechat Desktop";
  };
}
