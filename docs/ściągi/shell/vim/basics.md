# 🧠 Vim / Neovim – ściąga ratunkowa

Ta ściąga jest na moment, gdy:

* jesteś zmęczony,
* edytujesz **ważne pliki** (np. `/etc/nixos`),
* chcesz zrobić coś szybko i **bez ryzyka**.

Bez teorii. Tylko rzeczy, które **naprawdę się przydają**.

---

## 🚪 Wejście / wyjście (PANIC LEVEL 0)

```vim
:q        " wyjście (gdy brak zmian)
:q!       " wyjście bez zapisu
:w        " zapisz
:wq       " zapisz i wyjdź
```

---

## 🔎 Szukanie

```vim
/tekst    " szukaj
n         " następne
N         " poprzednie
```

---

## 🔁 Znajdź i zamień (NAJWAŻNIEJSZE)

### Cały plik

```vim
:%s/stare/nowe/g
```

### Bezpiecznie (z potwierdzeniem)

```vim
:%s/stare/nowe/gc
```

👉 **To jest tryb domyślny przy zmęczeniu**.

---

## ✂️ Zaznaczanie

```vim
v   " znaki
V   " linie
```

Zamiana tylko w zaznaczeniu:

```vim
:s/stare/nowe/g
```

---

## ↩️ Cofanie / ponawianie

```vim
u        " cofnij
Ctrl+r   " ponów
```

---

## 📋 Kopiuj / wklej (wewnątrz vim)

```vim
yy   " kopiuj linię
p    " wklej pod spodem
P    " wklej nad
```

---

## 🧹 Usuwanie

```vim
dd   " usuń linię
dw   " usuń słowo
```

---

## 🧭 Nawigacja (minimum)

```vim
gg   " początek pliku
G    " koniec pliku
```

---

## 🚑 PANIC MODE – zapamiętaj tylko to

```vim
:q!
:%s/stare/nowe/gc
u
```

---

✅ Jeśli znasz te kilka komend — **wystarczy do bezpiecznej pracy w NixOS**.

