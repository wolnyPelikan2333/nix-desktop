# 🛡️ Git – Safe Workflow (bezpieczna praca)

Ten plik opisuje **najprostszy i najbezpieczniejszy workflow Git**, którego używamy przy pracy z konfiguracją systemu (np. `/etc/nixos`).

Cel:

* nigdy nie stracić działającej konfiguracji,
* zawsze wiedzieć **co** i **kiedy** zostało zmienione,
* mieć możliwość **szybkiego powrotu** do stabilnego stanu.

---

## Zasady podstawowe

1. **Jedna logiczna zmiana = jeden commit**
2. **Commitujemy często**, nawet małe kroki
3. **Commit message musi mówić CO i DLACZEGO**, nie tylko „update”
4. **Zanim zbudujesz system – sprawdź status repo**
5. Repozytorium traktujemy jak **dziennik pokładowy**

---

## Minimalny cykl pracy

### 1️⃣ Sprawdź status

```bash
git status
```

* `clean` → OK, możemy działać
* `dirty` → wiesz, że są lokalne zmiany

---

### 2️⃣ Edytuj pliki

* edytujemy **świadomie**
* najlepiej **jeden temat naraz** (np. jeden moduł, jeden plik)

---

### 3️⃣ Sprawdź różnice

```bash
git diff
```

Zadaj sobie pytania:

* czy rozumiem każdą linijkę?
* czy to jest dokładnie to, co chciałem zmienić?

Jeśli **nie** → popraw zanim pójdziesz dalej.

---

### 4️⃣ Dodaj zmiany

```bash
git add <plik>
```

Lub świadomie wszystko:

```bash
git add .
```

---

### 5️⃣ Commit (checkpoint)

```bash
git commit -m "krótki, opisowy komunikat"
```

Dobre przykłady:

* `enable wezterm module`
* `add rollback cheat sheet`
* `refactor zsh aliases – no behavior change`

Złe przykłady:

* `update`
* `fix`
* `changes`

---

### 6️⃣ (Opcjonalnie) Build / test

Dopiero **po commicie**:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

Dlaczego?

* commit = **punkt powrotu**
* build może się nie udać, ale repo jest bezpieczne

---

### 7️⃣ Push (backup zdalny)

```bash
git push
```

Zasada:

* **push przynajmniej raz dziennie**
* po większym checkpointcie – od razu

---

## Złota zasada

> **Jeśli boisz się commita – to znak, że powinien być mniejszy, a nie że nie powinno go być.**

---

## Typowe scenariusze ratunkowe

### 🔙 Cofnięcie się do ostatniego commita

```bash
git restore .
```

⚠️ Usuwa **niezapisane** zmiany lokalne.

---

### 🔎 Sprawdzenie historii

```bash
git log --oneline --decorate --graph
```

---

### 🧪 Eksperyment

* zrób commit: `experiment: X`
* testuj
* jeśli nie wyszło → **git reset / rollback w NixOS**

Eksperyment bez commita = brak siatki bezpieczeństwa.

---

## Mentalny model

* Git ≠ przeszkoda
* Git = **ubezpieczenie**
* Każdy commit to **checkpoint w grze** 🎮

---

## Minimum, którego pilnujemy

* `git status` przed buildem
* commit **zanim** coś może się zepsuć
* push zanim zamkniesz dzień

---

✅ Jeśli trzymasz się tego pliku – **trudno zrobić sobie krzywdę**.

