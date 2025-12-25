# grep — ściąga decyzyjna

> grep tylko **czyta** pliki (bezpieczne).  
> Klasyczne narzędzie POSIX — działa wszędzie.

---

## 🔧 Sekcja 1 — START / decyzja podstawowa

### ❓ Czy szukasz w **jednym pliku** czy w **katalogu**?

**Jeden plik**
```bash
grep "TEKST" plik

Katalog + podkatalogi

grep -R "TEKST"
-R = rekurencyjnie
Bez -R grep sprawdzi tylko jeden plik.

❓ Czy chcesz numery linii? (zazwyczaj TAK)
grep -Rn "TEKST"

Numery linii są kluczowe przy:

- warningach i błędach

- edycji w edytorze

- logach i audycie

🔧 Sekcja 2 — śmieci, binarki, bezpieczeństwo outputu
❓ Czy grep trafia na binarki / krzaki / warningi?

Tak → ignoruj pliki binarne

grep -RIn -I "TEKST" .


-I:

- nie próbuje czytać binarek

- brak „śmieci” w outputcie

- bezpieczniej w dużych drzewach

❓ Czy chcesz ograniczyć typ plików?

Tylko pliki .nix

grep -RIn --include="*.nix" "OPCJA" .


Bardzo ważne w /etc/nixos:

- omija logi

- omija pliki wynikowe

- mniej false-positive


❓ Czy chcesz pominąć katalogi techniczne?

Pomiń result/ (symlink po buildzie NixOS)

grep -RIn --exclude-dir=result "OPCJA" .

Zapobiega:

No such file or directory

ostrzeżeniom z niedziałających symlinków

⭐ Wersja bezpieczna (łączymy wszystko)
grep -RIn -I --include="*.nix" --exclude-dir=result "OPCJA"

🔧 Sekcja 3 — jak dokładnie dopasować tekst
❓ Czy ma znaczenie wielkość liter?

- Nie

grep -Ri "tekst" .

-i → ignoruje case (Text, TEXT, text)

❓ Szukasz fragmentu czy całego słowa?

Fragment (domyślnie)

grep -R "hardware.opengl" .

Dobre do:

- opcji NixOS

- prefiksów

- części nazw

- Całe słowo

grep -Rw "enable" 
Unika dopasowań typu enableX, re-enable

❓ Potrzebujesz kontekstu (linie przed / po)?
grep -Rn -C 2 "TEKST" .

-C 2 → 2 linie przed i po

-A 5 → tylko po

-B 5 → tylko przed

❓ Kilka wzorców naraz?
grep -R -E "opengl|graphics"
-E = regex alternatywy

🔧 Sekcja 4 — przypadki praktyczne
❓ Używasz pipe?
ps aux | grep ssh


grep filtruje strumień, nie tylko pliki.

❓ Chcesz tylko nazwy plików?
grep -Rl "TEKST" .

❓ Szukasz negacji (wszystko oprócz)?
grep -Rv "TEKST" .

⭐ Złota kombinacja (NixOS / /etc/nixos)
grep -RIn -I --include="*.nix" --exclude-dir=result "OPCJA"

Używaj gdy:

- szukasz deprecated options

- analizujesz warningi z nixos-rebuild

- audytujesz konfigurację

- opcja jest „gdzieś” w modułach

❌ Kiedy NIE używać grep?

- duże repozytoria

- szybkie wyszukiwanie kodu

- .gitignore, .ignore

➡️ Użyj rg (ripgrep)

🧠 grep vs rg — szybka decyzja

grep → klasyka, POSIX, pipe, minimalne systemy

rg → szybkość, repozytoria, codzienna praca



