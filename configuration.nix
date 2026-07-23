{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "tun" "usbmon" ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking.firewall = {
    enable = true;
    checkReversePath = false;
  };
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time zone and locale.
  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-rime
      ];
    };
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };

  # User account.
  users.users."morstar" = {
    isNormalUser = true;
    description = "morstar";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "wireshark" ];
    shell = pkgs.fish;
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

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

  environment.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    GTK_ICON_THEME = "Papirus-Dark";
  };

  services.openssh.enable = true;

  system.stateVersion = "26.05";
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  sops = {
    age.keyFile = "/home/morstar/.config/sops/age/keys.txt";
    secrets = {
      mihomo_config = {
        sopsFile = ./secrets/mihomo-config.yaml;
        format = "binary";
      };
    };
  };

  # Niri compositor (Wayland).
  programs.niri.enable = true;

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/morstar";
  };

  security.polkit.enable = true;
  security.sudo.enable = false;
  security.sudo-rs.enable = true;

  # Udev rules — only morstar and root can access these USB HID devices.
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="04f3", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="04f3", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="36b0", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36b0", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="1209", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1209", MODE="0660", OWNER="morstar", GROUP="root", TAG+="uaccess"
  '';

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  hardware.enableRedistributableFirmware = true;

  programs.fish.enable = true;

  services.mihomo = {
    enable = true;
    configFile = config.sops.secrets."mihomo_config".path;
    tunMode = true;
    webui = pkgs.zashboard;
  };

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    usbmon.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
  };

  programs.obs-studio.enable = true;
}
