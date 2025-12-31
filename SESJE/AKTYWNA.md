# 🧠 AKTYWNA — stan pracy
_utworzono: 28-12-2025 (niedziela) 22:05_  
_ostatnia aktualizacja: 29-12-2025_

---

## 🔴 TERAZ
- Używać nowego systemu sesji przez kilka dni **bez zmian**
- Zapisywać **WYŁĄCZNIE tutaj**  
  (bez powrotów do `docs/SESJA.md`)

---

## 🟢 W TOKU
**Nowy workflow sesji:**
- `sesja-start` → orientacja → **ENTER** → praca
- brak `sesja-stop`

**Obserwacja:**
- czy ENTER-pauza pomaga
- czy output `sesja-start` nie jest za długi

---

## 🟡 POTEM / PRZYPOMNIENIA
- Nix: jak bezpiecznie edytować bloki `''` / `"` — **5 punktów**
- (~za kilka dni) ewentualny cleanup:
  - skrócić legacy output w `sesja-start`
  - zdecydować, czy całkiem ukryć `docs/SESJA.md`
- Spisać krótką notkę:
  - **„Jak działa system SESJE”** (dla przyszłego mnie)

---

## 📎 KONTEKST / ODNIESIENIA
- Nowy system: `/etc/nixos/SESJE/`
- Jedyny plik roboczy: **AKTYWNA.md**
- ARCHIWUM tylko przy:
  - zamykaniu pliku
  - zmianie kontekstu
- Hasło awaryjne: **„zamykamy”**

---

## 🧠 NOTATKA STANU
- System świeżo wdrożony, stabilny
- **Nic nie refaktorować na razie**
- Najpierw używać → potem poprawiać

---

# 📅 SESJE (od najnowszej)

## 📅 2025-12-31 — porządkowanie nss / nbuild

DONE:
- `nss` przebudowany na tryb decyzyjny A/B/C (jawna intencja, brak automatyki)
- commit/push tylko w trybie C, staging wyłącznie ręczny (`ga`)
- zapis sesji tylko do `/etc/nixos/SESJE/AKTYWNA.md`
- wykryto i usunięto duplikat `nbuild`
- `nbuild` pozostawiony wyłącznie w `modules/zsh.nix` (bez zmiany zachowania)

Stan repo: CLEAN
Checkpoint: OK

NEXT:
- brak (temat zamknięty)


---

## 📅 2025-12-30 — praca na nowym systemie SESJE

### ⏱ Czas
start: —
koniec: —

### 🎯 Cel sesji
- Przetestować nowy system SESJE w realnej pracy
- Sprawdzić, czy jeden plik AKTYWNA.md wystarcza jako źródło prawdy

### ✅ Zrobione
- praca wyłącznie na AKTYWNA.md (bez użycia docs/SESJA.md)
- weryfikacja, że zapis „na bieżąco” zmniejsza chaos poznawczy
- potwierdzenie, że rozdział:
  - stan bieżący
  - dziennik sesji  
  jest czytelny i bezpieczny

### 🧠 Wnioski
- jeden aktywny plik roboczy działa lepiej niż archiwum + dziennik
- brak `sesja-stop` **nie psuje ciągłości pracy**
- system nie wymusza decyzji w złym momencie

### 📌 Następny krok
- dalej używać systemu **bez zmian**
- wrócić do ewentualnych korekt dopiero po kilku dniach


---

## 📅 2025-12-29 — rollback systemu (NixOS)

**Kontekst:**
- po zmianach konfiguracyjnych brak dostępnych funkcji Zsh (m.in. `nss`)
- decyzja: powrót do ostatniej stabilnej generacji systemu

**Wykonane kroki:**
1. Sprawdzenie generacji systemu
2. Rollback do poprzedniej generacji (**117**)
3. Restart powłoki:
exec zsh
4. Weryfikacja stanu:
type nss
sudo nixos-rebuild list-generations | head -n 5
5. Usunięcie nieudanej generacji:
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 118

**Efekt:**
- aktywna generacja: **117 (STABLE)**
- generacja 118 usunięta
- shell i aliasy działają poprawnie

Stan systemu: **STABILNY**  
Stan repo: **BEZ ZMIAN**  
Checkpoint: **OK**

**NEXT:**
- przywrócić `sesja-start` jako narzędzie systemowe  
(w osobnej sesji)

---

## 📅 2025-12-29 — dokumentacja NixOS

### ⏱ Czas
- start: —
- koniec: —

### 🔧 Zmiany techniczne
- `docs/README.md`
- `docs/standardy/nix.md`

### 🎯 Cel sesji
Zbudować spójną, użyteczną strukturę dokumentacji NixOS:
- mapa dokumentacji (`docs/README.md`)
- kontrakt pracy z systemem (`standardy/nix.md`)

### ✅ Zrobione
- pełna inwentaryzacja istniejącej dokumentacji
- zaprojektowano i zapisano mapę dokumentów
- zaprojektowano i zapisano kontrakt pracy z NixOS
- zdefiniowano nadrzędną zasadę bezpieczeństwa:  
*system ważniejszy niż tempo*
- wprowadzono wzorzec **⚠️ OPERACJA PRODUKCYJNA**
- zamknięto drugi moduł dokumentacji (standardy)

### 🧠 Wnioski
- dokumentacja = system bezpieczeństwa, nie tutorial
- jeden spójny format ostrzegawczy > wiele miękkich komunikatów
- standardy muszą być zmienialne
- rozdzielenie: **standardy → procedury → ściągi**
realnie zmniejsza obciążenie poznawcze

### 📌 Następny krok
1. Uzupełnianie kolejnych standardów (jeśli zajdzie potrzeba)
2. Zaprojektowanie technicznego bezpiecznika dla `nss`
(alias / wrapper / hook)

---

## 📅 Następna sesja — PLAN

### 🎯 Cel
- Porządkowanie dokumentacji  
(**bez zmian w shell / HM / Zsh**)

### 🧭 Zakres
- Podpięcie `docs/ściągi/nix/nss.md` do:
- `docs/ściągi/nix/README.md`

**Bez:**
- aliasów
- funkcji Zsh
- zmian w Home Manager / modules

### ✅ Stan wejściowy
- eksperyment `nss-doc` **w całości usunięty**
- `rg nss-doc /etc/nixos` → brak wyników
- build wrócił do stabilnego stanu

### 🧠 Wnioski
- integracje shell ↔ HM są kosztowne poznawczo
- dokumentacja działa **bez skrótów w Zsh**

### 📌 Zasada na sesję
> **Tylko docs.**  
> **Zero zmian systemowych.**


## 📅 2025-12-31 18:50

- Mode: commit
- Risk: NORMAL
- Changes:
SESJE/AKTYWNA.md

## 📅 2025-12-31 19:09

- Mode: commit
- Risk: NORMAL
- Changes:
SESJE/AKTYWNA.md
