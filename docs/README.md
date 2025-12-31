# Dokumentacja /etc/nixos

Ta dokumentacja istnieje po to, żeby **bezpiecznie pracować z systemem NixOS**,
a nie po to, żeby uczyć się wszystkiego o Nixie.

Jej celem jest:
- zmniejszyć ryzyko przypadkowych błędów,
- ułatwić podejmowanie decyzji,
- dać punkt odniesienia, gdy coś się psuje lub gdy wracasz do systemu po przerwie.

To jest **dokumentacja operacyjna**, nie tutorial.

---

## Jak korzystać z tej dokumentacji

1. **Najpierw sprawdź tę stronę** — ona mówi, gdzie czego szukać.
2. **Nie czytaj wszystkiego naraz** — sięgaj tylko po to, co jest potrzebne teraz.
3. Jeśli nie wiesz, do której kategorii należy problem:
   - **zatrzymaj się**
   - nie wprowadzaj zmian w systemie

Zasada nadrzędna:
> Dokumentacja ma pomagać dziś, nie być kompletna „na przyszłość”.

---

## Kategorie dokumentów

### 🧱 Standardy
Zasady pracy i kontrakty dotyczące tego repozytorium.

Odpowiadają na pytania:
- gdzie wolno eksperymentować, a gdzie nie,
- jak wygląda bezpieczna zmiana w systemie,
- jaka jest dozwolona kolejność działań.

Pliki:
- `zasady-projektu.md`
- *(docelowo)* `standardy/nix.md`

Standardy **nie uczą technologii** — określają ramy działania.

---

### 🧭 Procedury
Instrukcje „krok po kroku” na konkretne sytuacje.

Używaj ich, gdy:
- system nie zachowuje się jak powinien,
- build się wywala,
- potrzebujesz wykonać operację o podwyższonym ryzyku.

Przykładowe pliki:
- `ściągi/nix/flake-workflow.md`
- `ściągi/nix/emergency.md`
- `ściągi/nix/rollback.md`
- `git/safe-workflow.md`

Procedury zakładają, że **nie improwizujesz**.

---

### ⚡ Ściągi
Szybkie przypomnienia i decyzje operacyjne.

Używaj ich, gdy:
- wiesz, co chcesz zrobić,
- ale nie pamiętasz dokładnej składni lub różnicy między opcjami.

Przykładowe obszary:
- shell (grep, rg, sed, awk, xargs)
- vim / nvim
- nix (błędy, ostrzeżenia, różnice między komendami)

Przykładowe pliki:
- **`ściągi/nix/nss.md` — główny workflow pracy z systemem**
- `ściągi/shell/rg-fd-tree.md`
- `ściągi/nix/flake-check-vs-build-vs-switch.md`
- `ściągi/nix/nix-build-errors.md`

Ściągi są **narzędziem**, nie materiałem do nauki.

---

### 📝 Logi
Historia pracy i sesji.

Służą do:
- odtworzenia kontekstu zmian,
- zrozumienia, co było robione i dlaczego,
- spokojnego powrotu do pracy po przerwie.

Pliki:
- `AKTYWNA.md`
- `sesje/`

Logi nie są dokumentacją referencyjną — są pamięcią projektu.

---

## Gdzie szukać czego (indeks decyzyjny)

- **Chcę coś zmienić w systemie**  
  → najpierw *Standardy*, potem *Procedury*

- **Build / switch się wywala**  
  → *Procedury* (`nix/`, `git/`)

- **Nie pamiętam składni lub różnicy między narzędziami**  
  → *Ściągi*

- **Uczę się / testuję / eksperymentuję**  
  → poza `/etc/nixos` (strefa nauki)

---

## Zasada bezpieczeństwa

- Dokumentacja **nie zastępuje myślenia**.
- Jeśli coś jest niejasne:
  - nie rób zmiany „na czuja”,
  - nie eksperymentuj w `/etc/nixos`,
  - wróć do standardów albo zrób przerwę.

Lepszy brak zmiany niż zepsuty system.

