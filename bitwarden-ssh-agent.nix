{ config, ... }:
{
  home.file.".config/fish/conf.d/bitwarden-ssh.fish".text = ''
    set -gx SSH_AUTH_SOCK "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock"
  '';

  services.ssh-agent.enable = false;
}
