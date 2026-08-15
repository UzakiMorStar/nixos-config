{
  config,
  pkgs,
  ...
}: let
  sessionFile = "${config.xdg.dataHome}/aria2/aria2.session";
  runtimeConf = "${config.xdg.configHome}/aria2/aria2.runtime.conf";
  baseConf = config.xdg.configFile."aria2/aria2.conf".source;
in {
  programs.aria2 = {
    enable = true;
    settings = {
      dir = "${config.home.homeDirectory}/Downloads";
      enable-rpc = true;
      rpc-listen-all = false;
      rpc-listen-port = 6800;
      rpc-allow-origin-all = true;
      save-session = sessionFile;
      input-file = sessionFile;
    };
  };

  sops.secrets."aria2_rpc_secret" = {
    sopsFile = ../../secrets/aria2-rpc-secret.json;
    format = "binary";
  };

  systemd.user.services.aria2 = {
    Unit = {
      Description = "Aria2c daemon";
      Documentation = "man:aria2c(1)";
      After = ["network.target"];
      X-Restart-Triggers = ["${config.sops.secrets."aria2_rpc_secret".path}"];
    };

    Service = {
      ExecStartPre = pkgs.writeShellScript "aria2-pre-start" ''
        umask 077
        mkdir -p "${config.xdg.dataHome}/aria2"
        touch "${sessionFile}"
        {
          cat "${baseConf}"
          printf '\nrpc-secret=%s\n' "$(cat '${config.sops.secrets."aria2_rpc_secret".path}')"
        } > "${runtimeConf}"
      '';
      ExecStart = "${pkgs.aria2}/bin/aria2c --conf-path=${runtimeConf}";
      Restart = "on-failure";
    };

    Install.WantedBy = ["default.target"];
  };
}
