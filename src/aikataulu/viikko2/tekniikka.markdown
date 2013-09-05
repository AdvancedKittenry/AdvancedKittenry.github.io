% Tietokantojen ja palvelimien käyttöönotto
<!-- order: 6 -->

Nämä ohjeet ovat vielä hieman kesken. Paremman puutteessa voit selailla
alkuperäistä ohjenivaskaa:
  
* [PHP HY/TKTL ympäristössä](http://www.cs.helsinki.fi/u/laine/tikas/php_ohje.html)
* [PHP ja tietokanta](http://www.cs.helsinki.fi/u/ahslaaks/tsoha/tkanta.html)
* [Servlettien käyttö Tietokantasovellusten harjoitustyössä](http://www.cs.helsinki.fi/u/laine/tikas/material/servlet_ohje.html) 
* [Tietokannat Helsingin yliopiston tietojenkäsittelytieteen laitoksella](http://www.cs.helsinki.fi/u/laine/tikas/material/tietokannat.html) (vanhentunut, elä käytä oraclea)

## Tietokannan alustustiedostojen luominen

Muistele Tietokantojen perusteet -kurssilla oppimaasi SQL-kieltä ja tutustu valitsemasi tietokannan dokumentaatioon.
Luo sitten repositorioosi sql-kansio ja sijoita siihen kolme sql-tiedostoa:
<code>create-tables.sql</code>, <code>drop-tables.sql</code> ja <code>add-test-data.sql</code>. Sijoita näihin järjestyksessä tietokantasi create table -lauseet, drop table -lauseet, ja mahdollinen testidata.

SQL-lauseiden sijoittaminen tiedostoihin mahdollistaa kannan helpon
pystyttämisen ja alasajon. Voit ajaa sql-tiedostoon kantaan usersilla, 
käyttämällä unixin _putkitusta_. Esimeriksi PostgreSQL:llä tämä tapahtuu seuraavasti:

~~~~
psql < sql/create-tables.sql
~~~~

Yllä oleva komento suorittaa tiedoston sisältämät SQL-lauseet
tietokannassa. MySQL-versio on samantapainen, mutta komentona on psql:n
sijasta mysql, minkä lisäksi mysql kysyy sinulta salasanaa.

## Palautus

Lopulta palautuksesi kansiorakenteen pitäisi näyttää suurinpiirtein tältä:

~~~~
doc/
  dokumentaatio.pdf
  relaatiotietokantakaavio.dia
  sivukartta.png
  tietosisältökaavio.dia
html/
  index.html
  ...
sql/
  create-tables.sql
  drop-tables.sql
  add-test-data.sql
~~~~

<last>
Varmista vielä, että olet laittanut [tietosisältö- ja relaatiottietokantakaaviot](tietokanta.html), SQL-tiedostot ja [HTML-demoversion](html-versioiden-luonti.markdown) repositorioosi!
</last>
