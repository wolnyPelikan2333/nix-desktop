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

      # zoxide
      z  = "zoxide query";
      zi = "zoxide interactive";

      ########################################
      ## 3) NH WORKFLOW — FULL POWER
      ########################################

      # --- Podstawy ---
      nht   = "nh os test /etc/nixos#desktop";
      nhs   = "nh os switch /etc/nixos#desktop";
      nhb   = "nh os boot /etc/nixos#desktop";
      nhg   = "nh os generations";
      nhd = ''
	nix store diff-closures /run/current-system \
	$(nix build /etc/nixos#desktop --no-link --print-out-paths)
'';
      # --- Build bez switch ---
      nhbuild = "nh os build /etc/nixos#desktop --show-trace";

      # --- Debug ---
      nhcheck   = "nh os test /etc/nixos#desktop --show-trace";
      nhrebuild = "sudo nixos-rebuild switch --flake /etc/nixos#desktop --show-trace";

      # --- Snapshoty / Git ---
      nhsnap = ''
        git -C /etc/nixos add -A &&
        git -C /etc/nixos commit -m "snapshot $(date +%F_%H-%M)" &&
        git -C /etc/nixos push &&
        echo "📦 Snapshot zapisany"
      '';

      nhundo  = "git -C /etc/nixos reset --hard HEAD~1";
      nhstash = "git -C /etc/nixos stash -u";
      nhapply = "git -C /etc/nixos stash apply";

      # --- Synchronizacja ---
      nhsync = ''
        git -C /etc/nixos pull &&
        nh os test /etc/nixos#desktop &&
        nh os switch /etc/nixos#desktop
      '';

      nhr = "nh os switch /etc/nixos#desktop && systemctl --user daemon-reload";

      # --- Build + snapshot + push ---
      nhpr = let
        msg = "auto: switch + snapshot $(date +%F_%H-%M)";
      in ''
        nh os switch /etc/nixos#desktop &&
        git -C /etc/nixos add -A &&
        git -C /etc/nixos commit -m "${msg}" &&
        git -C /etc/nixos push &&
        echo "🚀 nhpr: switch + snapshot + push — done!"
      '';

      # --- Rollback ---
      nhrollback = ''
        sudo nixos-rebuild switch --rollback &&
        git -C /etc/nixos reset --hard HEAD~1 &&
        echo "↩ System i repo cofnięte o jedną generację"
      '';

      ##############################
      ## 4) Git branches
      ##############################
      nhbranch = ''
        git -C /etc/nixos checkout -b fix-$(date +%F_%H-%M) &&
        echo "🌿 Nowy branch utworzony!"
      '';

      ##############################
      ## 5) Maintenance
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

