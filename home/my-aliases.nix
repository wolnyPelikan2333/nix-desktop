{ config, pkgs, lib, ... }:

{
  options.my.aliases.enable = lib.mkEnableOption "Enable custom aliases";

  config = lib.mkIf config.my.aliases.enable {

     programs.zsh.shellAliases = {

      ##############################
      ## 0) System check
      ##############################
      nixcheck = "(cd /etc/nixos && nixos-rebuild build --flake .#desktop --show-trace)";

      ##############################
      ## 1) Git
      ##############################
      g   = "git";
      ga  = "git add .";
      gc  = "git commit -m";
      gca = "git commit -am";
      gp  = "git push";
      gl  = "git pull";
      gd  = "git diff";
      glog = "git log --oneline --graph --decorate --all";

      ##############################
      ## 2) Nav / Editing
      ##############################
      ".."  = "cd ..";
      "..." = "cd ../..";
      n     = "nvim";
      v     = "nvim";
      conf  = "cd /etc/nixos && nvim flake.nix";

      ##############################
      ## 3) NH workflow (proste skróty)
      ##############################
      nht = "nh os test /etc/nixos#desktop";
      nhs = "nh os switch /etc/nixos#desktop";
      nhb = "nh os boot /etc/nixos#desktop";
      nhg = "nh os generations";

      ##############################
      ## 5) Snapshot systemu
      ##############################
      nhsnap = ''
        git -C /etc/nixos add -A &&
        git -C /etc/nixos commit -m "snapshot $(date +%F_%H-%M)" &&
        git -C /etc/nixos push &&
        echo "📦 Snapshot zapisany"
      '';

      nhundo = "git -C /etc/nixos reset --hard HEAD~1";

      ##############################
      ## 7) Clean / Maintenance
      ##############################
      clean     = "sudo nix-collect-garbage -d";
      clean-big = "sudo nix-collect-garbage -d && sudo nix store optimise";
      sys-free  = "df -h";

      g3 = "nix-env --delete-generations +3 && sudo nix-collect-garbage -d";
      g5 = "nix-env --delete-generations +5 && sudo nix-collect-garbage -d";
      nh-clean = "nh clean all && sudo nix-env --delete-generations +5 && sudo nix-collect-garbage -d";
    };
  };
}

