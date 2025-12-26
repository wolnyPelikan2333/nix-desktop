1️⃣ Pytanie główne

Szukam tekstu — czego użyć?

2️⃣ Drzewko decyzyjne

Czy to repo / wiele plików / katalog?

TAK → rg

NIE → grep

Czy jestem w recovery / initramfs?

TAK → grep

Czy potrzebuję zgodności POSIX / skrypt systemowy?

TAK → grep

3️⃣ Gotowe komendy (minimum)

- rg "pattern"

- rg -n "pattern"

- grep "pattern" file

- grep -R "pattern" .

4️⃣ Sekcja „KIEDY NIE”

❌ Nie używaj grep -R w repo → wolne

❌ Nie używaj rg w initramfs → może nie istnieć

5️⃣ TL;DR (3 linie)

- 90% przypadków → rg

- system / recovery → grep

- nie myśl → użyj rg
