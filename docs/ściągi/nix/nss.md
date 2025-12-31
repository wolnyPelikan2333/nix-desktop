# 🧭 NSS — ściąga decyzyjna

> **Cel:** bezpieczny workflow `nss` (build / switch / commit) w NixOS z flakes.
> **Zasada:** zawsze wiesz *co* robisz, *dlaczego* i *z jakim ryzykiem*.

---

## ❓ Co chcesz zrobić?

### A) **Tylko sprawdzić, czy konfiguracja się buduje**

* **Użyj:** `nss --dry`
* **Efekt:** brak zmian w systemie
* **Kiedy:** przed każdym realnym switchem

**Decyzja:**

* ✔ Build OK → możesz iść dalej
* ❌ Błąd → naprawiasz, bez ryzyka

---

### B) **Zbudować i przełączyć system (bez commita)**

* **Użyj:** `nss` → wybierz **B (build + switch)**
* **Efekt:** nowa generacja systemu
* **Kiedy:** test zmian lokalnie

**Ryzyko:** średnie

**Po fakcie:**

* system działa → commit później
* system nie działa → rollback

---

### C) **Zbudować, przełączyć i zapisać w Git**

* **Użyj:** `nss` → wybierz **C (build + switch + commit)**
* **Efekt:** zmiana w systemie + commit
* **Kiedy:** zmiana sprawdzona i pewna

**Ryzyko:** niskie (jeśli dry-run był OK)

---

### D) **Przerwać bez zmian**

* **Użyj:** wybierz **D** lub wpisz `zamykamy`
* **Efekt:** zero akcji
* **Kiedy:** zmęczenie / niepewność

---

## 🛡 Bramka decyzyjna (Decision Gate)

Podczas `nss` zobaczysz ocenę ryzyka:

* **LOW** – drobne zmiany, bezpieczne
* **NORMAL** – standardowy switch
* **HIGH** – uważaj, rozważ abort

**Zasada:**

> Przy HIGH → **abort** albo tylko **build**

---

## 🔁 Co jeśli coś pójdzie nie tak?

### System nie wstaje / coś się zepsuło

1. Wejdź w poprzednią generację z bootloadera
2. Zaloguj się
3. Sprawdź:

   ```bash
   sys-list
   ```
4. Rollback:

   ```bash
   sudo nixos-rebuild switch --rollback
   ```

---

## 📦 Typowe scenariusze

### 🔧 Mała zmiana (alias, docs, komentarz)

* `nss --dry`
* `nss` → **C**

### 🧪 Nowy moduł / większa refaktoryzacja

* `nss --dry`
* `nss` → **B**
* test
* dopiero potem commit

### 😵 Zmęczenie / brak pewności

* `nss --dry`
* **D / zamykamy**

---

## 🧠 Złote zasady

* ❌ Nie rób `switch` bez `--dry`
* ❌ Nie commituj rzeczy nieprzetestowanych
* ✅ Każda sesja = świadoma decyzja
* ✅ W razie wątpliwości: **abort**

---

## 📌 Powiązane

* `docs/ściągi/nix/flake-workflow.md`
* `docs/ściągi/nix/emergency.md`
* `docs/AKTYWNA.md`

