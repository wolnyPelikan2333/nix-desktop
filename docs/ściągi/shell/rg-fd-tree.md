# rg / fd / tree — szybka ściąga

Krótka, praktyczna ściąga do codziennej pracy w terminalu.
Skupiona na realnych przypadkach (NixOS, repo, configi).

---

## Do czego co jest

- **rg (ripgrep)** – szukanie *treści w plikach* (szybkie, domyślnie respektuje `.gitignore`)
- **fd** – szukanie *plików i katalogów* (zamiennik `find`)
- **tree** – szybki *podgląd struktury katalogów*

---

## rg — ripgrep

### Podstawy
```bash
rg nixos

Szukanie w konkretnym katalogu
rg flake /etc/nixos

Ignorowanie wielkości liter
rg -i wezterm

Tylko konkretne rozszerzenia
rg home-manager -g '*.nix'

Wykluczenie katalogu
rg nixos --glob '!.git'

Pokazanie numerów linii (często domyślne)
rg -n systemd

Szukanie w całym repo (bez binarek)
rg boot.loader

fd — find, ale normalne
Znajdź plik po nazwie
fd configuration.nix

Tylko katalogi
fd -t d nix

Tylko pliki
fd -t f wezterm

Szukanie po rozszerzeniu
fd -e nix

Szukanie w konkretnym katalogu
fd flake /etc/nixos

Wykluczenie katalogu
fd nix --exclude .git

tree — struktura katalogów
Podstawowy widok
tree

Ograniczenie głębokości
tree -L 2

Tylko katalogi
tree -d

Tylko pliki .nix
tree -P '*.nix'

Z ignorowaniem .git
tree -I .git

Najczęstsze combo (najbardziej użyteczne)
Szukaj tekstu tylko w plikach znalezionych przez fd
rg home-manager $(fd -e nix /etc/nixos)

Znajdź pliki i od razu je podejrzyj
fd wezterm /etc/nixos | xargs bat

Szybkie rozeznanie w strukturze modułów
tree /etc/nixos/modules -L 2

Tipy praktyczne

rg jest domyślnym grepem → nie używaj grep bez potrzeby

fd respektuje .gitignore → mniej śmieci

tree tylko do orientacji → do pracy lepsze fd + rg

Jeśli coś „nie znajduje” → sprawdź, czy nie jest ignorowane

Minimalny workflow (NixOS)
fd flake /etc/nixos
rg nixosConfigurations /etc/nixos
tree /etc/nixos -L 2

## Typowe kombinacje
rg foo $(fd . -e nix)
fd nix /etc/nixos -x rg enable

rg "enable =" /etc/nixos
fd . /etc/nixos -e nix -x rg wayland



