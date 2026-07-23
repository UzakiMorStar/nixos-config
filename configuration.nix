{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/system/boot.nix
    ./modules/system/network.nix
    ./modules/system/locale.nix
    ./modules/system/nvidia.nix
    ./modules/system/desktop.nix
    ./modules/system/security.nix
    ./modules/system/user.nix
    ./modules/system/nix.nix
    ./modules/system/services.nix
  ];
}
