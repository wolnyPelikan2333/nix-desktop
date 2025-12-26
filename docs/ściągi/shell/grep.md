# grep — ściąga decyzyjna

> grep = **bezpieczne czytanie** plików  
> POSIX • pipe • działa wszędzie

---

## 🧭 START — co chcesz przeszukać?

### ❓ Jeden plik
```bash
grep "TEKST" plik

❓ Katalog (rekurencyjnie)
grep -R "TEKST"

🔢 Czy potrzebujesz numerów linii? (zazwyczaj TAK)
grep -Rn "TEKST"

Używaj gdy:

- analizujesz warningi / błędy

- otwierasz wynik w edytorze

- czytasz logi

🧼 Czy chcesz bezpieczny output? (binarki, symlinki, śmieci)
❓ Ignoruj pliki binarne
grep -RIn -I "TEKST"

❓ Ogranicz typ plików
grep -RIn --include="*.nix" "OPCJA" .

Używaj w /etc/nixos, gdy:

- nie chcesz grepować logów i wyników buildów

- szukasz opcji NixOS

❓ Pomiń katalogi techniczne
grep -RIn --exclude-dir=result "OPCJA" .

Zapobiega warningom z niedziałających symlinków (result/).

⭐ KANONICZNA KOMENDA (bezpieczna)
grep -RIn -I --include="*.nix" --exclude-dir=result "OPCJA"

Użyj gdy:

- opcja jest „gdzieś” w modułach

- analizujesz warningi nixos-rebuild

- audytujesz konfigurację

🎯 Jak dokładnie dopasować tekst?
❓ Ignoruj wielkość liter
grep -Ri "tekst"

❓ Fragment czy całe słowo?
grep -R "hardware.opengl" .
grep -Rw "enable"


Fragment:

- opcje NixOS

- prefiksy

- części nazw

- Całe słowo:

- unika dopasowań typu enableX, re-enable

❓ Potrzebujesz kontekstu?
grep -Rn -C 2 "TEKST" .

-C 2 → linie przed i po

-A 5 → tylko po

-B 5 → tylko przed

❓ Kilka wzorców naraz
grep -R -E "opengl|graphics" .

📤 Co chcesz dostać na wyjściu?
❓ Tylko nazwy plików
grep -Rl "TEKST" 

❓ Negacja (wszystko oprócz)
grep -Rv "TEKST" .

🔌 Czy używasz pipe?
ps aux | grep ssh


grep filtruje strumień, nie tylko pliki.

❌ Kiedy NIE używać grep?

- duże repozytoria

- szybkie wyszukiwanie kodu

- .gitignore, .ignore

➡️ użyj rg (ripgrep)

🧠 grep vs rg — szybka decyzja

grep → POSIX, pipe, systemy minimalne

rg → szybkość, repozytoria, codzienna praca


