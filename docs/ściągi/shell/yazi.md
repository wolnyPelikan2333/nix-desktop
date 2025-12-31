# Yazi — ściąga decyzyjna (file manager w terminalu)

> Cel: szybka orientacja i bezpieczna praca nawet przy niskiej sprawności poznawczej.
> Format: **pytanie → decyzja → klawisz**.

---

## Start / wyjście

**Chcę uruchomić Yazi**
→ w katalogu roboczym
→ `yazi`

**Chcę wyjść**
→ bez kombinowania
→ `q`

---

## Poruszanie się

**Wejść do katalogu**
→ zaznaczony katalog
→ `l` lub `Enter`

**Wyjść poziom wyżej**
→ katalog nadrzędny
→ `h`

**Szybko skakać po liście**
→ góra / dół
→ `k` / `j`

**Pierwszy / ostatni element**
→ bez scrollowania
→ `gg` / `G`

---

## Podgląd plików

**Podejrzeć plik (preview)**
→ po prawej stronie
→ automatycznie (jeśli włączony)

**Otworzyć plik domyślną aplikacją**
→ np. pdf, obraz
→ `Enter`

**Otworzyć w edytorze ($EDITOR)**
→ np. nvim
→ `o` → wybierz akcję (jeśli skonfigurowane)

---

## Zaznaczanie

**Zaznacz jeden plik**
→ pod operacje
→ `Space`

**Zaznacz wiele (ciąg)**
→ zakres
→ `v` + ruch `j/k`

**Odznacz wszystko**
→ reset
→ `Esc`

---

## Operacje na plikach

**Kopiuj**
→ do schowka
→ `y`

**Wytnij / przenieś**
→ do schowka
→ `x`

**Wklej**
→ w bieżącym katalogu
→ `p`

**Usuń (UWAGA!)**
→ operacja destrukcyjna
→ `d` → potwierdzenie

**Zmień nazwę**
→ pojedynczy plik
→ `r`

---

## Wyszukiwanie i filtrowanie

**Szukaj pliku po nazwie**
→ w bieżącym katalogu
→ `/` + tekst

**Czyść filtr**
→ wróć do pełnej listy
→ `Esc`

---

## Terminal i shell

**Otwórz shell w tym katalogu**
→ szybka komenda
→ `!`

**Wykonaj jedną komendę**
→ bez wychodzenia
→ `:` + komenda

---

## Zakładki / szybkie miejsca

**Dodaj zakładkę**
→ zapamiętaj katalog
→ `m` + litera

**Skocz do zakładki**
→ zapisane miejsce
→ `'` + litera

---

## Tryb awaryjny (gdy mózg się przegrzewa)

* `q` — wyjście zawsze działa
* `Esc` — reset trybu / zaznaczeń
* `h` — cofnięcie, bezpieczne

Jeśli nie wiesz co robisz → **nie używaj `d`**.

---

## Minimum do zapamiętania (ABSOLUTNE)

* `j / k` — góra / dół
* `h / l` — wyjście / wejście
* `Space` — zaznacz
* `y x p` — kopiuj / przenieś / wklej
* `q` — wyjście

---

Plik przeznaczony do katalogu: `docs/ściągi/shell/yazi.md`

