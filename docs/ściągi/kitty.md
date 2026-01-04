🐱 kitty — zarządzanie oknami (ściąga decyzyjna)
➕ Jak podzielić terminal na dwa panele?

Poziomo (góra / dół)

F5

map f5 launch --location=hsplit

Pionowo (lewo / prawo)

F6

map f6 launch --location=vsplit

Automatycznie (kitty wybiera najlepszy podział)

F4

map f4 launch --location=split

🔄 Jak zmienić orientację podziału?

Obróć aktualny split (pion ↔ poziom)

F7

map f7 layout_action rotate

🚚 Jak przesunąć aktywne okno?

Przesuwanie okna między panelami

Shift + ↑ ↓ ← →

map shift+up move_window up
map shift+down move_window down
map shift+left move_window left
map shift+right move_window right

📌 Jak „przykleić” okno do krawędzi ekranu?

Do krawędzi aktualnego workspace

Ctrl + Shift + ↑ ↓ ← →

map ctrl+shift+up layout_action move_to_screen_edge top
map ctrl+shift+down layout_action move_to_screen_edge bottom
map ctrl+shift+left layout_action move_to_screen_edge left
map ctrl+shift+right layout_action move_to_screen_edge right

🧭 Jak zmienić fokus (bez ruszania okien)?

Przełączanie się między panelami

Ctrl + ↑ ↓ ← →

map ctrl+up neighboring_window up
map ctrl+down neighboring_window down
map ctrl+left neighboring_window left
map ctrl+right neighboring_window right

⚖️ Jak zmienić proporcje splitu?

Aktywne okno zajmuje 80% przestrzeni

Ctrl + .

map ctrl+. layout_action bias 80

🧠 Notatka mentalna (ważne przy zmęczeniu)

F4 – „nie myśl, kitty zdecyduje”

Ctrl + strzałki – tylko fokus (bez bałaganu)

Shift + strzałki – realne przemieszczanie okien

Bias używaj rzadko, ale świadomie
