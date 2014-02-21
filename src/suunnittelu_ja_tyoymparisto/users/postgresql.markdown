% PostgreSQL-tietokannan käyttöönotto
<!-- tags: viikko1 -->
<!-- order: 2 -->

PostgreSQL-kannan saat käyttöösi koneessa users.cs.helsinki.fi
skriptillä `wanna-postgres`. 
Ohjelma luo käyttäjätunnuksen ja arpoo salasanan ja kannan käyttöön tarvittavat porttinumerot ja hoitaa muut ympäristöasetukset.
Kun tunnus on luotu voi kantaa käsitellä käyttäen komentotulkkia `psql`. 
Tulkki ei kysy salasanaa, vaan siirtyy suoraan tietokantakomentoriville.

Testaa tulkkia luomalla kantaan muutama testitaulu.
Tulkkia käyttäessä kannattaa varoa, ettei jätä lainausmerkkejä auki:

~~~~
consuegr=> select * from test where t1 = 'asdasd;
consuegr'> 
consuegr'> quit
consuegr'> '
consuegr-> ;
 t1 
 ----
 (0 rows)

~~~~

Huomaa kuinka käyttäjänimen jälkeen tuleva merkki vaihtuu sen mukaan mitä merkkiä tietokantatulkki odottaa seuraavaksi.

<comment> Tätä ei ehkä kannata vielä näyttää:
<info>
Usersilla tietokantayhteyden luomiseen tarvittava uusin PostgreSQL-ajuri löytyy tiedostosta `/usr/local/pgsql-7.4/jdbc.jar`.
Ohjelmassa tarvittava ajuriluokan nimi on org.postgresql.Driver. 
Tietokantayhteyteen tarvittava yhteystunnus on `jdbc:postgresql://localhost/username`. 

PHP:n PDO:lle riittää seuraava hyvin yksinkertainen koodi:

~~~php
<?php $yhteys = new PDO('pgsql:'); ?>
?>
~~~

</info>
</comment>

<next>

Pystytä itsellesi vielä sopivat koodaustyökalut.
Ohjaajien suosituksena on [NetBeansin käyttö](../netbeans/index.html)

</next>
