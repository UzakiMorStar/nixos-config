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

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -l --git --icons";
      la = "eza -la --git --icons";
      lt = "eza --tree --icons --git";
      l = "eza -l --icons --git --git-repos --group-directories-first";
      cat = "bat";
    };

    interactiveShellInit = ''
      source ${cfgDir}/greeting.fish
      source ${cfgDir}/theme.fish
      source ${cfgDir}/prompt.fish
    '';
  };
}
