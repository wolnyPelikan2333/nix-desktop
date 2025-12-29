# 🧠 AKTYWNA — stan pracy
_utworzono: 28-12-2025 (niedziela) 22:05_
_ostatnia aktualizacja: 28-12-2025 22:20_

## 🔴 TERAZ
-  Używać nowego systemu sesji przez kilka dni bez zmian
- Zapisywać WYŁĄCZNIE tutaj (bez powrotów do docs/SESJA.md)


## 🟢 W TOKU
-- Nowy workflow sesji:
  - sesja-start → orientacja → ENTER → praca
  - brak sesja-stop
-- Obserwacja:
  - czy ENTER pauza pomaga
  - czy output sesja-start nie jest za długi 

## 🟡 POTEM / PRZYPOMNIENIA
Nix: jak bezpiecznie edytować bloki ''” (5 punktów)
- (~za kilka dni) ewentualny cleanup:
  - skrócić legacy output w sesja-start
  - zdecydować, czy całkiem ukryć docs/SESJA.md
- Spisać krótką notkę:
  - „Jak działa system SESJE” (dla przyszłego mnie)

## 📎 KONTEKST / ODNIESIENIA
-- Nowy system = /etc/nixos/SESJE/
- Jedyny plik roboczy: AKTYWNA.md
- ARCHIWUM tylko przy zamykaniu pliku (kilka dni / zmiana kontekstu)
- Hasło awaryjne: „zamykamy” 

## 🧠 NOTATKA STANU
- System świeżo wdrożony, stabilny:
- Nic nie refaktorować na razie
- Najpierw używać, potem poprawiać 

## 📅 2025-12-29

### ⏱ Czas
start: —
koniec: —

### 🔧 Zmiany techniczne
- docs/README.md
- docs/standardy/nix.md

### 🎯 Cel sesji
Zbudować spójną, użyteczną strukturę dokumentacji NixOS:
- mapę dokumentacji (`docs/README.md`)
- kontrakt pracy ze systemem (`standardy/nix.md`)

### ✅ Zrobione
- wykonano pełną inwentaryzację istniejącej dokumentacji
- zaprojektowano i zapisano `docs/README.md` jako mapę dokumentów
- zaprojektowano i zapisano `docs/standardy/nix.md` jako kontrakt pracy z NixOS
- zdefiniowano nadrzędną zasadę bezpieczeństwa: *system ważniejszy niż tempo*
- wprowadzono wzorzec ostrzegawczy **⚠️ OPERACJA PRODUKCYJNA**
- zamknięto drugi moduł dokumentacji (standardy)

### 🧠 Wnioski
- dokumentacja musi być projektowana jak system bezpieczeństwa, nie jak tutorial
- jeden spójny format ostrzegawczy działa lepiej niż wiele miękkich komunikatów
- standardy muszą być zmienialne, inaczej stają się blokadą zamiast pomocą
- rozdzielenie: standardy → procedury → ściągi realnie zmniejsza obciążenie poznawcze

### 📌 Następny krok
1. Wypełnianie treści kolejnych standardów (jeśli zajdzie potrzeba)
2. Zaprojektowanie i wdrożenie technicznego bezpiecznika dla `nss`
   (alias / wrapper / hook) zgodnie z `standardy/nix.md`

## 📅 Następna sesja — PLAN

### 🎯 Cel
- Porządkowanie dokumentacji (bez zmian w shell / HM / Zsh)

### 🧭 Zakres
- Podpięcie `docs/ściągi/nix/nss.md` w:
  - `docs/ściągi/nix/README.md`
- Bez:
  - aliasów
  - funkcji Zsh
  - zmian w Home Manager / modules

### ✅ Stan wejściowy
- Eksperyment `nss-doc` **w całości usunięty**
- `rg nss-doc /etc/nixos` → brak wyników
- Build wrócił do stabilnego stanu

### 🧠 Wnioski
- Integracje shell ↔ HM są kosztowne poznawczo
- Dokumentacja spełnia swoją rolę **bez skrótów w Zsh**

### 📌 Zasada na sesję
> Tylko docs.  
> Zero zmian systemowych.

