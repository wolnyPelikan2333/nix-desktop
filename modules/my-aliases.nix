{ config, pkgs, lib, ... }:

{
  options.my.aliases.enable = lib.mkEnableOption "Enable custom aliases";

  config = lib.mkIf config.my.aliases.enable {

    programs.zsh.shellAliases = lib.mkMerge [

      # ===========================
      # 1) Alias Pack - Git
      # ===========================
      {
        g    = "git";
        ga   = "git add .";
        gs   = "git status";
        gc   = "git commit -m";
        gca  = "git commit -am";
        gp   = "git push";
        gl   = "git pull";
        gd   = "git diff";
        glog = "git log --oneline --graph --decorate --all";

        sys-snapshots = "git -C /etc/nixos log --oneline --graph --decorate";
      }

      # ===========================
      # 2) Listing / Navigation
      # ===========================
      {
        l   = "ls -alh";
        la  = "eza -a";
        ll  = "eza -l";
        lla = "eza -la";
        ls  = "eza";
        lt  = "eza --tree";

        ".."  = "cd ..";
        "..." = "cd ../..";
      }

      # ===========================
      # 3) Editing / NVIM
      # ===========================
      {
        n    = "nvim";
        v    = "nvim";
        sen  = "sudo -E nvim";
        se   = "sudoedit";

        conf = "cd /etc/nixos && nvim flake.nix";
        sc   = "nvim /etc/nixos/docs/ściągi";

        vh    = "nvim /etc/nixos/docs/ściągi/shell/vim.md";
        panic = "nvim /etc/nixos/docs/ściągi/nix/panic-index.md";
      }

      # ===========================
      # 4) NixOS / NH workflow
      # ===========================
      {
        nt  = "nh os test /etc/nixos#nixos";
        nht = "nh os build /etc/nixos#nixos";
        nhs = "nh os switch /etc/nixos#nixos";
        nb  = "nh os boot /etc/nixos#nixos";

        nhu = "nh os switch --upgrade /etc/nixos#nixos";
        nhg = "nh os generations";

        nhd     = "nh os diff /etc/nixos#nixos";
        nhgens = "nh os generations | nl -ba";
        watch-nix = "rg --files /etc/nixos | entr -c nix flake check /etc/nixos";
      }

      # ===========================
      # 5) Rollback / Snapshots
      # ===========================
      {
        nhr     = "nh os rollback /etc/nixos#nixos";
        nh-home = "home-manager rollback";

        nhsnap = ''
          git -C /etc/nixos add -A &&
          git -C /etc/nixos commit -m "snapshot $(date +%F_%H-%M)" &&
          git -C /etc/nixos push &&
          echo "📦 Snapshot zapisany"
        '';

        nhundo = "git -C /etc/nixos reset --hard HEAD~1";
      }

      # ===========================
      # 6) Clean & Maintenance
      # ===========================
      {
        clean         = "sudo nix-collect-garbage -d";
        clean-big     = "sudo nix-collect-garbage -d && sudo nix store optimise";
        clean-system  = "sudo nix-collect-garbage -d && sudo nix store optimise";
        clean-weekly  = "sudo nix-env --delete-generations +7 && sudo nix-collect-garbage -d";

        sys-free = "df -h";
      }

      # ===========================
      # 7) Shell helpers
      # ===========================
      {
        run-help       = "man";
        which-command = "whence";
      }
    ];

    programs.zsh.initContent = ''
      nh-menu() {
        printf "\n===== 🧊 NixOS Snapshot Menu =====\n
        1) 📦 Snapshot (git commit + push)
        2) ↩️ Rollback system
        3) 🏠 Rollback Home Manager
        4) 🔍 Diff zmian konfiguracji
        5) 📜 Lista generacji
        6) ⏪ Cofnij ostatni snapshot
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

      # ===========================
      # SESJE — start / stop
      # ===========================

      sesja-start() {
        echo "=== SESJA START ==="
        echo
        echo "--- PLAN (NEXT.md) ---"
        if [ -f /etc/nixos/SESJE/NEXT.md ]; then
          sed -n '1,120p' /etc/nixos/SESJE/NEXT.md
        else
          echo "Brak /etc/nixos/SESJE/NEXT.md"
        fi
        echo
        echo "--- GIT STATUS (/etc/nixos) ---"
        cd /etc/nixos || return
        git status -sb
    }

              sesja-stop() {
        BASE="/etc/nixos/SESJE"
        TS="$(date '+%Y-%m-%d_%H-%M')"

        echo "Zamykanie sesji. Wybierz typ:"
        echo "1) zakonczona"
        echo "2) awaria"
        read -r CHOICE

        case "$CHOICE" in
          1) DIR="$BASE/zakonczone" ;;
          2) DIR="$BASE/awaria" ;;
          *) echo "Przerwano"; return ;;
        esac

        mkdir -p "$DIR"
        FILE="$DIR/$TS.md"

        printf "%s\n" \
"# SESJA — $TS" \
"" \
"## Stan wejściowy" \
"" \
"## Co zostało zrobione" \
"" \
"## Decyzje / ustalenia" \
"" \
"## Stan wyjściowy" \
> "$FILE"

        nvim "$FILE"
      }

    '';
  };
}

