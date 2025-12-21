# Zasady projektu / SSOC

## 1. Single Source of Configuration (SSOC)
- Każda kategoria ma **jedno źródło prawdy**
- Duplikaty są traktowane jako **błąd architektury**

### Przykłady
- NVIM config → `/etc/nixos/modules/editors/nvim`
- Aliasy ZSH → `/etc/nixos/modules/my-aliases.nix`
- Binarki → system (`modules/packages.nix`)
- Home-Manager → tylko „klej”, nie logika

---

## 2. Neovim
- Binarka `nvim` instalowana **tylko systemowo**
- Konfiguracja NVIM:
  - SSOC: `/etc/nixos/modules/editors/nvim`
  - Podpinana przez Home-Manager (symlink)
- Brak duplikatów `programs.neovim`

---

## 3. ZSH / Aliasy
- Wszystkie aliasy:
  - **tylko** `modules/my-aliases.nix`
- `zsh.nix`:
  - brak aliasów
  - tylko enable, prompt, completion, opcje
- Konflikt aliasów = błąd konfiguracji

---

## 4. Sudo / Edycja plików
- `/etc/nixos/**`:
  - `sudo -E nvim` (alias: `sen`)
- Prawdziwe `/etc/**`:
  - `sudoedit`
- `EDITOR` / `VISUAL`:
  - ustawiane w Home-Manager (`home.sessionVariables`)

---

## 5. Workflow zmian
- Zmiany świadome → `ns "opis"`
- Debug / eksperyment → `nixos-rebuild`
- Każdy etap kończy się checkpointem (git + push)

---

## 6. Zasada nadrzędna
> Prostota > ilość funkcji  
> Jeśli czegoś nie używam — **nie istnieje**

