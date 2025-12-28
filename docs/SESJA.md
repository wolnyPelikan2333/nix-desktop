### 🎯 Cel sesji
- Sprawdzenie stanu repo i kontekstu po przerwie
- Weryfikacja aktywnej gałęzi (recovery-baseline)

### ✅ Zrobione
- Uruchomiono sesja-start
- Zweryfikowano, że repo /etc/nixos jest czyste
- Potwierdzono pracę na recovery-baseline

### 🧠 Wnioski
- Brak zmian technicznych = brak ryzyka
- Sesja miała charakter orientacyjny / przygotowawczy

### 📌 Następny krok
- Zaplanować konkretny cel techniczny przed kolejną sesją


--- END SESSION ---

## 📅 2025-12-28

### ⏱ Czas
start: —
koniec: —

### 🎯 Cel sesji
- Stabilna muzyka offline do pracy i modlitwy
- Brak zależności od internetu
- Sterowanie z terminala bez blokowania pracy

### 🔧 Zmiany techniczne
- dodano mpd + mpc (audio w tle, terminal wolny)
- utworzono strukturę `~/Music/music/gregorian/{praca,modlitwa,noc,melodia-wiary}`
- dodano yt-dlp (YouTube → audio offline)
- dodano funkcje:
  - yta-praca
  - yta-modlitwa
  - yta-noc
  - yta-wiara
- dodano aliasy mpd:
  - music-praca
  - music-modlitwa
  - music-noc
  - music-wiara
- poprawiono strukturę `lib.mkMerge` w `zsh.nix` (usunięcie błędnego `''`)

### ✅ Zrobione
- mpd gra w tle i nie przejmuje terminala
- muzyka może grać podczas `nss` i pracy w `/etc/nixos`
:- YouTube → mp3 → właściwy folder → mpd update działa jednym poleceniem
- rozdzielenie trybów słuchania przez foldery (bez sortowania po fakcie)

### 🧠 Wnioski
- mpv nadaje się do testów, mpd do codziennej pracy
- folder = tryb (ważniejsze niż pliki/tagi)
- aliasy redukują decyzje i utrzymują spokój
- dyscyplina `mkMerge` jest kluczowa w konfiguracji Zsh

### 📌 Następny krok
- (opcjonalnie) krótka ściąga „Audio workflow — mpd + mpc + yt-dlp”
- ewentualnie autostart mpd po loginie


## 🌐 qutebrowser — dark baseline (komfort wzroku)

**Problem:** domyślna konfiguracja wali białym tłem po oczach.  
**Cel:** spokojny dark mode, zero magii, jedno źródło konfiguracji.

**Stan faktyczny:**
- qutebrowser zainstalowany
- brak `config.py` (czysta konfiguracja domyślna)
- katalog: `~/.config/qutebrowser/`

**Rozwiązanie:**
Utworzono ręczną konfigurację.

Plik:
~/.config/qutebrowser/config.py


Kluczowe decyzje:
- `config.load_autoconfig(False)`  
  → jedno źródło prawdy, brak ostrzeżeń
- włączony dark mode stron
- kontrast ustawiony łagodnie (nie absolutna czerń)
- delikatne kolory UI
- brak adblocka, JS tweaks, keybindów (świadomie)

**Status:** działa, komfort OK


## ✅ Neovim — autopairs (LazyVim override)

**Cel:** ultra-lekka, przewidywalna konfiguracja autopairs  
bez „smart magii”, bez Treesittera, bez integracji z cmp.

**Stan faktyczny:**
- `nvim-autopairs` dostarczany domyślnie przez LazyVim
- plugin NIE jest zarządzany przez NixOS / Home Manager
- wersja zablokowana w `~/.config/nvim/lazy-lock.json`

**Rozwiązanie:**
Jawny override konfiguracji LazyVim.

Plik:
~/.config/nvim/lua/plugins/autopairs.lua


Konfiguracja:
- `check_ts = false`
- `fast_wrap = false`
- tylko podstawowe pary: `() [] {} "" ''`
- brak agresji w Markdown

**Dlaczego tak:**
- minimalne tarcie poznawcze
- przewidywalność > spryt
- jeden plik = pełna kontrola
- usunięcie pliku = powrót do defaultów LazyVim

**Status:** działa, zostaje



## 2025-12-26 — terminal web workflow (baseline)

✅ Zainstalowane i przetestowane:
- ddgr — wyszukiwarka DuckDuckGo w terminalu
- elinks — przeglądarka tekstowa do docs / czytania
- qutebrowser — pełny web (GUI, klawiaturowy)

📌 Status:
- instalacja OK
- brak konfiguracji (świadomie)
- system stabilny
- dobra baza do dalszej pracy

🧭 Plan na kolejną sesję:
1. aliasy (dd, ww, itp.)
2. minimalna konfiguracja qutebrowser (external editor = nvim)
3. spisanie workflow: szukam → czytam → zapisuję
4. checkpoint (commit + push)

🛑 Sesja zamknięta komendą „zamykamy”.


2025-12-26

ZSH: rozdzielenie aliasów i funkcji; usunięcie ns; dodanie nbuild i nss; konflikt rozwiązany przez switch.”

### 📌 Następny krok
- Dokończyć audyt aliasów ZSH (porządkowanie, brakujące, decyzje)

2025-12-26
✔ Zainstalowano Zellij przez Home Manager
✔ ETAP 1 zakończony (bez auto-startu, bez zmian w skrótach)
✔ System stabilny po ns
⏭ Następne: opcjonalnie alias zj / sesje nazwane


# 🧾 SESJA

## 📅 Data
2025-12-26

## ⏱ Czas
start: nieformalnie  
koniec: domknięcie sesji

---

## 🎯 Cel sesji
Utworzyć prosty, bezpieczny system notatek w Markdown zsynchronizowany z GitHubem, bez magii i z pełną kontrolą.

---

## ✅ Zrobione
- utworzono repo `notes-md` na notatki `.md`
- zaprojektowano strukturę katalogów (daily / nixos / ideas / archive)
- dodano workflow dziennych notatek (`note`)
- dodano nawigację (`nd`, `ni`, `nn`)
- dodano szablony NixOS (debug / runbook / decyzje)
- dodano aliasy do szablonów (`ndd`, `ndr`, `ndc`)
- dodano pół-automat synchronizacji (A1: pytanie o sync)
- utworzono README jako indeks notatek
- utworzono ściągę aliasów (`README-aliases.md`)

---

## 🔧 Zmiany techniczne
- `/etc/nixos/modules/zsh.nix`
  - nowe funkcje: `note`, `notes-sync`, `notes-sync-ask`
  - aliasy: `nd`, `ni`, `nn`, `ndd`, `ndr`, `ndc`
- repo notatek: `~/notes-md` (osobny GitHub)

---

## 🧠 Wnioski
- rozróżnienie „nawigacja vs akcja” jest kluczowe
- automatyzacja ma sens tylko tam, gdzie nie przeszkadza
- README + ściąga zdejmują ciężar pamięci
- lepiej najpierw widoczność, potem automaty

---

## ⚠️ Otwarte rzeczy / ryzyka
- brak (system stabilny, workflow domknięty)

---

## 📌 Następny krok
Użyć systemu przez kilka dni bez zmian i zobaczyć, co realnie przeszkadza.

---

## 🛑 Checkpoint
- [x] zmiany zapisane
- [x] commit zrobiony (`ns`)
- [x] push wykonany
- [x] system stabilny

---

## 🧘 Stan
Spokojny, z poczuciem kontroli i zrozumienia tego, co zostało zrobione.


## 2025-12-26 — refaktor sed-awk.md

DONE:
- sed-awk.md przepisany do formy ściągi decyzyjnej
- rozdzielenie decyzji: kiedy sed / kiedy awk
- dodane gotowe wzorce poleceń
- skrócenie treści do formy „kopiuj i użyj”

Stan repo: CLEAN
Checkpoint: OK

NEXT (następna sesja — wybrać jedno):
- refaktor xargs.md do formy decyzyjnej
- pakiet vim-* (ujednolicenie struktury i decyzji)


## 2025-12-26 — sanity-check docs/ściągi/shell

DONE:
- przegląd katalogu shell
- klasyfikacja plików (OK / do refaktoru)
- identyfikacja problemu struktury vim

Stan repo: CLEAN
Checkpoint: OK

NEXT:
- refaktor sed-awk.md do formy decyzyjnej


## 2025-12-26 — mini-ściąga grep vs rg

DONE:
- dodana mini-ściąga: grep-vs-rg.md
- decyzje: kiedy grep / kiedy rg
- zapisane, zakomitowane, wypchnięte

Stan repo: CLEAN
Checkpoint: OK

NEXT (następna sesja — wybrać jedno):
- sanity-check katalogu docs/ściągi/shell
- refaktor jednej ściągi: sed-awk / xargs / vim


 # SESJA — dziennik pracy

Ten plik zawiera checkpointy sesji roboczych.
Każda sesja = krótki wpis:
- co zrobione
- stan repo
- gdzie skończyliśmy
- co dalej (max 1–2 punkty)

Zasada:
Hasło **„zamykamy”** → wpis do tego pliku.
---

## 2025-12-26 — refaktor grep.md

DONE:
- grep.md przepisany do formy ściągi decyzyjnej
- struktura: pytanie → decyzja → komenda
- spójność z rg-fd-tree.md
- zapisane, zakomitowane, wypchnięte

Stan repo: CLEAN  
Checkpoint: OK

NEXT (następna sesja — wybrać jedno):
- mini-ściąga: grep vs rg — kiedy które
- sanity-check katalogu docs/ściągi/shell

🧠 Ważna zasada (zapamiętajmy)

SESJA.md nie jest dokumentacją

to pamięć robocza systemu

krótko, technicznie, bez lania wody

jeden wpis = jedna zamknięta sesja

## 📅 2025-12-26

### ⏱ Czas
start: 2025-12-26 10:32
koniec: 2025-12-26 21:31

### 🔧 Zmiany techniczne
- docs/SESJA.md
- home/zsh/core.nix
- modules/zsh.nix

### 🎯 Cel sesji
- 

### ✅ Zrobione
- 

### 🧠 Wnioski
- 

### 📌 Następny krok
- 

## 📅 2025-12-27

### ⏱ Czas
start: 2025-12-26 23:53
koniec: 2025-12-27 00:12

### 🔧 Zmiany techniczne
- docs/SESJA.md

### 🎯 Cel sesji
- 

### ✅ Zrobione
- 

### 🧠 Wnioski
- 

### 📌 Następny krok
- 

## 📅 2025-12-28

### ⏱ Czas
start: 2025-12-27 20:06
koniec: 2025-12-28 02:12

### 🔧 Zmiany techniczne
- docs/SESJA.md

### 🎯 Cel sesji
- 

### ✅ Zrobione
- 

### 🧠 Wnioski
- 

### 📌 Następny krok
- 
