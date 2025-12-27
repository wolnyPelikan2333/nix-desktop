{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- core ---
    neovim
    btop
    fastfetch
    wezterm
    copyq

    # --- CLI tools ---
    binutils
    ripgrep
    fd
    tree
    jq
    mpv
       ];
}

