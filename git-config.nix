{ config, ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBnjVbeqbfW+vIkvCKtn8h7QehFKaqvbyToxVsA5o92Z";
      signByDefault = true;
    };
    settings = {
      gpg.format = "ssh";
    };
  };
}
