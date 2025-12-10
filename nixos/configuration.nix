{ config, pkgs, ... }:

{
  imports = [
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
  ## KDE + GRAFIKA
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
  ## AUDIO
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
  ## USER
  ###############################################

  users.users.michal = {
    isNormalUser = true;
    description = "michal";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ kdePackages.kate ];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "michal";

  ###############################################
  ## SYSTEM PACKAGES
  ###############################################

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command" "flakes"
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.okular vim wget google-chrome neovim yazi ranger steam zathura
    tree-sitter tree-sitter-grammars.tree-sitter-bash
    tree-sitter-grammars.tree-sitter-lua tree-sitter-grammars.tree-sitter-nix
    tree-sitter-grammars.tree-sitter-json tree-sitter-grammars.tree-sitter-markdown
    tree-sitter-grammars.tree-sitter-python firefox git starship fzf zoxide nh
    discord lutris wineWowPackages.full winetricks
  ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  programs.zsh.enable = true;

  ###############################################
  ## GC auto 10 generations
  ###############################################

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-generations +10";
  };

  nix.settings.auto-optimise-store = true;

  ###############################################
  ## NH helper
  ###############################################

  programs.nh.enable = true;
  programs.nh.clean = {
    enable = true;
    dates = "weekly";
  };

  ###############################################
  ## SYSTEM ALIASES
  ###############################################

  environment.shellAliases = {
    ns = "nh os switch /etc/nixos#desktop";
    nt = "nh os test /etc/nixos#desktop";
    nb = "nh os boot /etc/nixos#desktop";
    nh-clean = "nh clean all && sudo nix-env --delete-generations +5 && sudo nix-collect-garbage -d";

    g3 = "nix-env --delete-generations +3 && sudo nix-collect-garbage -d";
    g5 = "nix-env --delete-generations +5 && sudo nix-collect-garbage -d";
  };

  ###############################################
  ## WEEKLY system cleanup
  ###############################################

  systemd.services.nix-clean-generations = {
    description = "Weekly cleanup of old NixOS generations";
    serviceConfig.ExecStart = "${pkgs.nix}/bin/nix-env --delete-generations +10";
    unitConfig.ConditionACPower = true;
  };

  systemd.timers.nix-clean-generations = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnCalendar = "weekly";
  };

  ###############################################
  ## END
  ###############################################

  system.stateVersion = "25.05";
}

