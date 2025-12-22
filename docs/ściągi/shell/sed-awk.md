# 🐚 Shell – sed / awk (minimum, które działa)

Ściąga do **szybkiej obróbki tekstu w terminalu**. Bez teorii akademickiej — tylko to, co faktycznie się przydaje.

Cel:

* filtrować linie,
* podmieniać tekst,
* wyciągać kolumny z logów i poleceń.

---

## sed – edycja strumienia tekstu

### Podstawowa podmiana

```bash
sed 's/stare/nowe/' plik.txt
```

* podmienia **pierwsze wystąpienie w linii**

---

### Podmiana globalna

```bash
sed 's/stare/nowe/g' plik.txt
```

---

### Tylko konkretna linia (np. 5)

```bash
sed '5s/stare/nowe/' plik.txt
```

---

### Usuwanie linii

```bash
sed '/ERROR/d' log.txt
```

---

### Podgląd bez zapisu (bezpieczne)

```bash
sed 's/foo/bar/g' plik.txt
```

---

### Zapis do pliku (ostrożnie)

```bash
sed -i 's/foo/bar/g' plik.txt
```

⚠️ Używaj **dopiero po podglądzie**.

---

## awk – praca na kolumnach

### Domyślny podział (spacje)

```bash
awk '{print $1}' plik.txt
```

* `$1` – pierwsza kolumna
* `$2` – druga kolumna
* `$0` – cała linia

---

### Wypisanie kilku kolumn

```bash
awk '{print $1, $3}' plik.txt
```

---

### Z nagłówkiem (numer linii)

```bash
awk '{print NR ":", $0}' plik.txt
```

---

### Filtr warunkowy

```bash
awk '$3 > 100 {print $1, $3}' dane.txt
```

---

### Własny separator (np. :)

```bash
awk -F: '{print $1}' /etc/passwd
```

---

## Kombinacje (najczęstsze)

### grep / rg + awk

```bash
rg ERROR log.txt | awk '{print $1, $2}'
```

---

### ps + awk (klasyk)

```bash
ps aux | awk '{print $1, $11}'
```

---

## Mentalne skróty

* **Zamienić tekst** → `sed`
* **Wyciągnąć kolumny** → `awk`
* **Najpierw podgląd, potem -i**

---

## Minimum do zapamiętania

```bash
sed 's/a/b/g'
awk '{print $1}'
```

Reszta przyjdzie w praktyce.

---

✅ To wystarczy, żeby ogarniać 80–90% przypadków w shellu.

## Bezpieczna edycja plików
sed 's/foo/bar/g' file.txt        # tylko podgląd
sed -i.bak 's/foo/bar/g' file.txt # z kopią zapasową

awk '{print NR, $1}' file.txt

