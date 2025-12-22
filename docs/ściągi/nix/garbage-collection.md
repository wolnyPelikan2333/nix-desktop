# Garbage Collection w NixOS — ściąga

Krótka ściąga do **bezpiecznego sprzątania** `/nix/store`
bez psucia systemu i bez utraty możliwości rollbacku.

---

## Co to jest Garbage Collection

- Nix **nigdy sam nie usuwa** danych z `/nix/store`
- Usuwane są tylko ścieżki, do których **nie prowadzą żadne rooty**
- Rootami są m.in.:
  - generacje systemu
  - generacje Home Managera
  - profile użytkowników
  - ręczne piny

---

## Najbezpieczniejszy wariant (rekomendowany)

### 1️⃣ Sprawdź, co zostanie usunięte (dry-run)
```bash
sudo nix-collect-garbage --dry-run

Usuń stare generacje systemu
sudo nix-collect-garbage -d


usuwa stare generacje

zostawia aktualnie uruchomioną

rollback nadal działa

Opcjonalnie) Optymalizacja magazynu
sudo nix store optimise


deduplikacja plików

bezpieczne

może zwolnić kilka GB

Home Manager
Lista generacji
home-manager generations

Usunięcie starych (np. starsze niż 30 dni)
home-manager expire-generations "-30 days"

Home Manager
Lista generacji
home-manager generations

Usunięcie starych (np. starsze niż 30 dni)
home-manager expire-generations "-30 days"

Minimalny bezpieczny workflow
sudo nix-collect-garbage --dry-run
sudo nix-collect-garbage -d
sudo nix store optimise

Złota zasada

Nigdy nie sprzątaj /nix/store, jeśli:

system nie jest stabilny

nie masz działającego rollbacku

nie masz commita w repo /etc/nixos


---

## ✅ Następny krok (zamknięcie zadania 3/3)

```bash
git add /etc/nixos/docs/ściągi/nix/garbage-collection.md
ns "docs: polish nix garbage collection cheatsheet"


✔ czysto
✔ spójnie
✔ gotowe
