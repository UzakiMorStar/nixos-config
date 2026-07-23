{
  security.polkit.enable = true;
  security.sudo.enable = false;
  security.sudo-rs.enable = true;

  # udev rules — only morstar and root can access these USB HID devices.
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="04f3", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="04f3", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="36b0", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36b0", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="1209", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1209", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
  '';
}
