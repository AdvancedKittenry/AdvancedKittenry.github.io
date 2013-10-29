% Tietokantaohjelmoinnin aloittaminen

<wip />

## Tietokannan alustustiedostojen luominen

Muistele Tietokantojen perusteet -kurssilla oppimaasi SQL-kieltä ja tutustu valitsemasi tietokannan dokumentaatioon.
Luo sitten repositorioosi sql-kansio ja sijoita siihen kolme sql-tiedostoa:
`create-tables.sql`, `drop-tables.sql` ja `add-test-data.sql`.
Kirjoita näihin tiedostoihin tietokantasi alustavat create table -lauseet, drop table -lauseet, ja testidatan (oletuskäyttäjätunnusten yms.) luominen.

SQL-lauseiden sijoittaminen tiedostoihin mahdollistaa kannan helpon
pystyttämisen ja alasajon. 
Voit ajaa sql-tiedostoon kantaan kirjautumalla usersille
ja käyttämällä unixin _putkitusta_. Esimeriksi PostgreSQL:llä tämä tapahtuu seuraavasti:

~~~~
psql < sql/create-tables.sql
~~~~


Yllä oleva komento suorittaa tiedoston sisältämät SQL-lauseet
tietokannassa. MySQL-versio on samantapainen, mutta komentona on psql:n
sijasta mysql, minkä lisäksi mysql kysyy sinulta salasanaa.

Mikäli haluaa resetoida koko tietokantansa voi ajaa seuraavat kolme komentoa peräkkäin:

~~~~
psql < sql/drop-tables.sql
psql < sql/create-tables.sql
psql < sql/add-test-data.sql
~~~~

Tiedostossa `drop-tables.sql` kannattaa käyttää pudotuskäskystä
muotoa `DROP TABLE IF EXISTS taulun_nimi`. 
Näin tietokantataulun puuttuminen ei katkaise komentosarjaa. 
Viiteavaimien takia joudut myös yleensä kirjoittamaan pudotuskäskyt päinvastaisessa
järjestyksessä luontilauseisiin nähden. Muuten viite-eheystarkistukset eivät välttämättä anna ajaa kantaa alas.

## Linkkejä

* [MySql:n dokumentaatio](http://dev.mysql.com/doc/refman/5.1/en/index.html)
* [PostgreSql:n dokumentaatio](http://www.postgresql.org/docs/8.4/interactive/index.html)

<vinkki title="Vinkki: Käytä hakukonetta">

Usein on huomattavasti helpompaa etsiä hakukoneella 
jotain tiettyä tietokannan ominaisuutta hakusanoilla tyyliin
`autogenerate id mysql` tai `data types postgres`
kuin koettaa etsiä niitä käsin tietokannan sivuilta.
</vinkki>
