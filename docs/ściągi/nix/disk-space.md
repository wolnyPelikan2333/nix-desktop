# 💽 Disk space – co robić, gdy `/nix` puchnie

Ta ściąga opisuje **bezpieczne kroki**, gdy kończy się miejsce na dysku w NixOS.
Bez paniki i bez kasowania „na ślepo”.

Cel:

* szybko odzyskać miejsce,
* **nie uszkodzić systemu**,
* wiedzieć, kiedy **STOP**.

---

## Mentalny model

* `/nix/store` rośnie, bo **Nix nigdy nie nadpisuje**
* stare generacje = **bezpieczny bufor**
* najpierw **sprawdź**, potem **czyść**

---

## 1️⃣ Sprawdź, ile miejsca zostało

```bash
df -h /
```

Jeśli `< 5–10%` wolnego → działaj.

---

## 2️⃣ Sprawdź, co trzyma miejsce

### Generacje systemu

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### Generacje użytkownika / home-manager

```bash
nix-env --list-generations
```

---

## 3️⃣ Bezpieczne czyszczenie (standard)

### Usuń stare generacje

```bash
sudo nix-collect-garbage -d
```

* usuwa **nieużywane** generacje
* **nie dotyka** aktualnego systemu

---

### Optymalizacja store (opcjonalnie)

```bash
sudo nix store optimise
```

* usuwa duplikaty
* bezpieczne, ale nie zawsze dużo zysku

---

## 4️⃣ Szybki ratunek (mało miejsca TERAZ)

```bash
sudo nix-collect-garbage --delete-older-than 7d
```

⚠️ Zostawia tylko ostatnie 7 dni — **używaj świadomie**.

---

## 5️⃣ Sprawdź efekt

```bash
df -h /
```

Jeśli nadal mało miejsca → STOP i analiza.

---

## 6️⃣ Czego NIE robić

❌ `rm -rf /nix/store/*`
❌ ręczne kasowanie plików w `/nix/store`
❌ czyszczenie bez działającej generacji

---

## 7️⃣ Profilaktyka

* regularny garbage collection (np. raz na tydzień)
* nie trzymaj setek generacji „na zapas”
* commit + rollback zamiast strachu przed czyszczeniem

---

## 🧷 ABSOLUTNE MINIMUM

Zapamiętaj tylko to:

```bash
df -h /
sudo nix-collect-garbage -d
sudo nix store optimise
```

---

✅ To wystarczy, żeby **opanować puchnący `/nix` bez ryzyka**.

