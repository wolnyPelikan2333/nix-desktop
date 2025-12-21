# 🔙 NixOS – Rollback (ściąga ratunkowa)

Ta ściąga opisuje **jak bezpiecznie cofnąć się do działającego stanu** w NixOS.
Traktuj ją jak **procedurę ratunkową**, a nie coś do codziennego klikania.

Cel:

* nie panikować,
* wiedzieć *dokładnie co zrobić*,
* zawsze wrócić do działającego systemu.

---

## Mentalny model

* **Git** cofa *konfigurację*
* **NixOS** cofa *zbudowany system*

Najbezpieczniej:

> **Git → rebuild → reboot (jeśli trzeba)**

---

## Rollback najszybszy (GRUB)

### 🔹 Gdy system się NIE uruchamia poprawnie

1. Uruchom komputer
2. W GRUB wybierz:
   **„NixOS – previous generation”**
3. Zaloguj się

To:

* **nie zmienia plików** w `/etc/nixos`
* uruchamia poprzedni, działający system

---

## Rollback systemu (działający shell)

### 🔹 Sprawdzenie generacji

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

---

### 🔹 Cofnięcie do poprzedniej generacji

```bash
sudo nix-env --rollback --profile /nix/var/nix/profiles/system
sudo reboot
```

---

## Rollback konfiguracji (Git)

### 🔹 Porzuć lokalne zmiany

```bash
git restore .
```

⚠️ Usuwa **niezacommitowane** zmiany.

---

### 🔹 Powrót do konkretnego commita

```bash
git log --oneline
git checkout <commit>
```

Następnie:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

---

## Rollback po `flake update`

### 🔹 Cofnięcie tylko lockfile

```bash
git checkout -- flake.lock
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

---

## Scenariusze ratunkowe

### ❌ Build się nie udał

* nic nie cofaj
* popraw konfigurację
* albo wróć Git-em

---

### ❌ System się buduje, ale coś jest popsute

```bash
sudo nixos-rebuild switch --rollback
```

---

### ❌ System nie wstaje po reboocie

* GRUB → previous generation
* po starcie:

```bash
git status
git log --oneline
```

---

## Złote zasady bezpieczeństwa

* **commit przed rebuildem**
* osobny commit dla `flake.lock`
* nigdy nie usuwaj generacji „bo stare”

---

## Minimum do zapamiętania

```bash
GRUB → previous generation
git restore .
sudo nixos-rebuild switch --rollback
```

---

✅ Jeśli znasz te trzy ruchy — **trudno się naprawdę wyłożyć**.

