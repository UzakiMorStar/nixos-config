# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
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
	"net.ipv6.conf.all.forwarding" =1;
  };
  networking.firewall = {
	enable = true;
	checkReversePath = false;
  };
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
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
	  addons = with pkgs;[
	    fcitx5-rime
    ];
  };
};

  services.xserver= {
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."morstar" = {
    isNormalUser = true;
    description = "morstar";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "wireshark" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  nix.extraOptions = ''
    access-tokens = github.com=${builtins.readFile /etc/nixos/github_token}
  '';

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	git
	alacritty
	xdg-utils
	wget
	curl
	cups-pk-helper
	fastfetch
	hyfetch
	android-tools
	gcc
	telegram-desktop
	unzip
  chromium
	file
	zip
	vulkan-tools
	steam-run
	xwayland-satellite
	adwaita-icon-theme
  hicolor-icon-theme
	papirus-icon-theme
	catppuccin-cursors.macchiatoDark
  kazumi
  heroic
	discord-ptb
	piliplus
	libreoffice-fresh
	bitwarden-desktop
  remmina
  inputs.sidra.packages.${pkgs.stdenv.hostPlatform.system}.default
  usbutils
  (pkgs.writeShellApplication {
      name = "kzzi-light";
      runtimeInputs = [ (pkgs.python3.withPackages (ps: [ ps.hidapi ])) ];
      text = builtins.readFile ./kzzi_light.sh;
  })
  ];

  nixpkgs.config.permittedInsecurePackages = [
        "electron-39.8.10"
  ];

  environment.sessionVariables = {
	XCURSOR_THEME = "Adwaita";
	GTK_ICON_THEME = "Papirus-Dark";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
  nix.settings.experimental-features=[ "nix-command" "flakes" ];
  programs.niri.enable = true;
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
  };
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };
  security.polkit.enable = true;
  security.sudo.enable = false;
  security.sudo-rs.enable = true;

  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="04f3", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="04f3", MODE="0666", TAG+="uaccess"
  '';

  hardware.graphics = {
	enable = true;
	enable32Bit = true;

	extraPackages = with pkgs;[
		vulkan-loader
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
	configFile = "/home/morstar/.config/mihomo/config.yaml";
	tunMode = true;
	webui = pkgs.zashboard;
  };
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable=true;
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
  programs.neovim = {
	enable = true;
	vimAlias = true;
	defaultEditor = true;
  };
  fonts.packages = with pkgs;[
	nerd-fonts.jetbrains-mono
  ];
}
