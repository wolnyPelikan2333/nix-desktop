# nix warnings — jak znaleźć źródło (krok po kroku)

Ta ściąga odpowiada na pytanie:
**widzę warning → co dokładnie zrobić, żeby znaleźć jego źródło**.

---

## ❓ Widzę `warning:` podczas build / switch — od czego zacząć?

### Zrób:
```bash
nix flake check /etc/nixos
Dlaczego:

- warningi często pojawiają się już na etapie evaluacji

- tu jest najkrótszy i najczystszy output

- Jeśli warning pojawi się tutaj → nie idź dalej, tylko go namierz

❓ Warning jest, ale NIE WIEM z jakiego pliku
Zrób:
nix flake check /etc/nixos --show-trace

Szukaj w output:

 warning:

- defined in

- while evaluating

To najczęściej pokaże dokładny plik .nix

❓ Warning pojawia się dopiero przy switch

Zrób „suchy bieg”:
sudo nixos-rebuild build --flake /etc/nixos#desktop

Dlaczego:

- build pokazuje warningi

- nie aktywuje systemu

- output jest czytelniejszy niż przy switch

❓ Warning mówi o opcji „deprecated / renamed”

Przykład:

warning: The option `X` has been renamed to `Y`

Co zrobić:

- Skopiuj STARĄ nazwę opcji

- Wyszukaj ją w konfiguracji:

rg "X" /etc/nixos


- Zmień na nową nazwę

- Zapisz

- Wróć do:

nix flake check /etc/nixos

❓ Warning pochodzi z /nix/store/...

To znaczy:

- warning nie jest bezpośrednio w Twoim pliku, ale pochodzi z modułu, który używasz

- Zrób:
rg "<nazwa-opcji-z-warninga>" /etc/nixos


Jeśli:

- znajdziesz → poprawiasz u siebie

- nie znajdziesz → ignorujesz (na razie)

❓ Chcę zobaczyć TYLKO warningi (bez reszty szumu)
Zrób:
nix flake check /etc/nixos 2>&1 | rg warning


Albo przy build:

sudo nixos-rebuild build --flake /etc/nixos#desktop 2>&1 | rg warning

🧭 Najprostsza mapa decyzyjna
widzę warning
↓
flake check
↓
--show-trace
↓
build (jeśli trzeba)
↓
rg w /etc/nixos

🧠 Jedno zdanie do zapamiętania
warning ≠ panika
warning = informacja, skąd i co poprawić
