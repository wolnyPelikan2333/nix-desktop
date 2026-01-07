{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../modules/wezterm.nix
    ../modules/zsh.nix
    ../modules/my-aliases.nix

     ./zsh/core.nix
     ./zsh/vi-mode.nix
     ./zsh/vim-indicator.nix
     ./zsh/prompt.nix
  ];
  my.aliases.enable = true;

  home.username = "michal";
  home.homeDirectory = "/home/michal";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };



  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  programs.zoxide = {
  enable = true;
  enableZshIntegration = true;
};
   
  programs.alacritty = {
    enable = true;

    settings = {
      env = {
       TERM = "xterm-256color";
    };

    window = {
       decorations = "full";
       dynamic_padding = true;
    };

    font = {
      normal = {
        family = "JetBrains Mono";
        style = "Regular";
      };
      size = 12.0;
    };

    scrolling = {
      history = 10000;
    };

    cursor = {
      style = "Block";
      unfocused_hollow = true;
    };

    selection = {
      save_to_clipboard = true;
    };

         keyboard = {
         bindings = [
    # --- Clipboard ---
    { key = "C"; mods = "Alt"; action = "Copy"; }
    { key = "V"; mods = "Alt"; action = "Paste"; }

    # --- Window ---
    { key = "N"; mods = "Alt"; action = "CreateNewWindow"; }
    { key = "Q"; mods = "Alt"; action = "Quit"; }

    # --- Font size ---
    { key = "Equals"; mods = "Alt"; action = "IncreaseFontSize"; }
    { key = "Minus"; mods = "Alt"; action = "DecreaseFontSize"; }
    { key = "Key0"; mods = "Alt"; action = "ResetFontSize"; }

    # --- Neovim leader mappings (chars = "...") ---
    # Alt+P -> ,p
    { key = "P"; mods = "Alt"; chars = ",p"; }

    # (na później, jeśli będziesz chciał)
    # Alt+F -> ,f
     { key = "F"; mods = "Alt"; chars = ",f"; }

    # Alt+G -> ,g
     { key = "G"; mods = "Alt"; chars = ",g"; }
    
    # Alt+Y -> ,y
    {key = "Y"; mods = "Alt"; chars = ",y"; }
  ];
};
 };
};

   programs.tmux = {
  enable = true;

  extraConfig = ''
    # === RATUNKOWY RUCH PRZESTRZENNY ===
    # Ctrl + strzałki → zawsze panele tmuxa
    bind -n C-Left  select-pane -L
    bind -n C-Right select-pane -R
    bind -n C-Up    select-pane -U
    bind -n C-Down  select-pane -D

    # --- layout startowy: 3 panele ---
    # lewy: główny
    # prawy-góra: pomocniczy
    # prawy-dół: monitoring (btop)

    bind M \
      split-window -h \; \
      split-window -v -t 1 \; \
      select-pane -t 0 \; \
      send-keys -t 2 "btop" C-m
  '';
};

 
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
   home-manager
   zellij
   kitty
   jetbrains-mono
   tmux
  ];
  

   
   
  
  


  home.stateVersion = "25.05";
}
