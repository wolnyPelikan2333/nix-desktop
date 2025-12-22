# grep — szybka ściąga

Szukanie tekstu w plikach.  
Bezpieczne: **nic nie zmienia**, tylko czyta.

---

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



