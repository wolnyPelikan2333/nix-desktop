rg / fd / tree — szybka ściąga (deczyjna)

Krótka ściąga do codziennej pracy w repo i configach (NixOS).
Zasada: wiem, co chcę zrobić → biorę gotową komendę.

❓ Chcę znaleźć TEKST w plikach
🔹 Szukanie tekstu w całym repo

Odpowiedź: użyj rg

rg nixos

🔹 Szukanie w konkretnym katalogu
rg flake /etc/nixos

🔹 Ignorowanie wielkości liter
rg -i wezterm

🔹 Tylko pliki o danym rozszerzeniu
rg home-manager -g '*.nix'

🔹 Z numerami linii
rg -n systemd

🔹 Z wykluczeniem katalogu
rg nixos --glob '!.git'

❓ Chcę znaleźć PLIKI lub KATALOGI
🔹 Plik po nazwie

Odpowiedź: użyj fd

fd configuration.nix

🔹 Tylko katalogi
fd -t d nix

🔹 Tylko pliki
fd -t f wezterm

🔹 Po rozszerzeniu
fd -e nix

🔹 W konkretnym katalogu
fd flake /etc/nixos

🔹 Z wykluczeniem katalogu
fd nix --exclude .git

❓ Chcę zobaczyć STRUKTURĘ katalogów
🔹 Podstawowy widok

Odpowiedź: użyj tree

tree

🔹 Ograniczenie głębokości
tree -L 2

🔹 Tylko katalogi
tree -d

🔹 Tylko pliki .nix
tree -P '*.nix'

🔹 Z ignorowaniem .git
tree -I .git

❓ Chcę połączyć narzędzia (najczęstsze przypadki)
🔹 Szukaj tekstu tylko w plikach .nix
rg home-manager $(fd -e nix /etc/nixos)

🔹 Znajdź pliki i od razu je podejrzyj
fd wezterm /etc/nixos | xargs bat

🔹 Szybkie rozeznanie w modułach
tree /etc/nixos/modules -L 2

❓ Minimalny workflow (NixOS)

fd flake /etc/nixos
rg nixosConfigurations /etc/nixos
tree /etc/nixos -L 2

🧠 Zasady praktyczne (czytaj, gdy coś „nie działa”)

rg = domyślny grep

fd respektuje .gitignore → mniej śmieci

tree tylko do orientacji

jeśli coś „nie znajduje” → sprawdź ignorowane pliki

❓ Typowe kombinacje

rg foo $(fd . -e nix)
fd nix /etc/nixos -x rg enable
rg "enable =" /etc/nixos
fd . /etc/nixos -e nix -x rg wayland


