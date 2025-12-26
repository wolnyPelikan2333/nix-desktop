1️⃣ Pytanie główne

Mam tekst — czego użyć: sed czy awk?

2️⃣ Drzewko decyzyjne

Czy tylko zamieniasz / usuwasz / formatujesz tekst?

TAK → sed

Czy liczysz / filtrujesz po warunku / operujesz na kolumnach?

TAK → awk

Czy masz | i chcesz „jednej linijki”?

TAK → sed

3️⃣ Gotowe wzorce — sed (minimum)
sed 's/foo/bar/g'
sed 's/^[[:space:]]*//; s/[[:space:]]*$//'
sed '/^#/d'
sed -n '5,10p'

4️⃣ Gotowe wzorce — awk (minimum)
awk '{print $1}'
awk '$3 > 100'
awk '{sum+=$2} END {print sum}'
awk -F: '{print $1}'

5️⃣ KIEDY NIE

❌ Nie używaj awk do prostych zamian

❌ Nie używaj sed do logiki i liczenia

❌ Jeśli skrypt rośnie → rozbij albo użyj Pythona

6️⃣ TL;DR

tekst → sed

liczby / kolumny → awk

nie myśl → sed
