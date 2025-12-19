{ config, pkgs, lib, ... }:

{
  options.my.aliases.enable = lib.mkEnableOption "Enable custom aliases";

  config = lib.mkIf config.my.aliases.enable {
    programs.zsh.shellAliases = lib.mkMerge [

      # ===========================
      # 1) Alias Pack - Git
      # ===========================
      {
        g   = "git";
        ga  = "git add .";
        gc  = "git commit -m";
        gca = "git commit -am";
        gp  = "git push";
        gl  = "git pull";
        gd  = "git diff";
        glog = "git log --oneline --graph --decorate --all";
      }

      # ===========================
      # 2) Nav / Editing
      # ===========================
      {
        ".."  = "cd ..";
        "..." = "cd ../..";
        n  = "nvim";
        v  = "nvim";
        conf = "cd /etc/nixos && nvim flake.nix";
	sc = "nvim /etc/nixos/docs/ściągi";
      }

      # ===========================
      # 3) NixOS + NH workflow
      # ===========================
      {
        # Twoje istniejące:
        # nht → test build
        # nhs → switch (system+home)

        nhu = "nh os switch --upgrade /etc/nixos#nixos";   # upgrade + switch
        nhb = "nh os boot /etc/nixos#nixos";               # przygotuj generację do GRUB
        nhg = "nh os generations";                           # generacje
      }

      # ===========================
      # 4) Snapshots, Rollback, SafeTools
      # ===========================
      {
        nhr = "nh os rollback /etc/nixos#desktop";           # rollback OS
        nh-home = "home-manager rollback";                   # rollback tylko home

        nhd = "nh os diff /etc/nixos#desktop";               # porównanie generacji
        nhgens = "nh os generations | nl -ba";               # generacje z numeracją

        nhsnap = ''git -C /etc/nixos add -A &&
                   git -C /etc/nixos commit -m "snapshot $(date +%F_%H-%M)" &&
                   git -C /etc/nixos push &&
                   echo "📦 Snapshot zapisany"'';             # snapshot + push

        nhundo = "git -C /etc/nixos reset --hard HEAD~1";    # cofnięcie commita snapshotu
      }

      # ===========================
      # 5) Clean & Maintenance
      # ===========================
            {
        clean      = "sudo nix-collect-garbage -d";
        clean-big  = "sudo nix-collect-garbage -d && sudo nix store optimise";
        sys-free   = "df -h";
      }
    ];

    programs.zsh.initExtra = ''
      nh-menu() {
        printf "\n===== 🧊 NixOS Snapshot Menu =====\n
	1) 📦 Snapshot (git commit + push)
	2) ↩️ Rollback system (nh os rollback)
	3) 🏠 Rollback Home Manager
	4) 🔍 Diff zmian konfiguracji
	5) 📜 Lista generacji
	6) ⏪ Cofnij ostatni snapshot (undo)
	0) ❌ Wyjście\n
	Wybierz opcje: "
		read -r choice

        case "$choice" in
          1) nhsnap ;;
          2) nhr ;;
          3) nh-home ;;
          4) nhd ;;
          5) nhgens ;;
          6) nhundo ;;
          0) echo "zamknięto menu" ;;
          *) echo "❗ Nieprawidłowa opcja" ;;
        esac
      }
    '';
  };
}

