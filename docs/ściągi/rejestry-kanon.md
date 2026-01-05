🧾 KANONICZNA ŚCIĄGA REJESTRÓW (NEOVIM)
🔑 ZASADA OGÓLNA
"<rejestr><operacja>

Jeśli nie wybierzesz rejestru, Neovim użyje domyślnego (").

🟡 " — REJESTR DOMYŚLNY

Do codziennej pracy.

Co do niego trafia:

y (kopiowanie)

d (usuwanie)

c (zmiana)

Kiedy używać:

gdy nie obchodzi Cię, co było wcześniej

szybkie operacje „tu i teraz”

Przykłady:
yy → kopia linii
dd → usuń linię (i nadpisz poprzednią zawartość)
p → wklej ostatnią operację

⚠️ Niestabilny — każda operacja go nadpisuje.

🟢 0 — OSTATNI YANK (BEZ KASOWANIA)

Najbezpieczniejszy rejestr do kopiowania.

Co do niego trafia:

TYLKO y

d / c nie ruszają tego rejestru

Kiedy używać:

skopiowałeś coś (y)

potem coś usunąłeś

i chcesz wkleić oryginalną kopię

Przykłady:
yyp → kopiuj linię
dd → usuń inną linię
"0p → wklej poprzednią kopię

📌 To jest Twój „undo dla schowka”.

🔵 + — SCHOWEK SYSTEMOWY

Most: Neovim ↔ system.

Co do niego trafia:

TYLKO jeśli jawnie go użyjesz

Kiedy używać:

kopiujesz poza Neovim

wklejasz z przeglądarki / terminala

chcesz coś „wynieść na zewnątrz”

Przykłady:
"+yy → kopiuj linię do systemu
"+p → wklej ze schowka systemowego

⚠️ Nie działa, jeśli:

:echo has('clipboard') == 0

⚫ \_ — CZARNY REJESTR (KOSZ)

Do kasowania bez konsekwencji.

Co do niego trafia:

nic (i o to chodzi)

Kiedy używać:

usuwasz coś technicznie

nie chcesz psuć żadnego schowka

Przykłady:
"\_dd → usuń linię, nic nie zap🧠 JAK WYBRAĆ REJESTR (1 ZDANIE)
Chcę… Rejestr:

- szybko pracować "
- nie stracić kopii 0
- przenieść poza nvim +
- usunąć bez śladu \_

🧭 KANON PRACY (REKOMENDACJA)

kopiujesz ważne → y + 0 Cię ratuje

pracujesz z innymi programami → +

sprzątasz → \_

reszta → "amiętuj
"\_d$ → usuń do końca linii

📌 To jest Twój „rm -f” dla tekstu.

⌨️ LEADER = , — KANONICZNE SKRÓTY

📋 KOPIOWANIE

,y — kopiuj CAŁĄ LINIĘ do schowka systemowego (+)
"+yy

,Y — kopiuj CAŁĄ LINIĘ do rejestru 0 (bezpieczny yank)
"0yy

🔎 Używaj ,Y, gdy kopiujesz „ważne” rzeczy w obrębie nvim.

📥 WKLEJANIE

,p — wklej ze schowka systemowego (+):wq
"+p

,P🧠 JAK TEGO UŻYWAĆ (W PRAKTYCE)

kopiuję coś do innych programów → ,y

kopiuję coś ważnego w nvim → ,Y

wklejam z przeglądarki / terminala → ,p

wracam do starej kopii → ,P

sprzątam kod → ,d

Nie myślisz o rejestrach.
One są zaszyte w skrótach. — wklej z rejestru 0
"0p

🧹 USUWANIE
,d — usuń CAŁĄ LINIĘ do czarnego rejestru (\_)
"\_dd

🔥 Nigdy nie psuje schowka ani 0.
