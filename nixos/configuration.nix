{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  ###############################################
  ## GLOBALNE ZMIENNE ŚRODOWISKOWE
  ###############################################

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";
  };

  ###############################################
  ## POWŁOKI LOGIN (ważne dla Zsh + Starship)
  ###############################################
  environment.shells = [ pkgs.zsh ];


  ###############################################
  ## BOOTLOADER
  ###############################################

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "pl_PL.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  ###############################################
  ## GRAFIKA + KDE
  ###############################################

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  console.keyMap = "pl2";

  ###############################################
  ## DŹWIĘK
  ###############################################

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ###############################################
  ## UŻYTKOWNIK
  ###############################################

  users.users.michal = {
    isNormalUser = true;
    description = "michal";
    extraGroups = [ "networkmanager" "wheel" "vboxusers"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "michal";

  ###############################################
  ## PAKIETY SYSTEMOWE
  ###############################################

  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.okular
    vim
    wget
    google-chrome
    neovim
    yazi
    ranger
    steam
    zathura
    tree-sitter
    tree-sitter-grammars.tree-sitter-bash
    tree-sitter-grammars.tree-sitter-lua
    tree-sitter-grammars.tree-sitter-nix
    tree-sitter-grammars.tree-sitter-json
    tree-sitter-grammars.tree-sitter-markdown
    tree-sitter-grammars.tree-sitter-python
    firefox
    git
    starship
    fzf
    zoxide
    nh
    discord
    lutris
    wineWowPackages.full
    winetricks


  ];
  virtualisation.virtualbox.host.enable = true;


  ###############################################
  ## ZSH + STARSHIP + FZF + ZOXIDE
  ###############################################

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    promptInit = ''
      eval "$(starship init zsh)"
    '';

    interactiveShellInit = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
      export SUDO_EDITOR="nvim"

      alias se="sudoedit"
      
      # Historia z fzf – Ctrl+R (reverse search) + Ctrl+T (files)
      export FZF_DEFAULT_COMMAND='fd --type f'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

      # historia fzf pod Ctrl+R
      if [[ -n $commands[fzf] ]]; then
        bindkey '^R' fzf-history-widget
      fi

      # fzf
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh

      # zoxide
      eval "$(zoxide init zsh)"
    '';
  };

  ###############################################
  ## DYSK 1.8 TB – STAŁE MONTOWANIE + UPRAWNIENIA
  ###############################################

  fileSystems."/data" = {
    device = "UUID=8fbe63e6-58f2-4609-905a-5f2365318224";
    fsType = "ext4";
  };

  systemd.tmpfiles.rules = [
    "d /data 0700 michal users -"
  ];

  ###############################################
  ## NIX HELPER (nh)
  ###############################################

  programs.nh = {
    enable = true;

    clean = {
      enable = true;
      dates = "weekly";
    };
  };


  ##############################################
  ## Alias'y systemowe
  ###############################################

  environment.shellAliases = {
    # nh – operacje na NixOS
    ns = "nh os switch /etc/nixos#desktop";
    nt = "nh os test /etc/nixos#desktop";
    nb = "nh os boot /etc/nixos#desktop"; 
    nh-clean = "nh clean all && sudo nix-env --delete-generations +5 && sudo nix-collect-garbage -d"; # pełne czyszczenie: nh → usuwanie generacji → czyszczenie store

    # zostaw tylko 3 generacje systemu
    g3 = "nix-env --delete-generations +3 && sudo nix-collect-garbage -d";
    # zostaw tylko 5 generacji systemu
    g5 = "nix-env --delete-generations +5 && sudo nix-collect-garbage -d";
  };
  ###############################################
  ## KONIEC
  ###############################################

  system.stateVersion = "25.05";
}

