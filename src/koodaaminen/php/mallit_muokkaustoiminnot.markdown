% Malliluokat ja tiedon muuttaminen
<!-- order: 6 -->

<wip />

<summary>
* Malliluokan oliolla kannattaa olla metodi, jolla se osaa syöttää itsensä kantaan (INSERT-lause).
* Päivittämiseen tarvitaan vastaavaa metodia, joka ajaa UPDATE-lauseen
* samoin poistamiselle on tarpeen DELETE-lauseen ajava instanssimetodi.
</summary>

## Mallien rakentaminen

* Tähän on olemassa monia tapoja.
* Selkeä: Joka tietokantataululle oma luokkansa.
    * Jokainen olio edustaa yhtä taulunsa riviä.
    * Poikkeus: liitostauluille ei välttämättä tarvita omaa luokkaansa, mikäli niiden toiminnot voi loogisesti sijoittaa muihinkin luokkiin.
* Luokalla staattisia metodeja, joilla voi hakea olioita eli rivejä kannasta.
    * Voi tehdä myös instassimetodeja, jotka hakevat johonkin olioon liittyviä rivejä toisista tietokantatauluista.
* Tarvitaan myös metodit, joka syöttävät olion kantaan tai päivittävät kannassa olevia tietoja olion perusteella.
    * Näitä mahdollista tehdä ilman oliotakin.
    * Voivat olla staattisia tai instassimetodeja.
* Lopuksi metodi(t), jolla voi poistaa rivejä.
    * Instanssimetodi poistaa kyseisen olion kannasta.
    * Staattisella metodilla voi poistaa useitakin olioita.

### Olion syöttäminen kantaan

* Autogeneroituja id-numeroita (esim. PostgreSQL:n [SERIAL-tietotyyppi](http://www.postgresql.org/docs/9.2/static/datatype-numeric.html#DATATYPE-SERIAL)) varten
olemassa omat kikkansa:
    * PostgreSQL:llä voidaan INSERT-lauseen jälkeen laittaa käsky `RETURNING id`, jolloin kysely palauttaa kentän `id` arvon ikään kuin se olisi SELECT-kysely.
    * MySQL:llä olemassa PHP:llä PDO:n [lastInsertId-metodi](http://php.net/manual/en/pdo.lastinsertid.php).
    * Javalle olemassa [vastaava tekniikka](http://www.technicalkeeda.com/details/how-to-get-mysql-auto-increment-key-value-using-java-jdbc).
    * SERIAL-tyyppiä käytettäessä INSERT-lauseeseen ei laiteta id-avaimelle lainkaan arvoa, jolloin kanta laittaa kenttään seuraavan vapaan arvon.

<comment>
# Tietojen päivittäminen ja poistaminen

<next>
Kun malli on toteutettu, sitä voi käyttää [näkymissä](nakymat.html).
</next>
</comment>
