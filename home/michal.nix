{ config, pkgs, ... }:

{
  home.username = "michal";
  home.homeDirectory = "/home/michal";

  imports = [
    ./packages.nix
    ./zsh.nix
    ./wezterm.nix
    ./nvim.nix
    ./my-aliases.nix

   # i3 – dokładnie JEDEN wariant (na razie wyłączony)
     # ./i3/keys-test
     ./i3-prod.nix
     # ./i3-test.nix
  ];

  home.stateVersion = "25.05";
}

