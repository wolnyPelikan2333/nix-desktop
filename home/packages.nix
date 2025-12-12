{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
    fastfetch
    wezterm
    pkgs.nerd-fonts.jetbrains-mono
    copyq
    lutris
    wineWowPackages.full
    winetricks
    protontricks
    mangohud
    gamemode
    steam-run
    gimp-with-plugins
    gmic
    imagemagick
    libwebp
    libheif
    libraw
    openexr
    jasper
    libavif
    inkscape
    krita

     # --- dodatki ---
    binutils   # <─ **nowe**
  ];
}

