# Standardy pracy z NixOS

Ten dokument definiuje **jak pracujemy z systemem NixOS** w tym repozytorium.
Nie opisuje technologii ani narzędzi — ustala **kontrakt pracy**.

Standardy:
- mają pierwszeństwo przed procedurami i ściągami,
- obowiązują zawsze w strefie produkcji,
- mogą być zmieniane, jeśli przestają pomagać.

---

## 1. Zakres i odpowiedzialność

### Zakres

Ten standard dotyczy:
- wszystkich zmian wykonywanych w `/etc/nixos`,
- konfiguracji systemu NixOS, Home Managera i powiązanych modułów,
- pracy wykonywanej na systemie produkcyjnym.

Ten standard **NIE dotyczy**:
- nauki i eksperymentów,
- testów składni i zachowań języka,
- katalogów i repozytoriów poza `/etc/nixos`.

> Jeśli coś jest eksperymentem — **nie należy do tego standardu**.

---

### Odpowiedzialność

Osoba wykonująca zmianę odpowiada za:
- zrozumienie **co** zmienia,
- zrozumienie **dlaczego** to zmienia,
- świadomość **jak wrócić**, jeśli coś pójdzie nie tak.

Brak pewności = **brak zmiany**.

Ten standard ma:
- chronić system,
- chronić koncentrację,
- zmniejszać presję tempa.

Nie ma:
- wymuszać perfekcji,
- blokować rozwoju,
- zastępować myślenia.

---

### Relacja do innych dokumentów

Ten dokument ma **pierwszeństwo** przed:
- procedurami,
- ściągami,
- nawykami.

Szczegóły techniczne znajdują się **poza** tym standardem
i są linkowane tam, gdzie są potrzebne.

Jeśli coś jest sprzeczne:
> **wygrywa standard**, nie skrót myślowy.

---

## 2. Strefy pracy

Ten standard opiera się na **twardym rozdziale stref pracy**.
Strefy istnieją po to, aby **zmniejszyć ryzyko przypadkowych błędów**.

---

### 🟥 Produkcja — `/etc/nixos`

- jedyne miejsce, gdzie:
  - obowiązuje ten standard,
  - zmiany wpływają na działający system,
- **zakaz eksperymentów**,
- każda zmiana musi być:
  - świadoma,
  - odwracalna,
  - opisana.

Jeśli nie masz pełnej kontroli nad zmianą — **nie jest to strefa produkcji**.

---

### 🟨 Dokumentacja — `/etc/nixos/docs`

- miejsce opisu:
  - decyzji,
  - procedur,
  - standardów,
- zmiany **nie wpływają** bezpośrednio na system,
- dokumentacja:
  - porządkuje wiedzę,
  - zmniejsza presję pamięci.

Dokumentacja **nie jest miejscem testów** ani „brudnych notatek”.

---

### 🟩 Nauka i eksperymenty — poza `/etc/nixos`

- jedyne miejsce, gdzie:
  - wolno popełniać błędy,
  - wolno nie wiedzieć,
  - wolno psuć i wyrzucać,
- brak `switch`,
- brak wpływu na system produkcyjny.

> Jeśli coś jest nauką — **musi być fizycznie poza `/etc/nixos`**.

---

### Zasada nadrzędna dla stref

- stref **nie wolno mieszać**,
- nie ma „tylko na chwilę”,
- nie ma „to tylko mała zmiana”.

Jeśli masz wątpliwość, do której strefy należy działanie:
> **traktuj je jak produkcję i zatrzymaj się**.

---

## 3. Nadrzędna zasada bezpieczeństwa

**System jest ważniejszy niż tempo.**

Ta zasada ma **pierwszeństwo absolutne** przed:
- planem sesji,
- checklistami,
- procedurami,
- presją „dokończmy jeszcze to jedno”.

Jeśli cokolwiek jest z nią sprzeczne — **zawsze wygrywa ta zasada**.

---

### Co to oznacza w praktyce

- żadna zmiana nie jest pilna, jeśli:
  - nie rozumiesz jej skutków,
  - nie potrafisz jej cofnąć,
- przerwanie pracy jest:
  - poprawnym działaniem,
  - elementem bezpieczeństwa,
- rollback to:
  - koszt,
  - a nie strategia pracy.

---

### Zmęczenie jako sygnał techniczny

- spadek koncentracji,
- automatyczne odruchy (np. uruchamianie poleceń bez refleksji),
- „zlewanie się” instrukcji,

to **sygnały STOP**, a nie problem osobisty.

> Zatrzymanie pracy jest decyzją techniczną.

---

### Konsekwencje tej zasady

Jeśli pojawia się:
- niepewność → **STOP**
- pośpiech → **STOP**
- myśl „to tylko mała zmiana” → **STOP**

> Lepszy brak zmiany niż zmiana bez pełnej kontroli.

---

## 4. ⚠️ OPERACJA PRODUKCYJNA (wzorzec)

Ten standard wprowadza **jeden, niezmienny wzorzec ostrzegawczy**
używany we wszystkich dokumentach dotyczących pracy z systemem.

Celem wzorca jest:
- zatrzymanie autopilota,
- jasne rozdzielenie zakazów i dozwolonych działań,
- ujednolicenie sygnałów bezpieczeństwa.

---

### Jedyny dozwolony format

W dokumentacji **zawsze** używany jest dokładnie ten układ:

⚠️ OPERACJA PRODUKCYJNA

⛔ NIE RÓB

❌ …

✅ RÓB

✔️ …


- kolejność jest stała: **NIE RÓB → RÓB**
- brak dodatkowych komentarzy w bloku
- brak wariantów stylistycznych

---

### Kiedy wzorzec jest OBOWIĄZKOWY

- każda zmiana wpływająca na działający system,
- każda procedura zawierająca build / switch,
- każda sytuacja podwyższonego ryzyka lub zmęczenia.

Jeśli masz wątpliwość:
> **użyj wzorca**.

---

### Kiedy wzorzec jest ZABRONIONY

- w ściągach,
- w materiałach do nauki,
- w opisach narzędzi i składni.

Wzorzec służy **bezpieczeństwu**, nie straszeniu.

---

## 5. Dozwolony sposób wprowadzania zmian

Zmiany w systemie są dozwolone **wyłącznie w kontrolowanym trybie pracy**.
Celem nie jest szybkość, lecz **przewidywalność**.

---

### Minimalna jednostka zmiany

- jedna zmiana = jeden zamiar,
- jedna zmiana = jeden logiczny krok,
- jedna zmiana = możliwość cofnięcia.

Zakazane jest:
- łączenie wielu intencji w jednej zmianie,
- „poprawianie przy okazji”,
- zmiany bez jasnego celu.

Jeśli zmiana nie daje się opisać jednym zdaniem:
> **jest za duża**.

---

### Kolejność działań

Każda zmiana przechodzi przez **ten sam porządek logiczny**:

1. zrozumienie, **co** ma się zmienić,
2. zrozumienie, **dlaczego** to robisz,
3. sprawdzenie, **jak wrócić**, jeśli coś pójdzie nie tak,
4. dopiero potem wykonanie zmiany.

Pominięcie któregoś kroku:
> **unieważnia zmianę**.

---

### Zmiany a presja czasu

- presja czasu **nie jest** argumentem technicznym,
- „chcę już skończyć” **nie jest** kryterium decyzji,
- zmęczenie **nie obniża** progu bezpieczeństwa.

Jeśli pojawia się presja:
> **zmiana jest odkładana**.

---

## 6. Zarządzanie ryzykiem

Ten standard zakłada, że **ryzyko jest częścią pracy**,
a nie czymś, co da się wyeliminować całkowicie.

Celem nie jest brak ryzyka, lecz **świadome jego ograniczanie**.

---

### Miejsca podwyższonego ryzyka

Ryzyko jest **zawsze wyższe**, gdy:
- zmieniasz pliki centralne konfiguracji,
- wykonujesz operacje wpływające na start systemu,
- pracujesz po długiej sesji lub przy spadku koncentracji.

W takich sytuacjach:
> **obowiązują ostrzejsze kryteria STOP**.

---

### Sygnały STOP

Następujące sygnały **wymagają zatrzymania pracy**:
- niepewność co do skutków zmiany,
- automatyczne odruchy,
- konieczność „zgadywania”, co zrobi system.

STOP oznacza:
- przerwę,
- zapisanie kontekstu,
- powrót później z czystą głową.

---

### Ryzyko a odpowiedzialność

- ignorowanie sygnałów STOP:
  - zwiększa koszt przyszłych błędów,
  - obniża zaufanie do systemu,
- zatrzymanie pracy:
  - jest decyzją techniczną,
  - jest częścią odpowiedzialności.

> Odpowiedzialność to umiejętność **nie robienia zmiany**.

---

## 7. Relacja do procedur i ściąg

Ten standard **nie zawiera instrukcji technicznych**.
Jego rolą jest **ustalenie zasad**, a nie opisywanie wykonania.

---

### Standardy vs procedury

- **Standardy**:
  - mówią *jak wolno pracować*,
  - obowiązują zawsze,
  - mają pierwszeństwo.

- **Procedury**:
  - mówią *co zrobić w konkretnej sytuacji*,
  - są podporządkowane standardom,
  - nie mogą ich omijać.

Jeśli procedura jest sprzeczna ze standardem:
> **procedura jest błędna**.

---

### Standardy vs ściągi

- **Ściągi**:
  - pomagają w szybkich decyzjach,
  - skracają czas przypominania,
  - **nie są miejscem zasad bezpieczeństwa**.

Ściągi:
- nie zawierają ostrzeżeń produkcyjnych,
- nie zastępują standardów,
- nie usprawiedliwiają ryzykownych działań.

---

### Zasada nawigacyjna

Jeśli:
- nie wiesz **jak pracować** → **standardy**
- nie wiesz **co zrobić** → **procedury**
- nie pamiętasz **jak coś się nazywa** → **ściągi**

To jest **jedyny poprawny kierunek czytania**.

---

## 8. Ewolucja standardu

Ten standard **nie jest niezmienny**.
Ma pomagać w pracy z systemem — jeśli przestaje pomagać,
**może i powinien być zmieniony**.

---

### Kiedy wolno zmieniać standard

- gdy standard:
  - powoduje blokadę zamiast bezpieczeństwa,
  - nie pasuje do aktualnego sposobu pracy,
  - generuje więcej napięcia niż porządku.

Zmiana standardu **nie jest porażką** —
jest sygnałem, że system pracy się rozwija.

---

### Jak zmieniać standard

- zmiana standardu jest:
  - świadoma,
  - opisana,
  - wykonywana w osobnej sesji,
- powód zmiany musi być zapisany:
  - co nie działało,
  - dlaczego zmiana pomaga.

Brak jasnego powodu:
> **oznacza brak zmiany**.

---

### Czego nie robić

- nie zmieniać standardów impulsywnie,
- nie omijać standardu „na chwilę”,
- nie dostosowywać standardu do pojedynczego przypadku.

Jeśli standard przeszkadza:
> **najpierw go zmień, potem działaj**.

