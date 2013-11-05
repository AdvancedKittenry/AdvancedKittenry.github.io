% Sovelluksen ohjelmointi

Näille sivuille on koottu kaikki itse ohjelmointiin liittyvät ohjeet.
Työn tekeminen kannattaa aloittaa kohdasta
[Tietokantataulujen pystyttäminen](kannan-alustus.html).

## Hakemisto

~~~~ {execute=bash}
find src/ohjeistus/tietokantaohjelmointi/ -iname "*.markdown" | ./make-indexes.py src/ohjeistus/tietokantaohjelmointi/ | tail -n +2 | cut -c 2-
~~~~
