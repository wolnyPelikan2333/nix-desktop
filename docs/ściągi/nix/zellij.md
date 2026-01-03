# Zellij — manual decyzyjny (NixOS / terminal)

> **Cel:** szybka, bezpieczna praca w terminalu bez gubienia kontekstu.
> Format: **pytanie → odpowiedź → gotowa komenda / skrót**.

---

## Co to jest Zellij?

**Zellij** to terminalowy multiplexer (jak tmux), ale z:

* gotowymi **layoutami**,
* **pane + tab** out of the box,
* czytelnymi skrótami,
* sensowną obsługą myszy i trybów.

Używasz go zamiast (albo obok) tmux/screen.

---

## Jak uruchomić Zellij?

**Pytanie:** Chcę wejść do sesji Zellij.

**Odpowiedź:**

```bash
zellij
```

Jeśli sesja już istnieje — zostaniesz do niej dołączony.

---

## Jak wyjść z Zellij bez zabijania sesji?

**Pytanie:** Chcę wyjść, ale zostawić sesję.

**Odpowiedź:**

* `Ctrl + o`, potem `d`  → **detach**

Sesja dalej żyje w tle.

---

## Jak zabić sesję Zellij?

**Pytanie:** Chcę zamknąć wszystko.

**Odpowiedź:**

```bash
exit
```

(z każdego pane, aż sesja się zamknie)

---

## Podstawowe pojęcia

* **Pane** — podzielony obszar (jak split w WezTerm)
* **Tab** — zestaw pane (jak workspace)
* **Mode** — tryb klawiszy (normal / pane / tab / resize)

Zellij jest **modalny** — skróty zależą od trybu.

---

## Klawisz bazowy (prefix)

W Zellij **nie ma jednego twardego prefixu** jak `Ctrl-b` w tmux.

Najczęściej używany:

* `Ctrl + o` — wejście do trybu poleceń

---

## Pane — podział ekranu

### Nowy pane

* `Ctrl + o` → `n`  — nowy pane (domyślnie poziomo)

### Podział pionowy / poziomy

* `Ctrl + o` → `v` — split pionowy
* `Ctrl + o` → `h` — split poziomy

### Zamknięcie pane

* `Ctrl + o` → `x`

---

## Przełączanie pane

* `Alt + ← ↑ → ↓`

(bez wchodzenia w tryby — bardzo ważne ergonomicznie)

---

## Zmiana rozmiaru pane

* `Ctrl + o` → `r`  (resize mode)
* potem `← ↑ → ↓`
* `Esc` — wyjście z trybu

---

## Tab — zakładki

### Nowa zakładka

* `Ctrl + o` → `t`

### Przełączanie tabów

* `Alt + ← / →`

### Zamknięcie tab

* `Ctrl + o` → `w`

---

## Layouty (killer feature)

**Pytanie:** Chcę gotowy układ (np. editor + terminal + logi).

**Odpowiedź:**

```bash
zellij --layout default
```

Albo własny layout (YAML):

```bash
zellij --layout moja-praca
```

Layouty trzymasz w:

```text
~/.config/zellij/layouts/
```

---

## Sesje

### Lista sesji

```bash
zellij list-sessions
```

### Dołączanie

```bash
zellij attach <nazwa>
```

### Nowa nazwana sesja

```bash
zellij -s robota
```

---

## Tryb kopiowania (scroll)

* `Ctrl + o` → `s`
* strzałki / PgUp / PgDn
* zaznaczanie myszą działa

---

## Integracja z Neovim

Zellij **nie przeszkadza** trybowi vim.
Rekomendacja:

* nawigacja pane: `Alt + hjkl`
* vim zostaje w `Ctrl-w`

---

## Kiedy Zellij ma sens?

✅ Długie sesje pracy
✅ Wiele kontekstów (build / log / edycja)
✅ Praca SSH

❌ Szybkie jednorazowe komendy
❌ Jeśli WezTerm split wystarcza

---

## Minimalna konfiguracja (bezpieczna)

Plik:

```text
~/.config/zellij/config.kdl
```

Zasada:

> **najpierw stock Zellij, potem dopiero tuning**

---

## Zasada bezpieczeństwa

⚠️ **Nie automatyzuj Zellij w NixOS dopóki:**

* nie używasz go codziennie
* nie masz 2–3 sprawdzonych layoutów

Najpierw ergonomia, potem deklaratywność.

---

## Status

📌 Manual gotowy do użycia
📌 Bezpieczny
📌 Decyzyjny

Następny krok (opcjonalny):

* layout „editor + build + logi"
* alias `zj` / `zja`

