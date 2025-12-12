{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;

    # NOWY format opcji (poprawny)
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    # gdzie trzymać pliki .zshrc
    dotDir = "${config.xdg.configHome}/zsh";

    ############################################
    ## PROMPT + EXTRA INIT
    ############################################
    initExtraBeforeCompInit = ''
      autoload -Uz colors && colors
      PROMPT="%{$fg[yellow]%}%~%{$reset_color%} %{$fg[cyan]%}>%{$reset_color%} "
    '';

    initExtra = ''
      ###########################################
      # Funkcja ns — test + commit + push + switch
      ###########################################
      ns() {
        MSG="$@"
        if [ -z "$MSG" ]; then
          echo "Użycie: ns \"commit message\""
          return 1
        fi

        echo "🔧 Testowanie konfiguracji..."
        if ! nh os test /etc/nixos#desktop; then
          echo "❌ Test NIE przeszedł — commit zatrzymany"
          return 1
        fi

        echo "📌 Commit: $MSG"
        git -C /etc/nixos add -A
        git -C /etc/nixos commit -m "$MSG" || return 1
        git -C /etc/nixos push || return 1

        echo "🚀 Switch..."
        nh os switch /etc/nixos#desktop
      }

      ###########################################
      # Funkcja sys_status
      ###########################################
      sys_status() {
        echo "===== SYSTEM STATUS ====="
        uptime
        echo
        df -h /
        echo
        git -C /etc/nixos status --short || true
      }

      ###########################################
      # Menu NH
      ###########################################
      nh_menu() {
        printf "\n===== 🧊 NixOS Menu =====\n
1) 📦 Snapshot
2) ↩️ Rollback system
3) 🔍 Diff zmian
4) 📜 Generacje
5) ⏪ Cofnij snapshot
0) ❌ Wyjście\n
Wybierz opcję: "

        read -r choice
        case "$choice" in
          1) nhsnap ;;
          2) sudo nixos-rebuild switch --rollback ;;
          3) git -C /etc/nixos diff ;;
          4) nh os generations ;;
          5) nhundo ;;
          0) echo "zamknięto menu" ;;
          *) echo "Nieprawidłowa opcja" ;;
        esac
      }

      ###########################################
# Funkcja nhlog — diagnostyka systemu
###########################################
nhlog() {
  mode="$1"

  echo "===== 🔍 NixOS DIAGNOSTICS ====="
  echo
  echo "► System: $(uname -a)"
  echo "► Host: $(hostname)"
  echo "► Kernel: $(uname -r)"
  echo

  echo "===== 📦 Flake path ====="
  echo "/etc/nixos"
  echo

  echo "===== 📜 Generacje ====="
  nh os generations
  echo

  if [[ "$mode" == "--full" ]]; then
    echo "===== 🧊 Flake metadata ====="
    nix flake metadata /etc/nixos
    echo

    echo "===== 🧮 Full system evaluation ====="
    nh os test /etc/nixos#desktop --show-trace
    echo

    echo "===== 🗂 Repo status ====="
    git -C /etc/nixos status -s
    echo
  fi

  echo "===== ✔ nhlog done ====="
}

    '';
  };
}

