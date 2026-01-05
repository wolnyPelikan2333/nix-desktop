ŚCIĄGA — SCHOWEK SYSTEMOWY W NEOVIM
🔹 ZASADA OGÓLNA (KANON)
" + <operacja>

" → wybór rejestru

- → schowek systemowy

dalej normalna komenda (y, p, yy, yw, …)

Ta warstwa nie zależy od keymaps.
Jeśli coś nie działa — wracasz tutaj.

📋 KOPIOWANIE (YANK)
Zaznaczony tekst
v → zaznacz → "+y

Cała linia
"+yy

Jedno słowo
"+yw

Do końca linii
"+y$

📥 WKLEJANIE (PASTE)
Po kursorze
"+p

Przed kursorem
"+P

🧠 WAŻNE ROZRÓŻNIENIE

Ctrl + Shift + V → terminal (Neovim nie bierze udziału)

"+y / "+p → Neovim ↔ system

jeśli "+y nie działa → brak clipboard provider

🔐 USUWANIE BEZ PSUCIA SCHOWKA
"\_d

(np. "\_dd usuwa całą linię, nie zmieniając +)

⌨️ WARSTWA DODATKOWA — SKRÓTY JEDNORUCHOWE (TWOJA KONFIGURACJA)

Ta sekcja zależy od keymaps
Jeśli nie działa → wróć do sekcji wyżej ("+…)

Zakładamy:

leader = ,

tryb normalny

jeden ruch = jeden efekt

🚀 JEDNORUCHOWE OPERACJE
Kopiuj CAŁĄ LINIĘ do schowka systemowego
,y

↳ technicznie:

"+yy

Wklej ze schowka systemowego (po kursorze)
,p

↳ technicznie:

"+p

Wklej ze schowka systemowego (przed kursorem)
,P

↳ technicznie:

"+P

Usuń CAŁĄ LINIĘ bez psucia schowka
,d

↳ technicznie:

"\_dd

🧭 JAK Z TEGO KORZYSTAĆ W PRAKTYCE

działa skrót? → używasz skrótu

nie działa skrót? → używasz "+…

coś jest „powiedzmy że działa”? → sprawdzasz :echo has('clipboard')

Ta ściąga jest odporna na konfigurację:

dół = wygoda

góra = prawda bazowa

📌 STATUS

nic nie usunięte

nic nie nadpisane

masz dwie drogi do tego samego efektu

zawsze wiesz, gdzie jest problem, jeśli coś nie działa
