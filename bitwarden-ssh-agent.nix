{ config, lib, ... }:

{
  home.activation = {
    linkBitwardenSsh = config.lib.dag.entryAfter ["writeBoundary"] ''
      USER_UID=$(id -u)
      TARGET_DIR="/run/user/$USER_UID/gcr"
      TARGET_SOCK="$TARGET_DIR/ssh"
      
      mkdir -p "$TARGET_DIR"
      
      if [ -e "$TARGET_SOCK" ] || [ -L "$TARGET_SOCK" ]; then
        rm -f "$TARGET_SOCK"
      fi
      
      ln -s "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock" "$TARGET_SOCK"
    '';
  };
}
