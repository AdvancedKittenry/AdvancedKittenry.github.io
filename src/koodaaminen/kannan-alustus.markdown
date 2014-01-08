% Tietokantataulujen pystyttäminen
<!-- order: 1 -->

<info>
Näissä ohjeissa oletetaan kannan pystyttäminen 
users-palvelimelle, jossa on jo
[otettu tietokantapalvelin käyttöön]({{rootdir}}pystytys/kayttoonotto/index.html).
</info>

Ennen kuin voimme aloittaa kannan käyttämisen, pitää sinne
pystyttää tarvittavat tietokantataulut ja testidataa.
Tämän jälkeen voimme testata saammeko kantaan yhteyden [testisovelluksella](testisovellus.html).

## Tietokannan alustustiedostojen ajaminen

SQL-lauseiden sijoittaminen tiedostoihin mahdollistaa kannan helpon
pystyttämisen ja alasajon. 
Voit ajaa sql-tiedostoon kantaan kirjautumalla usersille
ja käyttämällä unixin _putkitusta_. 

Jos olet laittanut SQL-tiedostosi kansioon sql, ja
käytät PostgreSQL:ää saat tietokantataulut luotua näin:

~~~~
psql < sql/create-tables.sql
~~~~

Yllä oleva komento suorittaa tiedoston sisältämät SQL-lauseet
tietokannassa. MySQL-versio on samantapainen, mutta komentona on psql:n
sijasta mysql, minkä lisäksi mysql kysyy sinulta salasanaa.

Mikäli haluaa resetoida koko tietokantansa voi ajaa seuraavan komennon:

~~~~
cat sql/drop-tables.sql sql/create-tables.sql sql/add-test-data.sql | psql
~~~~

Komento syöttää `cat`:in jälkeen annettujen tiedostojen sisällön yksitellen psql-tietokantakomentotulkille. Näin kanta saadaan ajettua ensin alas, jonka jälkeen luodaan taulut ja lisätään testidata.

<alert>
Viiteavaimien takia joudut yleensä kirjoittamaan pudotuskäskyt päinvastaisessa
järjestyksessä luontilauseisiin nähden. 
Muuten viite-eheystarkistukset eivät välttämättä anna ajaa tietokantatauluja alas.
</alert>

<next>
Saatuasi tietokannan pyörimään voit asentaa sen testaamiseksi [ConnectionTest-testisovelluksen](testisovellus.html)
ja aloittaa [oman tietokantakoodisi tekemisen](tietokantayhteys/index.html).
</next>


