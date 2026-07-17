{ config, ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAtct7KhFGEfKWFH8Sup3g1bW6VZv7iz2EPrhRW3ZMT8";
      signByDefault = true;
    };
    settings = {
      gpg.format = "ssh";
    };
  };
}
