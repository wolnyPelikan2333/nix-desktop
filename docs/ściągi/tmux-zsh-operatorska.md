🧭 Ściąga operatorska — Alacritty / tmux / zsh
🖥️ Alacritty (rama, nie środowisko)

Rola: tylko emulator okna terminala
Nie robi: paneli, zakładek, sesji

Zasady

Zamknięcie Alacritty ≠ utrata stanu pracy

Otwarcie Alacritty → wejście w tmuxa

Cała logika pracy jest poza Alacritty

Alacritty = okno
tmux = przestrzeń pracy

🧩 tmux (rdzeń workflow)
Prefix
Ctrl + a

📂 Zakładki (okna)

Nowa zakładka
Ctrl + a c

Następna / poprzednia
Ctrl + a n
Ctrl + a p

Konkretna zakładka
Ctrl + a 0–9

Zamknij zakładkę
Ctrl + a &

🧱 Panele (splity)

Split pionowy (lewo / prawo)
Ctrl + a %

Split poziomy (góra / dół)
Ctrl + a "

Przechodzenie między panelami (vim-style)
Ctrl + a h / j / k / l

Zamknij panel
Ctrl + a x
(lub exit / Ctrl + d w panelu)

🧩 Layout roboczy

3 panele (lewy + prawy góra/dół)
Ctrl + a Shift + M

W prawym dolnym panelu:

btop

(uruchamiany ręcznie — stabilność przy hibernacji)

🧠 Model mentalny tmuxa

panel → podział ekranu

zakładka (okno) → osobny kontekst pracy

sesja → cały świat roboczy

🐚 zsh (shell, nie stan)
Zasady

.zshrc NIE jest edytowany ręcznie (symlink z /nix/store)

Zmiany robimy tylko w .nix

Jedno źródło prawdy dla historii

Historia

share = false
→ brak korupcji historii przy tmux + hibernacja

Historia konfigurowana centralnie w:

/etc/nixos/modules/zsh.nix

Autostart tmuxa

Nowy terminal → automatyczne dołączenie do sesji main

Jeśli sesja nie istnieje → zostaje utworzona

Efekt:
terminal = powrót do pracy, nie reset

Alias krytyczny
alias nss="/etc/nixos/scripts/nss-safe"

⚠️ Uwaga: brak zamkniętego ' → cały shell nie startuje

🚦 Zasady bezpieczeństwa (ważne)

Jeśli plik jest:

~/.config/... -> /nix/store/...

➜ czytasz, ale NIE edytujesz

Błąd składni:

unmatched '

➜ szukaj w initContent / initExtra w .nix

W initContent = '':

preferuj " zamiast '

minimalizuje ryzyko błędów

🎯 Stan docelowy (skrót)

Zamykam terminal → nic nie ginie

Otwieram terminal → mam dokładnie to, co było

tmux trzyma:

sesję

zakładki

panele

zsh jest stabilny i deklaratywny

system nie maskuje błędów

🧠 Jedno zdanie, które wszystko spina

Nie „naprawiam” środowiska.
Ja je opisuję, a system pilnuje spójności.
