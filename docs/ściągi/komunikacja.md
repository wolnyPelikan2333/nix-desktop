🧾 ŚCIĄGA — JAK PISAĆ, GDY ENTER = WYŚLIJ
🔑 Zasada główna

Jedna wiadomość = jedna linia.
Rozdział robimy słowami, nie nowymi liniami.

🧠 PREFIKSY (NAJWAŻNIEJSZE)

Używaj jednego słowa + dwukropka na początku:

opis: — moje słowa / kontekst / co się dzieje

wklejka: — surowy tekst (kod, log, output)

output: — wynik polecenia

pytanie: — konkretne pytanie

uwaga: — meta / komunikacja

Przykłady:

opis: coś działa, ale efekt jest inny niż oczekiwany

wklejka: error E475 Invalid value for argument cmd

output: :echo has('clipboard') -> 0

🔒 DŁUŻSZA WKLEJKA (W JEDNEJ LINII)

Jeśli musisz wkleić więcej:

wklejka: --- START --- <tu cały tekst> --- END ---

Ja:

traktuję to jako dane

nie interpretuję jako Twoich słów

🧩 POJEDYNCZE KOMENDY / SYMBOLE

Używaj backticków (też w jednej linii):

`"+yy`

`:verbose nmap r`

To sygnał: symbol, nie wypowiedź.

🛑 SYGNAŁY STOP (BEZ ODPOWIEDZI)

Jeśli nie chcesz reakcji:

piszę

chwila

stop

Ja czekam i nie zgaduję.

🧭 JAK JA TO CZYTAM

opis: → odpowiadam opisowo

wklejka: / output: → analizuję technicznie

brak prefiksu → dopytam, zamiast zgadywać

✅ MINIMALNA WERSJA (DO ZAPAMIĘTANIA)

opis: = moje słowa

wklejka: = dane

To wystarcza w 100%.
