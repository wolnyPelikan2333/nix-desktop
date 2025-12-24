# rg / fd / tree — szybkie decyzje

Krótka ściąga do codziennej pracy w repo i configach (NixOS).  
Zasada: **wiem, co chcę zrobić → biorę gotową komendę**.

---

## 🧭 Szybka decyzja (najpierw to przeczytaj)
- **Szukam TEKSTU w plikach** → `rg`
- **Szukam PLIKÓW lub KATALOGÓW** → `fd`
- **Chcę zobaczyć STRUKTURĘ katalogów** → `tree`

---

## 🔍 rg — szukanie tekstu w plikach

### Szukanie tekstu w całym repo
```bash
rg nixos

Szukanie w konkretnym katalogu
rg flake /etc/nixos

Ignorowanie wielkości liter
rg -i wezterm

Tylko pliki o danym rozszerzeniu
rg home-manager -g '*.nix'

Z numerami linii
rg -n systemd

Z wykluczeniem katalogu
rg nixos --glob '!.git'

📁 fd — szukanie plików i katalogów
Plik po nazwie
fd configuration.nix

Tylko katalogi
fd -t d nix

Tylko pliki
fd -t f wezterm

Po rozszerzeniu
fd -e nix

W konkretnym katalogu
fd flake /etc/nixos

Z wykluczeniem katalogu
fd nix --exclude .git

🌳 tree — orientacja w strukturze katalogów
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

🔗 Najczęstsze kombinacje narzędzi
Szukaj tekstu tylko w plikach .nix
rg home-manager $(fd -e nix /etc/nixos)

Znajdź pliki i od razu je podejrzyj
fd wezterm /etc/nixos | xargs bat

Szybkie rozeznanie w modułach
tree /etc/nixos/modules -L 2

⚙️ Minimalny workflow (NixOS)
fd flake /etc/nixos
rg nixosConfigurations /etc/nixos
tree /etc/nixos -L 2

🧠 Zasady praktyczne (czytaj, gdy coś „nie działa”)

rg = domyślny grep

fd respektuje .gitignore → mniej śmieci

tree używaj tylko do orientacji

jeśli coś „nie znajduje” → sprawdź ignorowane pliki



