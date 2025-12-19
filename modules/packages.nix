{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
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
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    spotify

     # --- dodatki ---
    binutils   # <─ **nowe**
    ripgrep    # rg
    fd
    tree
    jq
  ];
}

