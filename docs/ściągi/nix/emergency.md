# 🚨 EMERGENCY / PANIC MODE – NixOS

Ten plik jest na moment, gdy:

* coś się **zepsuło**,
* jesteś zmęczony / zestresowany,
* **nie chcesz myśleć**, tylko wykonać poprawne kroki.

Czytaj **od góry do dołu**. Nie improwizuj.

---

## 0️⃣ ZATRZYMAJ SIĘ (ważne)

* nie edytuj plików na ślepo
* nie rób kilku rzeczy naraz
* **jedna decyzja na raz**

Jeśli serce bije szybciej → **przerwa 2 min**.

---

## 1️⃣ Czy system wstaje?

### ❌ NIE – system nie startuje / czarny ekran

➡️ **GRUB** → wybierz:

> `NixOS – previous generation`

Po starcie:

* **NIC nie zmieniaj**
* przejdź do punktu **4️⃣**

---

### ✅ TAK – system działa, ale coś jest popsute

Przejdź dalej.

---

## 2️⃣ Sprawdź repo (bez zmian)

```bash
cd /etc/nixos
git status
```

* `clean` → OK
* `dirty` → **nie commituj**, jeszcze

---

## 3️⃣ Czy ostatnia zmiana to `flake update`?

### ✅ TAK

```bash
git checkout -- flake.lock
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

Jeśli OK → STOP.

---

### ❌ NIE / NIE WIEM

Idź dalej.

---

## 4️⃣ Najszybszy rollback systemu

```bash
sudo nixos-rebuild switch --rollback
```

* brak zmian w plikach
* cofnięcie do poprzedniej generacji

Jeśli OK → STOP.

---

## 5️⃣ Cofnięcie konfiguracji (Git)

### 🔹 Porzuć lokalne zmiany

```bash
git restore .
```

⚠️ Tylko jeśli **nie potrzebujesz** tych zmian.

Następnie:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

---

## 6️⃣ Nadal źle? ZAMKNIJ SESJĘ

* **nie próbuj naprawiać wszystkiego dziś**
* zrób notatkę:

```text
co nie działa?
co robiłeś ostatnio?
na którym kroku utknąłeś?
```

To NIE jest porażka — to **ochrona systemu**.

---

## 🧠 Złote zasady panic-mode

* rollback ≠ porażka
* działający system > idealny system
* jutro myślisz lepiej niż dziś

---

## 🧷 ABSOLUTNE MINIMUM

Zapamiętaj tylko to:

```text
GRUB → previous generation
sudo nixos-rebuild switch --rollback
git restore .
```

---

✅ Jeśli trzymasz się tego pliku — **nie rozwalisz systemu**.

