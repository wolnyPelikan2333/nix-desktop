# rg / fd / tree — ściąga

## rg (szukanie w plikach)
```bash
rg wezterm
rg wezterm /etc/nixos
rg -n "flake" .
rg "wezterm" -g "*.nix"
rg "enable = true" -C 2

fd (szukanie plików)

fd wezterm
fd wezterm /etc/nixos
fd '\.nix$'
fd wezterm -t d
fd wezterm -x nvim

tree (struktura katalogów)

tree
tree -L 2
tree /etc/nixos
tree -L 3 -I "result|.git"

Mini-workflow

cd /etc/nixos
tree -L 2
rg wezterm
fd wezterm

