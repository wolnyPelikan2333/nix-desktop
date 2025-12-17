# 📜 Logs – jak czytać `journalctl` (minimum, które działa)

Ta ściąga pokazuje **jak szybko znaleźć przyczynę problemu** w logach systemowych NixOS.
Bez grzebania, bez zalewania się tysiącem linii.

Cel:

* wiedzieć **GDZIE patrzeć**,
* wiedzieć **JAK zawężać** logi,
* nie zgubić się w szumie.

---

## Mentalny model

* `journalctl` = **jedno źródło prawdy**
* najpierw **zawężaj**, potem czytaj
* szukasz **błędów i momentu**, nie całej historii świata

---

## 1️⃣ Najczęstsze: co poszło nie tak *teraz*

```bash
journalctl -p err -b
```

* `-p err` → tylko błędy
* `-b` → tylko bieżący boot

👉 **To jest pierwszy strzał w 80% przypadków**.

---

## 2️⃣ Poprzedni boot (po rollbacku / crashu)

```bash
journalctl -p err -b -1
```

* `-1` = poprzedni start systemu

---

## 3️⃣ Czytanie „na żywo”

```bash
journalctl -f
```

* odpowiednik `tail -f`
* dobre przy restarcie usługi

---

## 4️⃣ Logi konkretnej usługi

```bash
journalctl -u NetworkManager
journalctl -u sshd
```

Z bieżącego bootu:

```bash
journalctl -u NetworkManager -b
```

---

## 5️⃣ Od konkretnego momentu

```bash
journalctl --since "10 minutes ago"
journalctl --since "2025-12-17 10:00"
```

---

## 6️⃣ Szukanie tekstu w logach

```bash
journalctl | rg error
journalctl -b | rg fail
```

👉 **Łącz z `rg`**, nie czytaj ręcznie.

---

## 7️⃣ Logi tylko z obecnego użytkownika

```bash
journalctl --user
journalctl --user -b
```

Przydatne dla:

* sesji graficznej
* narzędzi użytkownika

---

## 8️⃣ Najczęstsze wzorce problemów

Szukaj słów:

* `failed`
* `denied`
* `timeout`
* `not found`
* `dependency failed`

---

## 9️⃣ Typowy flow diagnostyczny

1. ```bash
   journalctl -p err -b
   ```
2. Zobacz **nazwę usługi**
3. ```bash
   journalctl -u <usługa> -b
   ```
4. Jeśli po reboocie:

   ```bash
   journalctl -p err -b -1
   ```

---

## 🚫 Czego NIE robić

❌ `journalctl` bez filtrów
❌ czytanie godzinami
❌ poprawianie configu bez zrozumienia błędu

---

## 🧷 ABSOLUTNE MINIMUM

Zapamiętaj tylko to:

```bash
journalctl -p err -b
journalctl -u <usługa> -b
journalctl -p err -b -1
```

---

✅ To wystarczy, żeby **czytać logi skutecznie, a nie heroicznie**.

