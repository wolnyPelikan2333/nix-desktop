# 🌐 Network debug – minimum diagnostyki

Ta ściąga daje **najkrótszą możliwą ścieżkę diagnozy problemów z siecią** w NixOS.
Bez grzebania w konfiguracji i bez zgadywania.

Cel:

* sprawdzić **czy sieć działa**,
* ustalić **gdzie jest problem**,
* wiedzieć **kiedy to nie Twoja wina**.

---

## Mentalny model

Idziemy **od dołu do góry**:

1. interfejs
2. IP
3. routing
4. DNS
5. aplikacja

Zatrzymaj się, gdy znajdziesz błąd.

---

## 1️⃣ Czy interfejs jest UP?

```bash
ip link
```

Szukaj:

* `state UP`
* brak `DOWN`

Jeśli interfejs DOWN → to nie jest problem DNS.

---

## 2️⃣ Czy masz adres IP?

```bash
ip addr
```

Szukaj:

* adresu `inet`
* nie tylko `127.0.0.1`

Brak IP → problem z DHCP / Wi-Fi.

---

## 3️⃣ Czy jest routing?

```bash
ip route
```

Powinno być:

* `default via ...`

Brak default route → brak internetu.

---

## 4️⃣ Test po IP (bez DNS)

```bash
ping -c 3 1.1.1.1
```

* ❌ FAIL → problem sieciowy / router
* ✅ OK → przejdź dalej

---

## 5️⃣ Test DNS

```bash
ping -c 3 google.com
```

* ❌ FAIL → DNS
* ✅ OK → sieć działa

---

## 6️⃣ Sprawdzenie resolvera

```bash
resolvectl status
```

Szukaj:

* serwerów DNS
* aktywnego linku

---

## 7️⃣ NetworkManager (jeśli używany)

```bash
nmcli device status
nmcli general status
```

---

## 8️⃣ Wi-Fi szybki check

```bash
nmcli device wifi list
```

Jeśli nie widzi sieci → sprzęt / sterownik.

---

## 9️⃣ Logi sieci (tylko jeśli trzeba)

```bash
journalctl -u NetworkManager -b
```

Połącz z:

```bash
journalctl -p err -b | rg network
```

---

## Typowe wnioski

* IP OK, ping IP OK, DNS FAIL → **DNS**
* brak IP → **DHCP / Wi-Fi**
* wszystko OK → **problem aplikacji / serwisu**

---

## 🚫 Czego NIE robić

❌ restartów w ciemno
❌ edycji configu bez diagnozy
❌ mieszania kilku problemów naraz

---

## 🧷 ABSOLUTNE MINIMUM

Zapamiętaj tylko to:

```bash
ip link
ip addr
ping 1.1.1.1
ping google.com
```

---

✅ Ta sekwencja pozwala **zdiagnozować 90% problemów sieciowych w 2–3 minuty**.

