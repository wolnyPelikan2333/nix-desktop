Neovim — edycja wielu miejsc (NATIVE, bez multikursora)

Cel: zmieniać wiele miejsc szybko i bezpiecznie,
bez pluginów i bez ryzyka „ślepych” operacji.

🔑 Zasada nadrzędna

Najpierw wybierz ZAKRES zmiany, potem OPERACJĘ.
Jeśli nie wiesz dokładnie, co zmieni się w każdym miejscu — przerwij.

🧭 Decyzja w 5 sekund
Chcę zrobić	Użyj
zmiana w kolumnie / na początku wielu linii	Ctrl+v (Visual Block)
powtarzalna zmiana sekwencyjna	. (repeat)
globalna zmiana z kontrolą	:%s///gc
ta sama sekwencja kroków	makro (q)
zmiana kolejnych wystąpień	cgn

Visual Block — „kolumnowy multikursor”
Kiedy

- listy

- markdown

- checkboxy

- prefiksy / sufiksy

Kiedy NIE

- różne długości linii

- różny kontekst semantyczny

Jak
Ctrl+v      # zaznacz kolumnę
j / k       # rozszerz zaznaczenie
r x         # zamień znak

Przykład
- [ ] task one
- [ ] task two
- [ ] task three

→ Ctrl+v → zaznacz [ → r x

- [x] task one
- [x] task two
- [x] task three

2️⃣ . (repeat) — najbezpieczniejszy „pseudo-multikursor”
Kiedy

ta sama zmiana w wielu miejscach

zmiana logicznie powtarzalna

Jak
ciw nowa_nazwa<Esc>
j .
j .

Dlaczego to dobre

pełna kontrola

widzisz każdy krok

zero magii

3️⃣ Global replace z potwierdzeniem
Kiedy

wiele wystąpień

chcesz decydować per przypadek

Jak
:%s/stare/nowe/gc


y — zamień

n — pomiń

q — przerwij

📌 Bezpieczniejsze niż multikursor, bo widzisz kontekst.

4️⃣ Makra — „programowanie edycji”

📎 **Zobacz osobną ściągę:**  
👉 [Neovim — makra (ściąga decyzyjna)](./nvim-macros.md)

Kiedy

sekwencja kilku kroków

zmiana strukturalna

Jak
qa            # start makra (rejestr a)
<operacje>    # np. caw foo<Esc>j
q             # stop
@a            # wykonaj
5@a           # wykonaj 5 razy

Zasada

Makro musi być:

- krótkie

- deterministyczne

- przewidywalne

5️⃣ cgn — zmiana kolejnych wystąpień
Kiedy

chcesz zmieniać wystąpienia po kolei

nie wszystkie naraz

Jak
cgn nowe<Esc>
.             # następne
.             # kolejne


📌 To jest manualny multikursor z pełną kontrolą.

❌ Czego NIE robić

❌ nie używaj edycji wielokrotnej:

- w złożonych plikach .nix

- w logice warunkowej

- gdy kontekst się różni

- gdy jesteś zmęczony i niepewny

🧠 Złota reguła końcowa

Jeśli nie potrafisz przewidzieć efektu w KAŻDYM miejscu — STOP.
Przerwij, cofnij, wybierz inną technikę.
