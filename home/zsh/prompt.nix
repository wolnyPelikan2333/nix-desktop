{ config, lib, ... }:

{
  programs.zsh.initExtra = ''
    # ===============================
    # ZSH PROMPT — vim mode indicator
    # integrates with existing PROMPT
    # ===============================

    setopt PROMPT_SUBST
    autoload -Uz colors && colors

    function _vim_mode_prompt() {
      case "$VIM_MODE" in
        NOR) print -n "%{$fg[red]%}[NOR]%{$reset_color%} " ;;
        INS) print -n "%{$fg[green]%}[INS]%{$reset_color%} " ;;
        VIS) print -n "%{$fg[yellow]%}[VIS]%{$reset_color%} " ;;
        *)   print -n "%{$fg[green]%}[INS]%{$reset_color%} " ;;
      esac
    }

    # prepend vim mode to existing prompt
    PROMPT='$(_vim_mode_prompt)'$PROMPT
  '';
}

