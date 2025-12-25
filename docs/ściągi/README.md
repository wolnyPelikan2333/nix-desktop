# Ściągi

Ten katalog zawiera krótkie, praktyczne ściągi używane przy codziennej pracy
z NixOS, shellem i narzędziami.

## Zasady
- każda ściąga = **max 1 ekran**
- **konkretne komendy**, minimum teorii
- bez opisów „akademickich”
- to jest **pomoc pamięci**, nie dokumentacja projektu

## Struktura
- `shell/`   – narzędzia CLI (rg, fd, sed, awk…)
- `nix/`   – workflow NixOS (flake, rollback, GC)
- `git/`     – bezpieczna praca z repo
- `wezterm/` – skróty i sesje

## Workflow
1. coś robisz
2. zapominasz składni
3. zaglądasz tutaj
4. wracasz do pracy

### Nix
- [flake check / build / switch — którą komendę wybrać?](ściągi/nix/flake-check-build-switch.md)
- [nix warnings — jak znaleźć źródło](ściągi/nix/nix-warnings-jak-znalezc-zrodlo.md)

### Shell
- [Vim / Neovim — makra i rejestry](ściągi/shell/vim-makra-rejestry.md)
- [Vim / Neovim — absolutne podstawy](ściągi/shell/vim-podstawy.md)
- [Neovim — edycja wielu miejsc (bez multikursora)](./shell/nvim-multi-edit.md)
