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
  };
};
 
  
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
   home-manager
   zellij
   kitty
   JetBrains-mono
  ];
  

   
   
  
  


  home.stateVersion = "25.05";
}
