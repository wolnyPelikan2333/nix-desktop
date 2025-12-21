# 🧠 Git ↔ NixOS ↔ Rollback — ściąga mentalna

> **Cel:** szybkie, spokojne ogarnięcie co za co odpowiada, bez paniki i bez ryzyka.

---

## 1️⃣ Git — do czego JEST, a do czego NIE

### Git = **źródło konfiguracji** (plan)

Przechowuje:

* `flake.nix`, `flake.lock`
* `nixos/configuration.nix`
* moduły (`modules/*.nix`)
* home-manager

**Git NIE przechowuje:**

* `/nix/store`
* generacji systemu
* stanu aktualnie uruchomionego systemu

> Git opisuje **JAK system ma być zbudowany**, a nie **JAKI jest teraz**.

---

## 2️⃣ NixOS — jak naprawdę powstaje system

Schemat:

```
pliki .nix (Git)
        ↓
  nixos-rebuild
        ↓
   /nix/store
        ↓
   generacja
        ↓
   uruchomiony system
```

* Każdy `nixos-rebuild switch` → **NOWA generacja**
* Stare generacje **zostają**, dopóki ich nie usuniesz

---

## 3️⃣ Rollback — dlaczego jest bezpieczny

### 🔁 Rollback **NIE używa Gita**

Rollback korzysta z:

* zapisanych generacji
* profilu systemowego
* bootloadera

Dlatego:

* ❌ uszkodzony Git ≠ uszkodzony system
* ❌ brak `/etc/nixos` ≠ brak rollbacku

> Rollback = cofnięcie **czasu systemu**, nie historii repo.

---

## 4️⃣ Reinstalacja systemu — jak to się składa w całość

Schemat reinstalacji:

```
GitHub repo
    ↓
klon do /etc/nixos
    ↓
nixos-rebuild switch --flake
    ↓
NOWY system
```

Możesz wybrać:

* `master`
* `recovery-baseline`
* tag `golden-*`

> **Historia Gita nie ma znaczenia** — liczy się treść plików.

---

## 5️⃣ Force push vs recovery branch (najważniejsze!)

### 🔥 Force push (`--force-with-lease`)

* zastępuje historię `master` na GitHubie
* ryzykowny przy zmęczeniu
* sensowny **tylko świadomie**

### 🛡️ Recovery branch (`recovery-baseline`)

* zapisuje aktualny stan jako nową gałąź
* **NICZEGO nie niszczy**
* idealny jako checkpoint bezpieczeństwa

---

## 6️⃣ Złote zasady (zapamiętaj)

* ✅ commit + push **PRZED** `nixos-rebuild`
* ❌ nie force-push, gdy jesteś zmęczony
* 🛡️ recovery-branch, gdy masz wątpliwości
* 🧠 rollback to Twoja siatka bezpieczeństwa

---

## 7️⃣ Minimalny workflow (bezpieczny)

```
zmiana w .nix
   ↓
git commit
   ↓
git push
   ↓
nixos-rebuild
```

---

## 8️⃣ Jedno zdanie na koniec

> **Git wpływa na przyszłe buildy.**
> **Rollback ratuje przeszłe buildy.**
> **Nigdy się nie gryzą.**

---

📌 Ta ściąga powstała po realnym recovery — to nie teoria, tylko praktyka.

