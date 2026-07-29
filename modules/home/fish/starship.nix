{ ... }:
{
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
        read_only = "";
      };

      cmd_duration = {
        min_time = 2000;
        format = "took [$duration]($style) ";
      };
    };
  };
}
