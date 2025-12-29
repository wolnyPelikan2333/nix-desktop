{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "viins";
    
    sessionVariables = {
      MPC_HOST = "127.0.0.1";
      MPC_PORT = "6600";
    };
    
    
    

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
           
        alias w='w3m' 
        alias nixman='w3m https://nixos.org/manual/nixos/stable/'
        alias nixerr='less /etc/nixos/docs/ściągi/nix/nix-build-errors.md'
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
      # YOUTUBE → AUDIO (mp3) → mpd (gregorian modes)
      # ----------------------------------------------------------
      ''
        _yta_core() {
          local target="$1"
          local url="$2"

          if [ -z "$target" ] || [ -z "$url" ]; then
            echo "❌ Użycie: yta-<tryb> <youtube-url>"
            return 1
          fi

          yt-dlp -x --audio-format mp3 \
            -o "$HOME/Music/music/gregorian/$target/%(title)s.%(ext)s" \
            "$url" || return 1

          if command -v mpc >/dev/null; then
            mpc update >/dev/null
          fi

          echo "🎶 Dodano do gregorian/$target"
        }

        yta-praca() {
          _yta_core "praca" "$1"
        }

        yta-modlitwa() {
          _yta_core "modlitwa" "$1"
        }

        yta-noc() {
          _yta_core "noc" "$1"
        }

        yta-wiara() {
          _yta_core "melodia-wiary" "$1"
        }
      ''
                # ----------------------------------------------------------
      # MPD — szybkie tryby (play folder)
      # ----------------------------------------------------------
      ''
        alias music-praca='mpc clear && mpc add "music/gregorian/praca" && mpc play'
        alias music-modlitwa='mpc clear && mpc add "music/gregorian/modlitwa" && mpc play'
        alias music-noc='mpc clear && mpc add "music/gregorian/noc" && mpc play'
        alias music-wiara='mpc clear && mpc add "music/gregorian/melodia-wiary" && mpc play'
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
          echo "🧠 System sesji: NOWY"
          echo "📄 Stan pracy: /etc/nixos/SESJE/AKTYWNA.md"
          echo
          read -k 1 "?↵ ENTER → przejście do AKTYWNA.md"
          echo
          echo

          echo "📦 Stan repo (/etc/nixos):"
          git -C /etc/nixos status
          echo

          nvim /etc/nixos/SESJE/AKTYWNA.md
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

        nss() {
          /etc/nixos/scripts/nss-safe "$@"
        }

        sys-status() {
          echo "===== SYSTEM STATUS ====="
          echo
          echo "📊 Uptime:"; uptime | sed 's/^/  /'; echo
          echo "💾 Disk /:"; df -h / | sed '1d;s/^/  /'; echo
          echo "🔐 Repo:"; if [ -z "$(git -C /etc/nixos status --porcelain)" ]; then echo "  CLEAN ✔"; else echo "  DIRTY ✖"; fi; echo
        }

         nixe() {
          nixos-rebuild build --flake /etc/nixos#nixos 2>&1 | tee /tmp/nix-error.log
          echo
          echo "📄 Ściąga: jak czytać błędy nix build"
          echo "----------------------------------"
          sed -n '1,80p' /etc/nixos/docs/ściągi/nix/nix-build-errors.md
        }

      ''

    ];
  };
}

