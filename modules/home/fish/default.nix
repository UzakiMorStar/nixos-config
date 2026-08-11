{ config, ... }:

let
  cfgDir = ./.;
  homeDir = config.home.homeDirectory;
in
{
  imports = [ ./starship.nix ];

  # Disable default SSH agent (Bitwarden handles it)
  services.ssh-agent.enable = false;

  programs.fish = {
    enable = true;

    shellInit = ''
      set -gx SSH_AUTH_SOCK "${homeDir}/.bitwarden-ssh-agent.sock"
    '';

    shellAliases = {
      ls = "eza --icons=always";
      ll = "eza -l --git --icons=always";
      la = "eza -la --git --icons=always";
      lt = "eza --tree --icons=always --git";
      l = "eza -l --icons=always --git --git-repos --group-directories-first";
      cat = "bat";
    };

    interactiveShellInit = ''
      source ${cfgDir}/greeting.fish
      source ${cfgDir}/theme.fish
      starship init fish | source
    '';
  };
}
