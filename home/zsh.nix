{ config, pkgs, lib, ... }:

{
  # Ten plik jest teraz przygotowany jako modulka dla Home-Managera.
  # Nie powinien być ładowany jako programs.zsh w NixOS.
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";

    # PROMPT – poprawna wersja dla Home-Manager
    initExtraBeforeCompInit = ''
      autoload -Uz colors && colors
      PROMPT="%{$fg[yellow]%}%~%{$reset_color%} %{$fg[cyan]%}>%{$reset_color%} "
    '';

    # funkcje i helpery użytkownika
    initExtra = ''
      ###########################################
      # Funkcja ns — workflow Git + NH
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
      # Funkcja nh_menu
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
    '';
  };
}

