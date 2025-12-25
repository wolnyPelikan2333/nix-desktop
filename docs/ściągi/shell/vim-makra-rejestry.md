# Vim / Neovim — makra i rejestry (ściąga decyzyjna)

> Makra = nagrywanie klawiszy  
> Rejestry = schowki (tekstu i makr)

Bez pluginów. Zawsze dostępne.

---

## 🔁 MAKRA — gdy musisz zrobić to samo wiele razy

### ❓ Chcesz powtórzyć **tę samą edycję** na wielu liniach?

---

### ▶️ Nagraj makro

W trybie **NORMAL**:

```vim
qa

- q → start nagrywania

- a → rejestr (dowolna litera: a–z)

✍️ Wykonaj edycję na jednej linii

Przykład:

Ipkgs.<Esc>

(dodaje pkgs. na początku linii)

⏹ Zakończ nagrywanie
q

Makro zapisane.

▶️ Odtwórz makro
@a


@ → odtwórz

a → z rejestru a

🔂 Powtarzanie
@@


→ powtórz ostatnie makro

- 10@a


→ wykonaj makro 10 razy

⭐ Przykład praktyczny (NixOS / pkgs)

Masz:

foo = bar;
baz = qux;
test = ok;


Chcesz:

pkgs.foo = bar;
pkgs.baz = qux;
pkgs.test = ok;

Sekwencja:

qa
Ipkgs.<Esc>
q
3@a

🧠 REJESTRY — gdzie Vim trzyma tekst i makra
❓ Chcesz świadomie używać schowków?
📦 Podstawowe rejestry
Rejestr	Znaczenie
"	domyślny
a–z	ręczne (makra, tekst)
0	ostatnie yank
+	schowek systemowy
_	czarna dziura (discard)

✂️ Yank / delete do konkretnego rejestru
"ayw

→ yank słowo do rejestru a

"_dd

→ usuń linię bez psucia schowka

📋 Wklejanie z rejestru
"ap

→ wklej zawartość rejestru a

🔍 Podgląd rejestrów
:registers

albo krócej:

:reg

🔗 Makra + rejestry = to samo

makro w a = zawartość rejestru a

możesz:

- podejrzeć

- skopiować

- edytować

:reg a

❌ Kiedy NIE używać makr?

gdy da się użyć:

- Visual Block

- :normal

- gdy operacja jest jednorazowa i prosta

✅ Kiedy makra są IDEALNE?

- szybki refaktor

- zmiany w wielu liniach

- „użyję raz i zapomnę”

- brak pluginów
