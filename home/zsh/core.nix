{ config, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    initContent = ''
      # sen — sudo nvim helper
      sen() {
        if [ "$#" -eq 0 ]; then
          sudo -E nvim .
        else
          sudo -E nvim "$@"
        fi
      }

        nbuild() {
          sudo nixos-rebuild build --flake /etc/nixos
    '';
  };
}

