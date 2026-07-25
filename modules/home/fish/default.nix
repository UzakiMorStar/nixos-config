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
      ls = "eza";
      ll = "eza -l --git";
      la = "eza -la --git";
      lt = "eza --tree --git";
      l = "eza -l --icons --git --git-repos --group-directories-first";
    };

    interactiveShellInit = ''
      source ${cfgDir}/greeting.fish
      source ${cfgDir}/theme.fish
      source ${cfgDir}/prompt.fish
    '';
  };
}
