# 🐚 Shell – pipes (`|`) i `xargs` (praktyczne minimum)

Ściąga do **łączenia poleceń w potoki** i wykonywania akcji na wynikach.

Cel:

* skleić proste komendy w **jedno użyteczne narzędzie**,
* bezpiecznie operować na wielu plikach,
* rozumieć, *kiedy pipe*, a *kiedy xargs*.

---

## Pipes `|` – przekazywanie wyjścia dalej

### Podstawy

```bash
komenda1 | komenda2
```

* STDOUT z `komenda1` → STDIN `komenda2`
* brak plików tymczasowych

---

### Klasyki

```bash
rg ERROR | less
ps aux | rg nix
ls -l | awk '{print $9}'
```

---

### Mentalny skrót

* **Filtrowanie / formatowanie** → pipe
* **Brak efektów ubocznych** → bezpieczne

---

## `xargs` – wykonaj komendę na wynikach

### Dlaczego `xargs`?

Pipe przekazuje **tekst**, a nie argumenty.
`xargs` zamienia linie na **argumenty polecenia**.

---

### Podstawy

```bash
fd .nix | xargs wc -l
```

---

### Bezpieczne rozbijanie (spacje, znaki specjalne)

```bash
fd .nix -0 | xargs -0 wc -l
```

➡️ **Zawsze używaj `-0`**, jeśli to możliwe.

---

### Jedno wywołanie na element

```bash
fd .nix | xargs -n1 echo
```

---

### Podgląd zamiast wykonania

```bash
fd .nix | xargs echo rm
```

Dopiero potem:

```bash
fd .nix | xargs rm
```

---

## Pipes vs xargs – kiedy co?

| Sytuacja            | Użyj    |   |
| ------------------- | ------- | - |
| Filtrowanie tekstu  | `       | ` |
| Zliczanie, format   | `       | ` |
| Operacje na plikach | `xargs` |   |
| `rm`, `chmod`, `wc` | `xargs` |   |

---

## Najczęstsze kombinacje

### Znajdź pliki → działaj

```bash
fd '.log' | xargs rg ERROR
```

---

### Dużo wyników, bezpiecznie

```bash
fd .nix -0 | xargs -0 rg flake
```

---

### Szybki audit

```bash
fd .nix | xargs wc -l | sort -n
```

---

## Mentalne skróty

* **Pipe** = przekazuję tekst dalej
* **xargs** = robię coś *na* wynikach
* **Najpierw echo, potem akcja**

---

## Minimum do zapamiętania

```bash
komenda | komenda
fd -0 | xargs -0 <cmd>
```

---

✅ To zamyka podstawowy arsenał pracy w shellu.

