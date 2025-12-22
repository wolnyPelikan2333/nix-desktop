# flake check / build / switch — którą komendę wybrać?

Ta ściąga odpowiada na jedno pytanie:
**co uruchomić w danym momencie i DLACZEGO**.

---

## ❓ Czy ta konfiguracja w ogóle ma sens? (NIC nie zmieniaj)

### Użyj:
`nix flake check`

### Co robi:
- sprawdza składnię i evaluację
- wykrywa błędy logiczne w `.nix`
- **NIC nie buduje**
- **NIC nie zmienia w systemie**

### Pełna komenda:
```bash
nix flake check /etc/nixos
Kiedy:

podczas pisania z watch-nix zawsze jako pierwszy krok

❓ Czy ten system DA SIĘ ZBUDOWAĆ? (bez aktywacji)
Użyj:

nixos-rebuild build

Co robi:

- bashbuduje cały system

- tworzy wynik w /nix/store

- NIE aktywuje

- NIE zmienia bootu

- NIE restartuje usług

Pełna komenda:
sudo nixos-rebuild build --flake /etc/nixos#desktop

Kiedy:

- po większych zmianach

- gdy boisz się switch

- jako „suchy bieg”

❓ Chcę, żeby to było MOIM systemem (realna zmiana)
Użyj:

nixos-rebuild switch

Co robi:

- buduje system

- AKTYWUJE konfigurację

- restartuje usługi

- zapisuje nową generację

- wpływa na boot

Pełna komenda:
sudo nixos-rebuild switch --flake /etc/nixos#desktop

U mnie standardowo przez:

ns "commit message"

🧭 Najprostsza mapa decyzyjna
piszę → flake check
↓
jest OK → (opcjonalnie) build
↓
jest OK → switch

flake check → sprawdzam
build       → upewniam się
switch      → zatwierdzam


