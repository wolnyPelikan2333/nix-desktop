{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "viins";

    # ==========================================================
    # HISTORIA — STABILNA, BEZ KORUPCJI
    # ==========================================================
    history = {
      path = "$HOME/.config/zsh/.zsh_history";
      size = 50000;
      save = 50000;
      share = true;
      ignoreDups = true;
      extended = true;
    };

    # ==========================================================
    # INIT CONTENT — SCALANY (mkMerge)
    # ==========================================================
    initContent = lib.mkMerge [

      # ----------------------------------------------------------
      # PODSTAWY + PROMPT
      # ----------------------------------------------------------
      ''
        autoload -Uz colors
        colors

        PROMPT=$'\n%{\e[38;5;220m%}%~%{\e[0m%}\n%{\e[38;5;81m%}❯%{\e[0m%} '

        setopt APPEND_HISTORY
        setopt INC_APPEND_HISTORY
        setopt HIST_REDUCE_BLANKS
        setopt HIST_SAVE_NO_DUPS
      ''

      # ----------------------------------------------------------
      # UNALIASY (czyścimy stare konflikty)
      # ----------------------------------------------------------
      ''
        unalias ns 2>/dev/null
        unalias nss 2>/dev/null
        unalias sys-status 2>/dev/null
        unalias nh-menu 2>/dev/null
        unalias g3 2>/dev/null
        unalias g5 2>/dev/null
      ''

      # ----------------------------------------------------------
      # DOCS — przegląd ściąg
      # ----------------------------------------------------------
      ''
        docs() {
          DOCS_DIR="/etc/nixos/docs/ściągi"

          if ! command -v fzf >/dev/null; then
            echo "❌ fzf nie jest zainstalowany"
            return 1
          fi

          FILE=$(find "$DOCS_DIR" -type f -name "*.md" | sort | fzf --prompt="📚 docs > ")
          [ -z "$FILE" ] && return 0
          less "$FILE"
        }
      ''

      # ----------------------------------------------------------
      # SESJA — START / STOP
      # ----------------------------------------------------------
      ''
        sesja-start() {
          echo "$(date '+%F %H:%M')" > /tmp/sesja.start
          echo "🟢 Start: $(cat /tmp/sesja.start)"

          echo "===== 🧭 START SESJI ====="
          echo
          echo "📄 Ostatnia sesja (/etc/nixos/docs/SESJA.md):"
          echo "-------------------------------------------"

          if [ -f /etc/nixos/docs/SESJA.md ]; then
            sed -n '/--- END SESSION ---/,$p' /etc/nixos/docs/SESJA.md
          else
            echo "❌ Brak pliku SESJA.md"
          fi

          echo
          echo "📦 Stan repo (/etc/nixos):"
          git -C /etc/nixos status
          echo
        }

        sesja-stop() {
          if [ ! -f /tmp/sesja.start ]; then
            echo "❌ Brak sesji start (sesja-start)"
            return 1
          fi

          START="$(cat /tmp/sesja.start)"
          END="$(date '+%F %H:%M')"
          DAY="$(date '+%F')"
          SESJA_FILE="/etc/nixos/docs/SESJA.md"

          {
            echo
            echo "## 📅 $DAY"
            echo
            echo "### ⏱ Czas"
            echo "start: $START"
            echo "koniec: $END"
            echo
            echo "### 🔧 Zmiany techniczne"
            git -C /etc/nixos status --porcelain | while read -r _ f; do echo "- $f"; done
            echo
            echo "### 🎯 Cel sesji"
            echo "- "
            echo
            echo "### ✅ Zrobione"
            echo "- "
            echo
            echo "### 🧠 Wnioski"
            echo "- "
            echo
            echo "### 📌 Następny krok"
            echo "- "
          } >> "$SESJA_FILE"

          rm -f /tmp/sesja.start
          nvim "$SESJA_FILE"
        }
      ''

      # ----------------------------------------------------------
      # SYSTEM — SNAPSHOT / STATUS
      # ----------------------------------------------------------
      ''
        NOTEFILE="$HOME/.config/nixos-notes.log"

        sys-note() {
          mkdir -p "$HOME/.config"
          echo "$(date '+%F %H:%M') — $*" >> "$NOTEFILE"
          echo "📝 zapisano"
        }

        sys-save-os() {
          local msg="$*"
          [ -z "$msg" ] && msg="update"

          echo "⚙ build + switch..."
          sudo nixos-rebuild switch --flake /etc/nixos#nixos || { echo "❌ FAIL"; return; }

          git -C /etc/nixos add -A
          git -C /etc/nixos commit -m "snapshot: $(date +%F_%H-%M) — $msg" \
            && git -C /etc/nixos push

          echo "🚀 snapshot zapisany → $msg"
        }

        ns()  { sys-note "$*"; sys-save-os "$*"; }
        nss() { sys-save-os "$*"; }

        sys-status() {
          echo "===== SYSTEM STATUS ====="
          echo
          echo "📊 Uptime:"; uptime | sed 's/^/  /'; echo
          echo "💾 Disk /:"; df -h / | sed '1d;s/^/  /'; echo
          echo "🔐 Repo:"; if [ -z "$(git -C /etc/nixos status --porcelain)" ]; then echo "  CLEAN ✔"; else echo "  DIRTY ✖"; fi; echo
        }
      ''

    ];
  };
}

