{ config, ... }:

let
  cfgDir = ./.;
  homeDir = config.home.homeDirectory;
in
{
  # Disable default SSH agent (Bitwarden handles it)
  services.ssh-agent.enable = false;

  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_status$nix_shell$cmd_duration$character";
      add_newline = false;
      scan_timeout = 10;
      command_timeout = 500;

      aws.disabled = true;
      python.disabled = true;
      docker_context.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = true;
      nodejs.disabled = true;
      ruby.disabled = true;
      terraform.disabled = true;
      zig.disabled = true;
      java.disabled = true;
      lua.disabled = true;
      ocaml.disabled = true;
      php.disabled = true;
      purescript.disabled = true;
      vlang.disabled = true;
      scala.disabled = true;
      erlang.disabled = true;
      guix_shell.disabled = true;
      hg_branch.disabled = true;
      julia.disabled = true;
      spack.disabled = true;
      swift.disabled = true;
      vagrant.disabled = true;
      fossil_branch.disabled = true;

      nix_shell.format = "via [❄️ $name]($style) ";

      directory = {
        style = "blue";
        read_only = "";
      };

      cmd_duration = {
                        min_time = 2000;
                        format = "took [$duration]($style) ";
                      };
    };
  };

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
      starship init fish | source
    '';
  };
}
