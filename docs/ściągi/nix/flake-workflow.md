# ❄️ Nix Flakes – Safe Workflow

Ten dokument opisuje **bezpieczny, powtarzalny workflow pracy z Nix Flakes** w `/etc/nixos`.

Cel:

* mieć **zawsze działającą bazę** (golden build),
* aktualizować flakes **świadomie**,
* łatwo wracać do poprzedniego stanu.

---

## Zasady ogólne

1. **Flake to źródło prawdy** – nie budujemy „na dziko”
2. **Zmiany w lockfile są jawne** (zawsze commit)
3. **Najpierw commit → potem build**
4. Jeden commit = jeden krok logiczny

---

## Struktura (mentalny model)

* `flake.nix` → **co** budujemy (wejścia, wyjścia, moduły)
* `flake.lock` → **dokładnie z czego** (konkretne wersje)

> `flake.lock` to **zamrożony stan świata** – traktuj jak artefakt binarny.

---

## Minimalny cykl pracy

### 1️⃣ Sprawdź repo

```bash
git status
```

* `clean` → bezpiecznie
* `dirty` → wiesz, co zmieniasz

---

### 2️⃣ Zmiana konfiguracji (bez aktualizacji)

* edytuj moduły (`configuration.nix`, `home/*.nix`, `modules/*.nix`)
* **nie dotykaj** `flake.lock`

```bash
git diff
```

➡️ Jeśli zmiana jest OK:

```bash
git add <pliki>
git commit -m "config: opis zmiany"
```

---

### 3️⃣ Build/test

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

* sukces → jedziesz dalej
* fail → masz commit, możesz się cofnąć

---

## Aktualizacja flake inputs (kontrolowana)

### 4️⃣ Update (świadomie)

```bash
nix flake update
```

Zmienia się **TYLKO** `flake.lock`.

```bash
git diff flake.lock
```

Zadaj sobie pytania:

* co się zaktualizowało?
* czy to był planowany moment?

---

### 5️⃣ Commit lockfile

```bash
git add flake.lock
git commit -m "flake: update inputs"
```

> Nigdy nie mieszaj: zmiany konfiguracji + update flake w jednym commicie.

---

### 6️⃣ Build po update

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

* OK → push
* FAIL → rollback (Git lub NixOS)

---

## Golden build (bezpieczna baza)

Definicja:

* system się buduje
* reboot OK
* podstawowe narzędzia działają

Zasada:

* **każdy golden build = commit + push**

Prosty tag (opcjonalnie):

```bash
git tag golden-$(date +%Y-%m-%d)
git push --tags
```

---

## Czego NIE robić

❌ `nix flake update` bez commita
❌ build na brudnym repo bez świadomości
❌ duże zmiany bez checkpointów

---

## Ratunek

### 🔙 Cofnięcie update flake

```bash
git checkout -- flake.lock
```

### 🔙 Powrót do wcześniejszego stanu

```bash
git log --oneline
git checkout <commit>
```

---

## Minimum bezpieczeństwa

* commit **przed** buildem
* osobny commit dla `flake.lock`
* push po stabilnym stanie

---

✅ Trzymając się tego workflow, **flakes przestają być ryzykowne**.

