{ config, pkgs, lib, ... }:

{
  options.my.aliases.enable = lib.mkEnableOption "Enable custom aliases";

  config = lib.mkIf config.my.aliases.enable {
    programs.zsh.shellAliases = {
      ll = "ls -lah";
      gs = "git status";
      ns = "sudo nixos-rebuild switch";
    };
  };
}

