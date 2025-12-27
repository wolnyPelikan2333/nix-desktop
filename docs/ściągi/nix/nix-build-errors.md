# 🧠 Jak czytać błędy `nix build` / `nixos-rebuild` (5 kroków)

Ta ściąga jest po to, żeby **nie panikować** i **nie zgadywać**.

---

## 1️⃣ Szukaj pierwszego słowa `error:`

Ignoruj wszystko powyżej.

Interesuje Cię pierwszy blok zaczynający się od:

error:


To jest **jedyna przyczyna**, reszta to kontekst.

---

## 2️⃣ Znajdź plik + linię (`at … :line:col`)

Przykład:

syntax error, unexpected ':'
at /etc/nixos/modules/zsh.nix:60:3


To znaczy:
- **plik:** `/etc/nixos/modules/zsh.nix`
- **linia:** 60
- **kolumna:** 3

👉 Otwórz TEN plik, NIE inny.

---

## 3️⃣ Jeśli jest „syntax error” → sprawdzaj granice bloków

Najczęstsze winy:
- niedomknięte `''` (heredoc w HM)
- nadmiarowy znak (`:`, `{`, `}`, `;`)
- linia w złym miejscu (poza blokiem)

Parser krzyczy **tam, gdzie się zgubił**, nie zawsze tam, gdzie błąd powstał.

---

## 4️⃣ Ostrzeżenia (`warning:`) NIE blokują buildu

Przykład:

warning: Git tree '/etc/nixos' is dirty


To **informacja**, nie przyczyna awarii.

👉 Naprawiaj dopiero po działającym buildzie.

---

## 5️⃣ Logi gita czytaj osobno

Przykład:

create mode 100644 "\"


To znaczy:
- git dodał **nowy plik**
- nazwa pliku to dokładnie: `\`

Nie jest to błąd nix — tylko **artefakt edycji**.

👉 Sprawdź repo: `ls -la`

---

## Złota zasada

> **Nix zawsze mówi prawdę, tylko bardzo dosłownie.**  
> Nie zgaduj. Czytaj dokładnie JEDNĄ linię, którą wskazuje.

---

## 🔁 Workflow: bezpieczna praca z NixOS (mini-diagram)

edit
↓
nixos-rebuild build (suchy build)
↓
czy build OK?
├─ TAK → nss (build + switch + snapshot)
│
└─ NIE → nixe
↓
czytanie błędu + ściąga
↓
poprawka
↓
nixos-rebuild build
↓
(wróć do decyzji)

yaml
Skopiuj kod

---

### Zasady użycia

- **Zawsze zaczynaj od suchego builda**
- **Nie rób `nss`, jeśli parser krzyczy**
- `nixe` uruchamiaj:
  - gdy błąd nie jest oczywisty
  - gdy chcesz zachować log
  - gdy potrzebujesz checklisty „co czytać”

---

### Złota reguła

> **Build ma być nudny.  
> Jeśli nie jest — wracasz o krok wyżej.**
