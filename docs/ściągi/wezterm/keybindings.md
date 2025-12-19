# WezTerm — skróty klawiszowe (tmux-style)

Leader: **Ctrl + A**  
Konfiguracja zarządzana przez **NixOS**

Źródło:
- `/etc/nixos/modules/wezterm.nix`
- generuje `~/.config/wezterm/wezterm.lua`

---

## ⌨️ PANELE (splity)

| Skrót | Akcja |
|------|------|
| `Ctrl+A d` | split poziomy (w dół) |
| `Ctrl+A s` | split pionowy (w bok) |
| `Ctrl+A h` | przejdź do panelu w lewo |
| `Ctrl+A j` | przejdź do panelu w dół |
| `Ctrl+A k` | przejdź do panelu w górę |
| `Ctrl+A l` | przejdź do panelu w prawo |
| `Ctrl+A x` | zamknij panel |
| `Ctrl+A Space` | zoom / unzoom panelu |

---

## 🗂 KARTY (tabs)

### Tworzenie / zamykanie

| Skrót | Akcja |
|------|------|
| `Ctrl+A c` | nowa karta |
| `Ctrl+A &` | zamknij kartę |

---

### Przełączanie kart

| Skrót | Akcja |
|------|------|
| `Ctrl+A 1..9` | przejdź do karty |
| `Ctrl+A p` | poprzednia karta |
| `Ctrl+A n` | następna karta |

---

### Nazwa karty

| Skrót | Akcja |
|------|------|
| `Ctrl+A ,` | zmień nazwę karty |

---

## 🔍 Diagnostyka

| Skrót | Akcja |
|------|------|
| `Ctrl+Shift+L` | pokaż logi WezTerm |

Jeśli skróty nie działają:
1. `sudo nixos-rebuild switch`
2. zamknij **wszystkie** okna WezTerm
3. uruchom WezTerm ponownie

---

## 🔁 Workflow zmian

Po każdej zmianie konfiguracji WezTerm:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos

