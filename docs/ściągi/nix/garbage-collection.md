# Garbage Collection w NixOS — ściąga

Krótka ściąga do bezpiecznego sprzątania magazynu `/nix/store`
bez psucia systemu i bez utraty możliwości rollbacku.

---

## Co to jest Garbage Collection

- Nix **nigdy sam nie usuwa** pakietów z `/nix/store`
- Usuwane są tylko **nieużywane ścieżki**, do których nie prowadzą żadne „rooty”
- Rootami są m.in.:
  - generacje systemu
  - generacje home-manager
  - profile użytkowników
  - ręczne piny

---

## Najbezpieczniejszy wariant (rekomendowany)

### 1️⃣ Sprawdź, co zostanie usunięte (dry-run)
```bash
sudo nix-collect-garbage --dry-run

2️⃣ Usuń stare generacje systemu
sudo nix-collect-garbage -d


usuwa stare generacje

zostawia aktualną

rollback nadal działa

3️⃣ (Opcjonalnie) Optymalizacja magazynu
sudo nix store optimise


deduplikacja plików

bezpieczne

może zwolnić kilka GB


Home-Manager
Sprawdzenie generacji
home-manager generations

Usunięcie starych
home-manager expire-generations "-30 days"

Ile miejsca zajmuje /nix/store
du -sh /nix/store

Lista największych ścieżek:

nix path-info -Sh /run/current-system

Minimalny bezpieczny workflow
sudo nix-collect-garbage --dry-run
sudo nix-collect-garbage -d
sudo nix store optimise

Złota zasada

Nigdy nie sprzątaj /nix/store, jeśli nie masz działającego systemu i commita w repo.
