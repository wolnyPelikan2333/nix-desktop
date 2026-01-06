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
- Najpierw używać → potem popCzęść keymap działała, część nie

Wklejanie ze schowka systemowego działało tylko pCzęść keymap działała, część nie

Wklejanie ze schowka systemowego działało tylko przez Ctrl+Shift+V

"+y / <leader>y nie działały

Trudność w rozróżnieniu: terminal vs Neovim vs rejestryrzez Ctrl+Shift+V

"+y / <leader>y nie działały

Trudność w rozróżnieniu: terminal vs Neovim vs rejestryrawiać

---

# 📅 SESJE (od najnowszej)


## 📅 2026-01-06 20:43

- Mode: commit
- Risk: NORMAL
- Changes:

📅 06-01-2026 19:05
Temat

Ujednolicenie nawigacji paneli (tmux + nvim) pod kątem pracy w stanie 2–3

Stan wyjściowy

Różne skróty do paneli w tmux i nvim

Konieczność pamiętania prefiksu tmuxa

Frustracja i utrata płynności pracy w stanie przeciążenia

Decyzja

Ujednolicenie mapy ruchów:

Ctrl + strzałki → panele tmuxa (ruch przestrzenny, bez prefiksu)

Ctrl + literki → nvim (ruch w tekście, precyzja)

Utrwalenie rozwiązania w konfiguracji home-manager (bez shmuxa)

Wdrożenie

Dodanie wiązań Ctrl + ← → ↑ ↓ w programs.tmux.extraConfig

Rozwiązanie konfliktu home-manager przez home-manager.backupFileExtension = "bak" w flake.nix

Build i switch zakończone powodzeniem (nss ok)

Status

✔️ Zrobione
🧠 Zauważalnie mniejsze napięcie i brak konfliktów skrótów
🧭 Jednoznaczny podział ról: tmux = przestrzeń, nvim = tekst

PLAN

🔁 zrobić automatyczny start 3 paneli (bez shmuxa)
🧭 dorobić wizualny wskaźnik „gdzie jestem”
🧠 przenieść ten wzorzec na inne narzędzia
przemyśleć porzucenie prefiksu Ctrl-a na rzecz skrótów do robienia paneli

## 📅 2026-01-06 19:10

- Mode: commit
- Risk: NORMAL
- Changes:

## 📅 06-01-2026 15:05

### Temat

Integracja nawigacji Neovim ↔ tmux (Ctrl-h / Ctrl-j / Ctrl-k / Ctrl-l)

### Stan wyjściowy

- Neovim sprawdzony (checkhealth OK)
- Splity i buffory działają poprawnie
- Brak blokad klawiszy Ctrl-h/j/k/l
- Istniejące mapowania tmuxa z prefiksem Ctrl-a (h/j/k/l, resize H/J/K/L)

### Decyzja

Wdrożenie inteligentnej nawigacji pomiędzy splitami Neovim i panelami tmuxa
bez zmiany prefixu tmuxa i bez ingerencji w konfigurację Neovim.

### Wdrożenie

- Dodano w tmux obsługę Ctrl-h/j/k/l bez prefiksu:
  - jeśli aktywny jest Neovim → klawisz trafia do nvim
  - jeśli nie → tmux przełącza panel
- Zachowano istniejące skróty:
  - Ctrl-a + h/j/k/l (nawigacja)
  - Ctrl-a + H/J/K/L (resize)

### Status

✔️ Zrobione  
🧭 Integracja nawigacji działa poprawnie (test pozytywny)

### Uwagi

- Brak konfliktów mapowań
- Zmiana odwracalna (jeden blok w tmux)

### Plan (następna sesja)

- Krok 2: omówienie (bez wdrożenia) integracji splitów
- Opcjonalnie: przeniesienie konfiguracji tmuxa do NixOS

📅 06-01-2026 12:55
Temat

Integracja schowka systemowego z Neovim (copy / paste) + ergonomia pracy na dwóch monitorach

Stan wyjściowy

Alt + P działało (wklejanie ze schowka systemowego do nvim)

Brak wygodnej opcji kopiowania z nvim do schowka systemowego

Chrome na lewym monitorze miał zbyt małą czcionkę (problem DPI / scaling)

Skróty Alt + F / Alt + G nie były jeszcze zdefiniowane (zakomentowane)

Decyzje

Najpierw usunięcie blockera ergonomicznego (skalowanie per-monitor w KDE Plasma)

Zachowanie zasady: najpierw decyzja co skrót ma robić, potem konfiguracja

Ustalenie symetrii:

Alt + P → paste z systemu → nvim

Alt + Y → copy z nvim → system

Wdrożenie

Poprawiono skalowanie per-monitor w KDE Plasma (zmiana zadziałała natychmiast)

Potwierdzono, że w Neovim istnieje i działa mapowanie:

,y → yank do systemowego clipboarda ("+y)

Skonfigurowano skrót w Alacritty:

Alt + Y → wysyła ,y do Neovim

Test wykonany praktycznie: tekst skopiowany w nvim (Alt + Y) i wklejony do Chrome

Status

✔️ Zrobione
🧭 Pełna, stabilna integracja schowka systemowego z Neovim
🧠 Workflow spójny i symetryczny, bez konfliktów i zgadywania

Wnioski / Notatki

VeryLazy (lazy.nvim) nie powoduje problemów z keymapami

Usuwanie ("\_) i kopiowanie ("+) są świadomie rozdzielone

Ergonomia (DPI, oczy, zmęczenie) ma priorytet nad konfiguracją

Następne kroki (opcjonalne)

Ujednolicenie Alt + F / Alt + G pod akcje w Neovim

Konfiguracja tmux (prefiks Ctrl + A) krok po kroku

Checkpoint i przerwa, jeśli potrzebne

---

## 📅 2026-01-06 12:51

- Mode: commit
- Risk: NORMAL
- Changes:

## 📅 06-01-2026 01:22

### Temat

Alacritty + tmux — start dnia

### Decyzja

Auto-start tmux (`main`) z otwarciem AKTYWNA.md przy tworzeniu sesji.

### Status

✔️ Działa, zostaje

PLAN:
dopiąć nvim ↔ tmux hjkl

## 📅 2026-01-06 01:18

- Mode: commit
- Risk: NORMAL
- Changes:

## 📅 2026-01-06 00:55

- Mode: commit
- Risk: NORMAL
- Changes:

## 📅 2026-01-06 00:11

- Mode: commit
- Risk: NORMAL
- Changes:

## 📅 2026-01-05 23:56

- Mode: commit
- Risk: NORMAL
- Changes:

## 📅 05-01-2026 23:38

### Temat

Alacritty — wybór terminala

### Decyzja

Zostaje Alacritty.

### Uzasadnienie

Po ~10 minutach testów działa neutralnie, nie przeszkadza, spełnia potrzeby.

### Status

✔️ Zamknięte

## 📅 2026-01-05 23:35

- Mode: commit
- Risk: NORMAL
- Changes:

## 📅 2026-01-05 23:10

- Mode: commit
- Risk: NORMAL
- Changes:
  home/michal.nix

Data: 05-01-2026 20:01

### Temat

Neovim — rejestry, schowek systemowy i skróty leaderowe (kanoniczne)

### Stan wyjściowy

Część keymap działała, część nie

Wklejanie ze schowka systemowego działało tylko przez Ctrl+Shift+V

"+y / <leader>y nie działały

Trudność w rozróżnieniu: terminal vs Neovim vs rejestry

Diagnoza

:echo has('clipboard') → 0

Neovim nie miał podłączonego schowka systemowego

Ctrl+Shift+V działał, bo był obsługiwany przez terminal, nie przez Neovima

### Decyzja

Uznano rejestry za kanoniczny mechanizm pracy

Przyjęto stały zestaw rejestrów: ", 0, +, \_

Leader ustawiony na ,

Zdefiniowano jednoruchowe skróty leaderowe, które ukrywają rejestry

### Wdrożenie

Ustalono kanoniczną ściągę rejestrów:

" — domyślny (niestabilny)

0 — ostatni yank (bezpieczny)

- — schowek systemowy

\_ — czarny rejestr (kasowanie bez śladu)

Dodano skróty leaderowe (tryb normalny):

,y → "+yy (kopiuj linię do schowka systemowego)

,p → "+p (wklej ze schowka systemowego)

,Y → "0yy (bezpieczny yank do rejestru 0)

,P → "0p (wklej z rejestru 0)

,d → "\_dd (usuń linię bez psucia schowka)

Zachowano pełną kompatybilność z ręcznym użyciem "+…, "0…, "\_…

### Status

✔️ Zrobione
✔️ Rejestry działają przewidywalnie
✔️ Jednoruchowe skróty eliminują potrzebę pamiętania "+
✔️ Rozróżnienie: terminal ≠ Neovim ≠ rejestry jest jasne

### Plan

(opcjonalnie) wariant visual dla skrótów leaderowych

(opcjonalnie) sekcja „antywpadki” do dokumentacji

(opcjonalnie) uporządkowanie pozostałych keymaps pod ten sam model

---

## 📅 2026-01-05 19:23

- Mode: commit
- Risk: NORMAL
- Changes:

### Data: 05-01-2026 15:20

### Temat

### Stan wyjściowy

### Decyzja

### Wdrożenie

### Status

### Plan

Data: 05-01-2026 15:20

### Temat

Wykorzystanie rejestrów i makr w Neovim do usprawnienia pracy z plikami SESJA.md / AKTYWNA.md

### Stan wyjściowy

- Rejestry i makra w Vim/Neovim były znane tylko teoretycznie
- Brak praktycznego workflow do tworzenia i uzupełniania wpisów sesji
- Powtarzalne czynności wykonywane ręcznie (nagłówki, sekcje)

### Decyzja

- Wykorzystać rejestry `a–d` jako robocze schowki sesji
- Użyć makr do automatycznego wstawiania szkieletu wpisu sesji
- Powiązać rejestry bezpośrednio z plikami `SESJA.md` / `AKTYWNA.md`

### Wdrożenie

- Ustalono przeznaczenie rejestrów:
  - `a` – temat / nagłówek sesji
  - `b` – decyzje
  - `c` – komendy / kroki techniczne
  - `d` – plan / następne kroki
- Nagrano makro w rejestrze `a`, które wstawia szkielet wpisu sesji:
  - Temat
  - Stan wyjściowy
  - Decyzja
  - Wdrożenie
  - Status
  - Plan
- Makro jest uruchamiane komendą `@a`
- Rejestry używane jako „klocki”, wklejane do sesji w dowolnej kolejności

### Status

✔️ **Zrobione**

### 🧭 Efekt

- Tworzenie nowego wpisu sesji zajmuje kilka sekund
- Mniej ręcznego pisania i mniejsze obciążenie poznawcze
- Spójna struktura wpisów w `SESJA.md` i `AKTYWNA.md`

### Plan

- Wyrobić nawyk używania rejestrów `a–d` podczas każdej sesji
- W kolejnej sesji rozważyć dodatkowe makro do częstych operacji edycyjnych

## 📅 05-01-2026 15:05

### 🧭 Temat

Wykorzystanie rejestrów i makr w Neovim do usprawnienia pracy z plikami SESJA.md / AKTYWNA.md

### 📌 Stan wyjściowy

- Rejestry i makra w Vim/Neovim były znane tylko teoretycznie
- Brak praktycznego workflow do tworzenia i uzupełniania wpisów sesji
- Powtarzalne czynności wykonywane ręcznie (nagłówki, sekcje)

### 🧠 Decyzja

- Wykorzystać rejestry `a–d` jako robocze schowki sesji
- Użyć makr do automatycznego wstawiania szkieletu wpisu sesji
- Powiązać rejestry bezpośrednio z plikami `SESJA.md` / `AKTYWNA.md`

### 🔧 Wdrożenie

- Ustalono przeznaczenie rejestrów:
  - `a` – temat / nagłówek sesji
  - `b` – decyzje
  - `c` – komendy / kroki techniczne
  - `d` – plan / następne kroki
- Nagrano makro w rejestrze `a`, które wstawia szkielet wpisu sesji:
  - Temat
  - Stan wyjściowy
  - Decyzja
  - Wdrożenie
  - Status
  - Plan
- Makro jest uruchamiane komendą `@a`
- Rejestry używane jako „klocki”, wklejane do sesji w dowolnej kolejności

### 📊 Status

✔️ **Zrobione**

### 🧭 Efekt

- Tworzenie nowego wpisu sesji zajmuje kilka sekund
- Mniej ręcznego pisania i mniejsze obciążenie poznawcze
- Spójna struktura wpisów w `SESJA.md` i `AKTYWNA.md`

### 📅 Plan / Następne kroki

- Wyrobić nawyk używania rejestrów `a–d` podczas każdej sesji
- W kolejnej sesji rozważyć dodatkowe makro do częstych operacji edycyjnych

---

## 📅 05-01-2026 14:11

### 🧭 Temat

Przekopiowanie plików kursu JavaScript z folderu Pobrane do folderów lekcji

### 📌 Stan wyjściowy

- W katalogu `javascript-teoria` w folderach lekcji znajduje się tylko `README.md`

### 🧠 Decyzja

- Kopiowanie plików do odpowiednich folderów lekcji

### 🔧 Wdrożenie

- Skopiowano pliki z:
  - **Źródło:** `~/Pobrane`
- Do:
  - **Cel:**
    - `~/javascript-teoria/lekcja_01`
    - `~/javascript-teoria/lekcja_02`

### 📊 Status

✔️ **Zrobione**

### 🧭 Efekt

- Pliki zostały poprawnie przekopiowane do folderów właściwych lekcji

### 📅 Plan / Następne kroki

- Sukcesywnie kopiować kolejne pliki zgodnie z postępami w nauce

---

## 📅 05-01-2026 01:05

### Temat

Autopairs i domykanie tagów HTML w LazyVim

### Stan wyjściowy

- LazyVim z `nvim-autopairs` już zainstalowany
- Autopairs działa poprawnie dla `() [] {} "" ''`
- Brak automatycznego domykania tagów HTML (stan domyślny)

### Decyzja

- **Zostawić** `nvim-autopairs`
- **Dodać** lekkie domykanie tagów HTML przez Tree-sitter

### Wdrożenie

Dodano plugin:

- `windwp/nvim-ts-autotag`

Plik:
~/.config/nvim/lua/plugins/autotag.lua

Konfiguracja:

````lua
return {
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
}

Wymagania

Tree-sitter parser html (opcjonalnie: javascript, tsx)

Efekt

<div> → <div></div>

poprawne zachowanie dla self-closing (<img />)

brak konfliktów z autopairs

automatyzacja tylko tam, gdzie ma sens

Uwagi

Świadomie nie dodawano emmetów ani ciężkich snippetów

Konfiguracja minimalna, odwracalna, bez wpływu na inne filetype’y

Status

✔️ Zrobione
🧭 Do ewentualnego rozszerzenia w przyszłości: formatowanie Enter / minimalne snippety HTML

Jak chcesz, przy **następnej sesji** możemy:
- dorzucić *ładne Enter + indent* w HTML
- albo zrobić **checkpoint „HTML workflow”** jako osobną ściągę

Na teraz: **dobra robota**, krasnoludki ogarnęły temat 💪

📅 04-01-2026 16:16

Status: ✅ zrobione

Hurtowo zmieniono nazwy folderów lekcji z 1,2,3… na lekcja_01, lekcja_02… w javascript i javascript-teoria.


📅 04-01-2026 15:21

Status: ✅ zrobione

- utworzenie pliku README.md we właściwych folderach

PLAN:
- pobranie materiałów do nauki java z internetu
- przekopiowanie pobranych materiałów do właściwych folderów
- zmiana nazw plików stosownie do zawartości

Ryzyko: niskie

Uwagi: nie robić tego w obecności krasnoludków

📅 04-01-2026 14:43

Temat: przygotowanie do nauki java i javascript

Status: ✅ zrobione

Zakres:

- utworzenie katalogu java
- utworzenie folderów w katalogu java
- utworzenie katalogu javascript
- utworzenie folderów w katalogu javascript
- pobranie materiałów do nauki javascript z internetu do folderu Pobrane

PLAN:
- pobranie materiałów do nauki java z internetu
- przekopiowanie pobranych materiałów do właściwych folderów
- utworzenie pliku README.md we właściwych folderach

Ryzyko: niskie

Uwagi: nie robić tego w obecności krasnoludków


📅 04-01-2026 06:02

Temat: kitty — ściąga do zarządzania oknami

Status: ✅ zrobione

Zakres:

uporządkowanie docs/ściągi/kitty.md

zmiana formatu na pytanie → odpowiedź → gotowa komenda

rozbicie skrótów na logiczne sekcje (split, fokus, move, bias)

dodana notatka mentalna pod pracę w zmęczeniu

Efekt:

ściąga czytelna przy niskiej sprawności (2–3)

brak „czytania komentarzy z configa”

gotowe do dalszej optymalizacji pod prawy monitor

Ryzyko: niskie

Uwagi: krasnoludki wykonały robotę, mogą iść w glanach 🥾


## 📅 03-01-2026 23:00

- Zakres: kitty
- Działanie:
  - zmiana układu okien w terminalu kitty na wygodniejszy pod aktualny workflow
  - utworzenie ściągi: docs/ściągi/kitty.md
- Status:
  - zapisane
  - zakomitowane
  - wypchnięte
- Wniosek:
  - pierwszy samodzielnie domknięty cykl: zmiana → dokumentacja → git


03-01-2026 21:22
## CHECKPOINT – uporządkowanie systemu sesji (model + nss)

Co zostało zrobione:
- zdefiniowano dwa typy wpisów:
  - CHECKPOINT – zapis w trakcie pracy
  - ZAMYKANIE – zakończenie pracy
- CHECKPOINT służy jako mapa prowadząca do kodu, nie raport
- rozróżniono przyczyny checkpointu:
  - spadek skupienia („krasnoludki”)
  - przerwa techniczna
- cały plik AKTYWNA.md został ujednolicony semantycznie
  (nagłówki dodane bez zmiany treści)

Decyzje dot. automatu:
- `nss` przestał zapisywać automatyczne wpisy do AKTYWNA.md
- powód: wpisy techniczne nie wnosiły kontekstu i psuły czytelność
- zasada: lepiej brak wpisu niż szum w źródle prawdy

Ustalenia nadrzędne:
- najnowsze wpisy są ZAWSZE na górze
- AKTYWNA.md to narzędzie poznawcze, nie log techniczny
- zapisy sesyjne są robione ręcznie, świadomie

Stan na teraz:
- system spójny
- brak kaszany
- brak automatyki w złym miejscu

Co dalej:
- używać systemu w realnej pracy
- nie poprawiać „na zapas”


03-01-2026  18:30

## ZAMYKANIE – rozwiązanie problemu (Neovim + Nix, wcięcia)

### Problem
Przy otwieraniu plików `.nix` w Neovim:
- wcięcia są „rozjechane”
- komentarze przesuwają się
- problem występuje nawet w `nvim -u NONE`

### Przyczyna
Domyślne ustawienia Neovim:
- `tabstop = 8`
- brak reguł specyficznych dla Nix

Nix **wizualnie wymaga 2 spacji** — inaczej kod wygląda chaotycznie, mimo że jest poprawny.

### Rozwiązanie (minimalne, bezpieczne)
Dodać lokalne ustawienia **tylko dla FileType `nix`** w konfiguracji Neovim (LazyVim):

Plik:
~/.config/nvim/lua/config/autocmds.lua


Kod:
```lua
-- Nix: stabilne wcięcia (2 spacje), bez tabów
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})

Efekt

stabilne wcięcia

komentarze na miejscu

brak „rozjechania” przy samym otwarciu pliku

zero wpływu na inne języki

Zasada bezpieczeństwa

Nie instalować formatterów ani pluginów zanim nie zostaną poprawnie ustawione podstawowe wcięcia.


---

## ✅ Co jeszcze warto (opcjonalnie, nie teraz)
- poprawić w docs **nieaktualną informację**, że NVIM config jest w `/etc/nixos/modules/editors/nvim`
- dodać link do tej notatki z `README.md`

Na teraz:
🔒 **problem zamknięty**
🧠 **wiedza zapisana**
🧭 **kolejna sesja będzie łatwiejsza**

Jeśli chcesz, w następnym kroku możemy:
- poprawić docs (mapa prawdy o nvim),
- albo **zamknąć sesję** i zrobić checkpoint.


03-01-2026 18:20

## ZAMYKANIE – porządkowanie AKTYWNA.md (jedno źródło prawdy)
Status: ✅ zakończone

Cel pracy:

usunąć chaos związany z dwoma plikami AKTYWNA.md

zabezpieczyć workflow pod stan 2–3

jednoznacznie wskazać jedno źródło prawdy

Stan początkowy:

istniały dwa byty:

/etc/nixos/SESJE/AKTYWNA.md (roboczy)

/etc/nixos/docs/AKTYWNA.md (historyczny, mylący)

część narzędzi miała fallback do docs/AKTYWNA.md

Wykonane kroki:

Usunięto fallback do docs/AKTYWNA.md w sesja-start()
→ brak pliku sesji = czytelny błąd, nie „magia”

Commit + switch wykonane przez nss (bezpieczny checkpoint)

Fizycznie usunięto plik:

/etc/nixos/docs/AKTYWNA.md
Commit + push wykonane (repo czyste)

Decyzje architektoniczne:

JEDYNY plik roboczy sesji:

swift
Skopiuj kod
/etc/nixos/SESJE/AKTYWNA.md

docs/ = wyłącznie dokumentacja (brak plików „żywych”)

usuwamy bodźce ryzyka zamiast liczyć na koncentrację

Efekt:

brak możliwości pomyłki przy starcie sesji

jednoznaczna struktura pracy

workflow odporny na przeciążenie poznawcze

Uwagi:

w docs pozostały jedynie nieszkodliwe referencje tekstowe (do sprzątnięcia później)

porządki wykonane etapowo, z checkpointami

Zakończenie: porządki AKTYWNA.md domknięte

03-01-2026 17:10

## ZAMYKANIE – dokumentacja Zellij (manual decyzyjny)

Status: ✅ zakończone

Co zrobiono:

przygotowano i dodano do docs manual decyzyjny Zellij

format: pytanie → odpowiedź → gotowa komenda

opisano: pane, taby, tryby, layouty, sesje, detach/attach

dodano zasadę bezpieczeństwa: najpierw ergonomia, potem automatyzacja w Nix

Decyzje:

brak dalszych działań w tej sesji

brak integracji z Nix / home-manager na tym etapie

Uwagi:

manual gotowy jako baza do przyszłych layoutów i ściąg

kolejny krok (opcjonalny): layout „editor + build + logi”

Zakończenie sesji: świadome („zamykamy”)

------------------------------------------------------------


Data: 03-01-2026 godzina: 15:10

## ZAMYKANIE – Bash jako shell awaryjny (konfiguracja)
Status: ✅ zamknięte

Co zostało zrobione

Uporządkowano ~/.bashrc jako lekki shell zapasowy (debug / kompatybilność).

Ustawiono czytelny prompt (tylko katalog, kolor, bez szumu).

Skonfigurowano historię:

brak duplikatów

histappend

sensowne limity.

Włączono tryb vi w bash (set -o vi) — spójność z nvim i zsh.

Dodano historię po prefiksie (↑ / ↓).

Ustalono bezpieczne ładowanie bash-completion (warunkowe source).

Decyzje architektoniczne

bash-completion instalowany systemowo przez configuration.nix
(powtarzalność, TTY, rescue shell).

Bash traktowany jako:

shell awaryjny

narzędzie testowe

punkt odniesienia (bez dalszego „tuningowania”).

Stan końcowy

Bash: zamknięty, stabilny, nie ruszamy dalej

Główny shell: zsh

Fish: tylko referencyjnie / koncepcyjnie

## 🐚 Bash — przywrócenie do stanu używalnego (wykonane)

Data: 02-01-2026 godzina: 23:05

## CHECKPOINT – Bash przywrócony, dalsze etapy zaplanowane
**Status:** DONE ✅

### Co zostało zrobione
- bash przestał być „śmietnikiem”
- skonfigurowany minimalny `.bashrc` wyłącznie dla trybu interaktywnego
- ustawiony **kolorowy prompt** pokazujący **tylko bieżący katalog**
- usunięto konflikt podwójnego `PS1` (nadpisywanie promptu)
- potwierdzone działanie po `exec bash`

### Aktualny prompt basha
- kolorowy
- format: tylko katalog (`\W`)
- brak user@host (celowo)
- brak wpływu na skrypty i środowiska nieinteraktywne

### Zasady przyjęte w trakcie
- bash ≠ zsh (brak mieszania ról)
- bash bez magii, bez aliasów destrukcyjnych
- bash jako narzędzie:
  - kompatybilności
  - debugowania
  - środowisko referencyjne

---

## CHECKPOINT – plan dalszej pracy (Bash)

**Zasada nadrzędna:**
> Bash = narzędzie kompatybilności i debugowania, nie shell codziennej pracy.

### ETAP A — porządkowanie (bezpieczne)
- [ ] pełny przegląd `~/.bashrc`
- [ ] potwierdzić:
  - jedno `PS1`
  - wszystko tylko dla trybu interaktywnego
- [ ] usunąć/commentować wszystko, co zmienia semantykę

### ETAP B — bash jako narzędzie diagnostyczne
- [ ] porównać:
  - `bash`
  - `bash --norc`
  - `bash --noprofile --norc`
- [ ] ustalić tryb „referencyjny”

### ETAP C — integracja z NixOS / home-manager
- [ ] decyzja: ręczny `.bashrc` vs home-manager
- [ ] jeśli HM → tylko minimalna, łatwa do usunięcia konfiguracja

### ETAP D — dokumentacja
- [ ] dodać zasadę do docs:
  > „Bash służy wyłącznie do kompatybilności i debugowania; codzienna praca odbywa się w zsh.”

**Cel końcowy:**
- bash nudny
- bash przewidywalny
- bash pomocny wtedy, gdy naprawdę potrzebny



Data: 02-01-2026 19:18

## ZAMYKANIE – test kitty (ergonomia terminala)
Status: zamknięta
Kontekst: ergonomia terminala / zmęczenie wzroku

Co zrobiono:

Zainstalowano kitty przez Home Manager

Uruchomiono bez żadnej konfiguracji

Przetestowano domyślny wygląd, czcionkę, splity

Wnioski:

Odczucia: podobnie jak w WezTerm

Domyślny plik konfiguracyjny kitty oceniony jako bardzo pomocny

Brak regresji → brak potrzeby zmian

Decyzja:

Zostawiamy kitty z domyślnym configiem

Temat zamknięty, bez dalszej optymalizacji na ten moment

Uwagi na przyszłość:

Ewentualne zmiany tylko jeśli pojawi się realne zmęczenie wzroku

Dopuszczalna korekta: 1 parametr, bez rozbudowy configu



📅 02-01-2026 12:50

## ZAMYKANIE – ustalenie kierunku nauki (NixOS, worktree)

Kontekst / stan:

System roboczy (NixOS, sesje, Git, bezpieczniki) jest gotowy.

Pojawił się moment „pustki” — brak kolejnych pomysłów nie z braku narzędzi, tylko z zakończenia etapu „budowania systemu”.

Jasno nazwany kierunek nauki:

rozumienie NixOS bez strachu,

czytanie cudzej konfiguracji bez paniki,

pisanie prostych skryptów bez zacięć,

grzebanie w systemie bez ryzyka.

Ustalenie kluczowe:

Do nauki i ćwiczeń używany jest oddzielny worktree: /etc/nixos-wt/test-worktree

→ pełna kopia systemu, zero ryzyka produkcyjnego.

W test-worktree nie celem jest działający build, tylko:

- czytanie,

- komentowanie,

- rozumienie struktury.

Zasada nadrzędna nauki:

- Najpierw uczymy się czytać system, dopiero później go zmieniać.

🎯 Następne kroki nauki (bez pośpiechu)

A) Wybrać 1 najlepszy plik na start

Mały, znany „z widzenia”, ale nie w pełni rozumiany.

Praca polega wyłącznie na czytaniu i komentowaniu, bez zmian logicznych.

B) Mikroszablon komentarzy (zawsze taki sam)
Do każdego analizowanego pliku:

# CO to jest?
# NA CO wpływa?
# JAK to bezpiecznie wyłączyć / pominąć?


C) Wziąć cudzy moduł i „czytać go razem”

Bez presji zrozumienia wszystkiego.

Szukamy punktów zaczepienia: struktura, imports, options, mkIf.

D) Prosty skrypt pomocniczy (tylko jeśli pojawi się realna potrzeba)

Skrypt jako narzędzie pomocnicze do:

sprawdzania,

porównywania,

zabezpieczania.

Bez nauki basha „dla samej nauki”.

Stan końcowy sesji:

Kierunek ustalony.

Brak presji realizacji.

Nauka ma formę krótkich, bezpiecznych wejść (10–20 min).

Następna praca zaczyna się od jednego pliku w test-worktree.


Data 02/01/2026 godzina 00:20

## CHECKPOINT – stan systemu i worktree (bez presji)
Stan systemu:

WezTerm działa

Theme: Gruvbox Dark (test)

Leader + splity + ruch między panelami działają

Repo: jedno

Worktree:

/etc/nixos → recovery-baseline (produkcja)

/etc/nixos-wt/test-worktree → system do nauki i eksperymentów

Git w test-worktree: pełny (commit/log/branch działają)

Ryzyka: brak
Otwarte decyzje: ewentualny bezpiecznik nss w test-worktree (na później)

🧠 PLAN NA NASTĘPNĄ SESJĘ (bez działania teraz)

(Opcjonalnie) Dodać bezpiecznik nss w test-worktree.

(Opcjonalnie) Dokończyć test Gruvbox Dark → decyzja zostaje / zmiana.

(Opcjonalnie) Wyróżnić prompt PROD/TEST.



Data 01.01.2026/ godzina: 21:28

## CHECKPOINT – diagnoza problemów terminala (WezTerm / Zellij / Kitty)

Stan techniczny

WezTerm: główny terminal (decyzja świadoma)

Kitty: do usunięcia (powodował konflikty i przeciążenie poznawcze)

Zellij: tylko okazjonalnie, świadomie

Zsh vi-mode (NOR / INS): działa poprawnie poza zellij

Problem „martwej klawiatury” → zdiagnozowany: tryb klawiszy zellij

Decyzje (ważne)

Rezygnacja z kitty → powrót do stabilnego środowiska

Nie łączymy na co dzień: vi-mode Zsh + multiplexer

Upraszczamy stack zamiast go rozbudowywać

Co zostało zrobione

Zrozumienie przyczyny blokady inputu

Wyjście z zellij (Ctrl+g, Ctrl+q)

Przywrócenie normalnej pracy w WezTerm

Podjęcie decyzji o usunięciu kitty

Co dalej (następna sesja – max 2 punkty)

Usunąć kitty z home/michal.nix i zrobić nixos-rebuild switch

(Opcjonalnie) Uprościć / uporządkować konfigurację WezTerm pod aktualny workflow

🔒 Stan końcowy

System nieuszkodzony, konfiguracja do odzyskania pełnej stabilności jednym rebuildem.
Decyzje podjęte na chłodno, nie pod presją błędu.

🕒 Data: 2026-01-01 00:42

## CHECKPOINT – wdrożenie git worktree (działa, do dalszego użycia)

**Stan repo:**
- Katalog bazowy: `/etc/nixos`
- Aktywny branch: `recovery-baseline`
- Repo czyste, zsynchronizowane z `origin/recovery-baseline`

**Wykonane kroki:**
- Utworzono katalog na worktree: `/etc/nixos-wt`
  - właściciel: `michal:users`
- Utworzono pierwszy worktree:
  - katalog: `/etc/nixos-wt/test-worktree`
  - branch: `test-worktree`
  - branch startuje z aktualnego `recovery-baseline`
- Potwierdzono poprawne działanie `git worktree`:
  - `/etc/nixos` jest przypięte do branch `recovery-baseline`
  - `/etc/nixos-wt/test-worktree` jest przypięte do branch `test-worktree`
  - oba katalogi mają niezależne drzewa robocze
  - historia repo jest wspólna

**Wyjaśnienia i ustalenia:**
- Zasada mentalna: **katalog = branch**
- W `git branch`:
  - `*` oznacza aktywny branch w danym katalogu
  - `+` oznacza branch używany w innym worktree (zablokowany do checkoutu)
- Nie przełączamy branchy przez `git checkout` — zmiana kontekstu = `cd` do katalogu

**Zasady bezpieczeństwa (ważne):**
- LazyGit traktowany wyłącznie jako narzędzie podglądowe (historia / diff / porównania)
- Normalna praca (commit, rebase, push) tylko przez CLI
- Nowa zasada komunikacji i pracy przy stanie 2–3:
  - zawsze jawnie podawać kontekst w formacie:
    ```
    /pełna/ścieżka/katalogu
    ❯ polecenie
    ```
  - brak domyślania się, w jakim katalogu jesteśmy

**Wnioski:**
- Worktree daje fizyczne rozdzielenie kontekstów pracy
- Baza (`/etc/nixos`) pozostaje czysta i bezpieczna
- Znacznie zmniejszone ryzyko błędów kontekstowych

**Co dalej (następna sesja):**
- Jedno krótkie ćwiczenie praktyczne:
  - zmiana pliku w worktree
  - potwierdzenie, że baza (`/etc/nixos`) pozostaje czysta
- Ustalenie reguły: kiedy zakładać nowy worktree (czas / typ zadania)

## 📅 2025-12-31

## ZAMYKANIE – porządkowanie nss / nbuild

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

## 📅 2025-12-30

## ZAMYKANIE – test nowego systemu SESJE

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

## 📅 2025-12-29

## ZAMYKANIE – rollback systemu NixOS (powrót do stabilności)

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

## 📅 2025-12-29

## ZAMYKANIE – dokumentacja NixOS (standardy i mapa)
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

## 📅 2026-01-01 00:16

- Mode: commit
- Risk: NORMAL
- Changes:
SESJE/AKTYWNA.md

## 📅 2026-01-01 23:19

- Mode: commit
- Risk: NORMAL
- Changes:
SESJE/AKTYWNA.md

## 📅 2026-01-01 23:51

- Mode: commit
- Risk: NORMAL
- Changes:
SESJE/AKTYWNA.md

## 📅 2026-01-03 15:08

- Mode: commit
- Risk: NORMAL
- Changes:
SESJE/AKTYWNA.md

## 📅 2026-01-03 17:52

- Mode: commit
- Risk: NORMAL
- Changes:
SESJE/AKTYWNA.md
````
