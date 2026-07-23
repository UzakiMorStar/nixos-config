{ config, ... }:

let
  cfgDir = ./.;
  homeDir = config.home.homeDirectory;
in
{
  # Disable default SSH agent (Bitwarden handles it)
  services.ssh-agent.enable = false;

  programs.fish = {
    enable = true;

    shellInit = ''
      set -gx SSH_AUTH_SOCK "${homeDir}/.bitwarden-ssh-agent.sock"
    '';

    interactiveShellInit = ''
      source ${cfgDir}/greeting.fish
      source ${cfgDir}/theme.fish
      source ${cfgDir}/prompt.fish
    '';
  };
}
