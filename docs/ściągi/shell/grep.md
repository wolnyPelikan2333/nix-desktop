# grep — szybka ściąga


Co to polecenie robi — krok po kroku
grep

Narzędzie do szukania tekstu w plikach.
Nic nie zmienia, tylko czyta.

-R

Rekurencyjnie
Przeszukuje katalog i wszystkie podkatalogi.

Bez -R grep sprawdziłby tylko jeden plik.

-I

Ignoruj pliki binarne
Zapobiega śmieciom w outputcie, gdy grep trafi na pliki niedozwolone do czytania.

-n

Numery linii
Pokazuje numer linii w pliku — kluczowe przy edycji i ostrzeżeniach.

Przykład:

plik.nix:91: hardware.opengl 

--include="*.nix"

Szukaj tylko w plikach .nix
Eliminuje:

logi

pliki wynikowe

przypadkowe śmieci

Bardzo ważne w repozytoriach NixOS


--exclude-dir=result

Pomiń katalog result/
result to symlink po buildzie NixOS, często wskazujący na nieistniejące ścieżki.

Bez tego flagi grep może wypisywać ostrzeżenia:

No such file or directory

"hardware.opengl"

Szukany tekst (wzorzec)
Może być:

pełna opcja

fragment

prefiks (często lepsze niż pełna nazwa)

.

Katalog startowy
. = aktualny katalog (/etc/nixos)

Kiedy używać tej kombinacji

deprecated options w NixOS

ostrzeżenia z nixos-rebuild

szukanie opcji rozrzuconych po modułach

audyt konfiguracji

Złota wersja do NixOS
grep -RIn --include="*.nix" --exclude-dir=result "OPCJA" 

## Podstawy

grep "tekst" plik


Rekurencyjnie (katalog + podkatalogi)
grep -R "tekst"

Numery linii (BARDZO PRZYDATNE)
grep -Rn "tekst"

Case-insensitive
grep -Ri "tekst"

Kilka słów / fragment opcji
grep -R "hardware.opengl"

Całe słowo (nie fragment)
grep -Rw "enable"

Kontekst (linie przed / po)
grep -Rn -C 2 "tekst"

grep + pipe
ps aux | grep ssh

Szukanie wielu wzorców
grep -R -E "opengl|graphics"

Złote kombinacje
grep -RIn "coś" 
grep -Rn "opcja" /etc/nixos

## Przykład z życia (NixOS)

```bash
grep -RIn --include="*.nix" --exclude-dir=result "hardware.opengl"

PRZYKŁAD UŻYCIA:
grep -RIn --include="*.nix" --exclude-dir=result "hardware.opengl"


